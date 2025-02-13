// Summary //

function Summary() {
	let category_field = "规格型号"
	let summary_field = "总重（kg)"
	let up_or_down = "below"
	let fill_field = ["B:C", "L:M"]
	let invert_is_summary = false

	group_and_summary(category_field, summary_field, up_or_down)
	fill_empty_cells(fill_field, up_or_down)
	remove_reference()
	remove_redundant(category_field, invert_is_summary)
}

function group_and_summary(category_field, summary_field, up_or_down_option) {
	ActiveSheet.UsedRange.Select()
	let category_column_number = loc_column_from_name(category_field)
	let summary_column_number = loc_column_from_name(summary_field)
	// Warrning: 第一行必须是字段行。
	if (up_or_down_option === "above") {
		Selection.Subtotal(category_column_number, xlSum, Array(summary_column_number), true, false, xlSummaryAbove);
	}
	else if (up_or_down_option === "below") {
		Selection.Subtotal(category_column_number, xlSum, Array(summary_column_number), true, false, xlSummaryBelow)
	} else {
		throw null
	}

	Range("A1").Select();
}
function fill_empty_cells(fill_field, fill_up_or_down = true) {
	ClearCellsFormats()
	fill_field = fill_field.join(",")
	Range(fill_field).Select()

	let empty_cells_arry = []
	let rngIntersection = Application.Intersect(ActiveSheet.UsedRange, Selection)
	//Console.log(rngIntersection.Count)
	for (let cell of rngIntersection) {
		if (cell.Text === "") {
			empty_cells_arry.push(cell.Address())
		}
	}
	let empty_rng = empty_cells_arry.join(", ")
	let first_empty_cell = Range(empty_cells_arry[0])
	Range(empty_rng).Select();
	first_empty_cell.Activate();

	if (fill_up_or_down) {
		let target_cell = first_empty_cell.Offset(-1, 0).Address().replace(/\$/g, '')
		Selection.Formula = `=${target_cell}`;
	} else {
		let target_cell = first_empty_cell.Offset(1, 0).Address().replace(/\$/g, '')
		Selection.Formula = `=${target_cell}`;
	}
	AddCellsFormats()
}

function remove_reference() {
	ActiveSheet.Cells.Select();
	ActiveSheet.Cells.Copy();
	ActiveSheet.Cells.PasteSpecial(xlPasteValues, xlPasteSpecialOperationNone, false, false);
	Application.CutCopyMode = false;
	Range("A1").Select();
}

function remove_redundant(category_field, invert_is_summary) {
	let rng = ActiveSheet.UsedRange
	//	let category_field = "规格型号"
	//	let invert_option = true
	// Warrning: 第一行必须是字段行。
	let del_rows
	if (invert_is_summary) {
		rng.AutoFilter(loc_column_from_name(category_field), "*汇总");
		del_rows = `2:${rng.Rows.Count}`
		Rows.Item(del_rows).Select();
		Selection.Delete(xlShiftUp);
	} else {
		rng.AutoFilter(loc_column_from_name(category_field), "<>*汇总*");
		del_rows = `2:${rng.Rows.Count}`
		Rows.Item(del_rows).Select();
		Selection.Delete(xlShiftUp);
	}
	ClearOutline()
	ShowAllDataAndScrollTop()
}

function loc_column_from_name(fieldName) {
	let rngIntersection = Application.Intersect(ActiveSheet.UsedRange, Rows.Item("1:5"))
	for (let cell of rngIntersection) {
		if (cell.Text === fieldName) {
			// Console.log(cell.Column)
			return cell.Column
		}
	}
}

function ShowAllDataAndScrollTop() {
	ActiveSheet.ShowAllData();
	ActiveWindow.ScrollRow = 3;
}

function ClearCellsFormats() {
	Cells.Select();
	Cells.ClearFormats();
	Range("A1").Select()
}

function AddCellsFormats() {
	ActiveSheet.UsedRange.Select();
	const borders = [
		Selection.Borders.Item(xlEdgeLeft),
		Selection.Borders.Item(xlEdgeTop),
		Selection.Borders.Item(xlEdgeBottom),
		Selection.Borders.Item(xlEdgeRight),
		Selection.Borders.Item(xlInsideVertical),
		Selection.Borders.Item(xlInsideHorizontal)
	];
	const setBorderProperties = (border) => {
		border.Weight = xlThin;
		border.LineStyle = xlContinuous;
		border.ColorIndex = xlColorIndexAutomatic;
		border.TintAndShade = 0;
	};
	borders.forEach(setBorderProperties);
	Selection.HorizontalAlignment = xlHAlignCenter;
	Range("A1").Select()
}

function ClearOutline() {
	Cells.Select();
	Selection.ClearOutline();
	Range("A1").Select()
}

function Sort1() {
    const sheet = ActiveSheet;
    sheet.Sort.SortFields.Clear();
    sheet.Sort.SortFields.Add(Range("B2:B377"), xlSortOnValues, xlAscending, "", undefined);
    sheet.Sort.SortFields.Add(Range("C2:C377"), xlSortOnValues, xlAscending, "", undefined);
    sheet.Sort.SortFields.Add(Range("D2:D377"), xlSortOnValues, xlAscending, "", undefined);
    sheet.Sort.SortFields.Add(Range("L2:L377"), xlSortOnValues, xlAscending, "", undefined);
    sheet.Sort.Header = xlYes;
    sheet.Sort.Orientation = xlSortColumns;
    sheet.Sort.MatchCase = false;
    sheet.Sort.SortMethod = xlPinYin;
    sheet.Sort.SetRange(sheet.UsedRange);
    sheet.Sort.Apply();
}

// 整理tekla导出清单 //

function trimUsedRange() {
	// for (const cell of ActiveSheet.UsedRange) {
	// 	if (typeof (cell.Value2) !== 'undefined') {
	// 		cell.Value2 = String(cell.Value2).trim()
	// 	}
	// }
	for (let i = 1; i <= ActiveSheet.UsedRange.Count; i++) {
		let trimmedText = String(ActiveSheet.UsedRange.Item(i).Value2).trim()
		if (trimmedText !== "undefined") {
			ActiveSheet.UsedRange.Item(i).Value2 = trimmedText
		}
	}
}

function orgnaize_table_headers() {
	Range("1:4, 6:6").Select();
	Selection.Delete(xlShiftUp);
	Range("A1").Select();
}

function delete_blank_rows(fieldName) {
	let rng = ActiveSheet.UsedRange
	let blank_row_int = loc_column_from_name(fieldName) // 5
	rng.AutoFilter(blank_row_int, Array(""), xlFilterValues, undefined, undefined);
	Rows.Item(`2:${rng.Rows.Count}`).Select();
	Selection.Delete(xlShiftUp);
	ActiveWindow.ScrollRow = 1;
	ActiveSheet.ShowAllData();
}

function moveColumn() {
	let origin = "F:F"
	let target = "D:D"
	Columns.Item(origin).Select();
	Selection.Cut(undefined);
	Columns.Item(target).Select();
	ActiveSheet.Select(false);
	Selection.Insert(xlShiftToRight, undefined);
}

// ActiveSheet.Cells.Select();
// ActiveSheet.Cells.AutoFilter(undefined, undefined, xlAnd, undefined, undefined);

//	填充

// 清理第二空白行，零件号为空的行，需要填充后才能执行这一步
// 重用delete_blank_rows即可。

// TODO:自定义创建表头