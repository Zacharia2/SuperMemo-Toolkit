;; 多重引用图块炸开
(defun c:unlk (/ en ent new_ent ss i code valid_codes)
  ; 加载扩展函数
  (vl-load-com)
  
  (princ "\n*** 图块解密工具 ***")
  
  ; 定义有效的DXF组码列表
  (setq valid_codes '(0 2 10 41 42 43 50 8 62 6 210))
  
  ; 允许选择多个对象
  (if (setq ss (ssget '((0 . "INSERT"))))
    (progn
      (setq i 0)
      (repeat (sslength ss)
        (setq en (ssname ss i)
              ent (entget en))
        
        (if (and ent
                 (= (cdr (assoc 0 ent)) "INSERT"))
          (progn
            ; 构建新图块数据，只包含有效且存在的组码
            (setq new_block_data '((0 . "INSERT")))
            
            ; 添加必需的组码（名称和插入点）
            (if (setq code (assoc 2 ent))
              (setq new_block_data (cons code new_block_data))
              (progn
                (princ "\n错误: 图块缺少名称(组码2)")
                (setq i (1+ i))
                (continue)
              )
            )
            
            (if (setq code (assoc 10 ent))
              (setq new_block_data (cons code new_block_data))
              (progn
                (princ "\n错误: 图块缺少插入点(组码10)")
                (setq i (1+ i))
                (continue)
              )
            )
            
            ; 添加其他可选的组码
            (foreach code_num '(41 42 43 50 8 62 6 210)
              (if (setq code (assoc code_num ent))
                (setq new_block_data (cons code new_block_data))
              )
            )
            
            ; 创建新图块
            (setq new_ent (entmakex (reverse new_block_data)))
            
            (if new_ent
              (progn
                ; 分解新图块
                (command "_.explode" new_ent)
                ; 删除原图块
                (entdel en)
                (princ (strcat "\n已解密图块: " (cdr (assoc 2 ent))))
              )
              (princ (strcat "\n错误: 无法创建新图块 " (cdr (assoc 2 ent))))
            )
          )
          (princ "\n错误: 选择的对象不是有效图块")
        )
        (setq i (1+ i))
      )
      (princ (strcat "\n\n操作完成! 共解密 " (itoa i) " 个图块"))
    )
    (princ "\n未选择任何图块或选择取消")
  )
  
  (princ)
)

; 简化的错误处理版本，更稳定
(defun c:unlk-simple (/ en ent new_ent)
  (vl-load-com)
  
  (princ "\n*** 简化版图块解密工具 ***")
  
  (while (setq en (car (entsel "\n选择要解密的图块 (回车退出): ")))
    (setq ent (entget en))
    
    (if (and ent (= (cdr (assoc 0 ent)) "INSERT"))
      (progn
        ; 只使用必需的组码创建新图块
        (setq new_ent 
          (entmakex 
            (list 
              '(0 . "INSERT")
              (assoc 2 ent)    ; 图块名
              (assoc 10 ent)   ; 插入点
              (if (assoc 41 ent) (assoc 41 ent) '(41 . 1.0))  ; X比例，默认为1
              (if (assoc 42 ent) (assoc 42 ent) '(42 . 1.0))  ; Y比例，默认为1
              (if (assoc 43 ent) (assoc 43 ent) '(43 . 1.0))  ; Z比例，默认为1
              (if (assoc 50 ent) (assoc 50 ent) '(50 . 0.0))  ; 旋转角度，默认为0
            )
          )
        )
        
        (if new_ent
          (progn
            (command "_.explode" new_ent)
            (entdel en)
            (princ "\n解密成功!")
          )
          (princ "\n错误: 无法创建新图块")
        )
      )
      (princ "\n错误: 选择的对象不是图块")
    )
  )
  (princ)
)

; 错误处理函数
(defun *error* (msg)
  (if (not (member msg '("Function cancelled" "quit / exit abort" "")))
    (princ (strcat "\n错误: " msg))
  )
  (princ)
)

; 使用说明
(defun c:unlk-help ()
  (princ "\n===== UNLK 使用说明 =====")
  (princ "\nUNLK     - 批量解密多个图块")
  (princ "\nUNLK-SIMPLE - 简化版，逐个解密图块")
  (princ "\nUNLK-HELP - 显示此帮助")
  (princ "\n\n如果遇到错误，请尝试使用 UNLK-SIMPLE 命令")
  (princ)
)