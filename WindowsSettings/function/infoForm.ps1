function infoWindow {
    param (
        $header,
        $text
    )
    $form = New-Object System.Windows.Forms.Form
    $form.Text = $header
    $form.Size = New-Object System.Drawing.Size(500, 200)
    $form.StartPosition = 'CenterScreen'

    $label = New-Object System.Windows.Forms.Label
    $label.AutoSize = $false
    $label.TextAlign = 'MiddleCenter'
    $label.Dock = 'Fill'
    $label.Text = $text
    $label.Font = New-Object System.Drawing.Font("Arial", 10);
    $label.ForeColor = "red"

    $CancelButton = New-Object System.Windows.Forms.Button
    $CancelButton.Location = New-Object System.Drawing.Point(208, 120)
    $CancelButton.Size = New-Object System.Drawing.Size(72, 23)
    $CancelButton.Text = 'OK'
    $CancelButton.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
    $form.CancelButton = $CancelButton
    $form.Controls.Add($CancelButton)

    $form.Controls.Add($label)
    $form.ShowDialog()
    exit
}