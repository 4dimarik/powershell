function groupBox {
    param (
        $formWidth,
        $Color,
        $labelText,
        $yPoint
    )
    $groupBox = New-Object System.Windows.Forms.GroupBox
    $groupBox.Location = New-Object System.Drawing.Point(10, $yPoint)
    $groupBox.Size = New-Object System.Drawing.Size(($formWidth - 20), 70)
    if ($Color -ne 'Empty') {$groupBox.BackColor = $Color}    
    $groupBox.Text = $labelText

    return $groupBox
}



     