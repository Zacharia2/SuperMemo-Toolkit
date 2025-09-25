Add-Type -AssemblyName System.Windows.Forms

$form = New-Object System.Windows.Forms.Form
$form.Size = New-Object System.Drawing.Size(75, 100)
$form.Text = 'CopyTTS'
$form.TopMost = $true
$form.ControlBox = $true
$form.FormBorderStyle = 'FixedDialog'
$form.MaximizeBox = $false
$form.MinimizeBox = $false
$form.StartPosition = 'Manual'

$height = [System.Windows.Forms.Screen]::PrimaryScreen.WorkingArea.Height - $form.Height
$form.Location = New-Object System.Drawing.Point(0, $height);

$button = New-Object System.Windows.Forms.Button
$button.Text = 'Play'
$button.Size = New-Object System.Drawing.Size(50, 50)
$buttonX = ($form.ClientSize.Width - $button.Width) / 2
$buttonY = ($form.ClientSize.Height - $button.Height) / 2
$button.Location = New-Object System.Drawing.Point($buttonX, $buttonY)

$button.Add_Click({
        $button.Text = 'Playing'
        $Content = Get-Clipboard
        edge-playback -t @"
$Content
"@
        $button.Text = 'Play'
    })

$form.Controls.Add($button)
$form.ShowDialog()
