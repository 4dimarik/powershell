Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
#Текущая директория 
$curDir = $MyInvocation.MyCommand.Path | Split-Path -Parent

#Основное окно
$form = New-Object System.Windows.Forms.Form
$form.Text = "Применение настроек ОС WIndows"
$form.Size = New-Object System.Drawing.Size(500, 500)
$form.StartPosition = 'CenterScreen'

#Информационное окно
. "$curDir\function\infoForm.ps1"

function addInput {
    param (
        $el,
        $labelText,
        $value,
        $width,
        $xPoint = 20,
        $height = 20
    )

    $groupBox = New-Object System.Windows.Forms.GroupBox
    $groupBox.Location = New-Object System.Drawing.Point(10, 10)
    $groupBox.Size = New-Object System.Drawing.Size(460, 70)
    $groupBox.BackColor = "#989f6c"
    $groupBox.Text = $labelText 

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
    $textBox1.Text = $value
    $textBox1.Padding.Left = 20
    
    $groupBox.Controls.Add($label)
    $groupBox.Controls.Add($textBox)
    $groupBox.Controls.Add($label1)
    $groupBox.Controls.Add($textBox1)
    $form.Controls.Add($groupBox)
    
}

$el = 1

#Загрузка гонфигурации из XML
$fileName = "Config1.xml"
if (Test-Path -Path "$curDir\$fileName") {
    [xml]$xmlfile = Get-Content "$curDir\$fileName"
}
else {
    $infoText = "Отсутствует файл конфигурации:  $curDir\$fileName Выполнение" + [char]160 + "скрипта остановлено!"
    infoWindow "Ошибка" $infoText
}



addInput $el "Computer Name:" $env:COMPUTERNAME 200

$form.Controls.Add($groupBox)

$form.ShowDialog()