function addInput {
    param (
        $el,
        $groupBox,
        $value,
        $newValue,
        $width,
        $xPoint = 20,
        $height = 20
    )

    $yPoint = $el * 20;

    $label = New-Object System.Windows.Forms.Label
    $label.Location = New-Object System.Drawing.Point($xPoint, $yPoint)
    $label.Size = New-Object System.Drawing.Size($width, $height)
    $label.Text = "Server"

    $textBox = New-Object System.Windows.Forms.TextBox
    $textBox.Location = New-Object System.Drawing.Point($xPoint, ($yPoint + 20))
    $textBox.Size = New-Object System.Drawing.Size($width, $height)   
    $textBox.Text = $value
    $textBox.Enabled = $false;
    $textBox.Padding.Left = 20

    $label1 = New-Object System.Windows.Forms.Label
    $label1.Location = New-Object System.Drawing.Point(($xPoint + 220), $yPoint)
    $label1.Size = New-Object System.Drawing.Size($width, $height)
    $label1.Text = "XML"

    $textBox1 = New-Object System.Windows.Forms.TextBox
    $textBox1.Location = New-Object System.Drawing.Point(($xPoint + 220), ($yPoint + 20))
    $textBox1.Size = New-Object System.Drawing.Size($width, $height)   
    $textBox1.Text = $newValue
    $textBox1.Padding.Left = 20
    
    $groupBox.Controls.Add($label)
    $groupBox.Controls.Add($textBox)
    $groupBox.Controls.Add($label1)
    $groupBox.Controls.Add($textBox1)

    return $groupBox
}