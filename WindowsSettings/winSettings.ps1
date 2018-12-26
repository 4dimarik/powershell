Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
#������� ���������� 
$curDir = $MyInvocation.MyCommand.Path | Split-Path -Parent

#�������� ����
$form = New-Object System.Windows.Forms.Form
$form.Text = "���������� �������� �� WIndows"
$form.Size = New-Object System.Drawing.Size(500, 500)
$form.StartPosition = 'CenterScreen'

#�������������� ����
. "$curDir\function\infoForm.ps1"

#�����
. "$curDir\function\inputLine.ps1"

#groupBox
. "$curDir\function\groupBox.ps1"

#�������� ������������ �� XML
$fileName = "Config.xml"
if (Test-Path -Path "$curDir\$fileName") {
    [xml]$xmlfile = Get-Content "$curDir\$fileName"
}
else {
    $infoText = "����������� ���� ������������:  $curDir\$fileName ����������" + [char]160 + "������� �����������!"
    infoWindow "������" $infoText
}

$Color = 'Empty'

$Properties = $xmlfile.computerProperties.server | Where-Object id -eq "S1"
#
# Computer Name:
#
$Global:lastHeight = 10

& {
    if ($env:COMPUTERNAME -ne $Properties.computerName) {$Color = "#ff8080"} else {$Color = "#989f6c"}
    $groupBox = groupBox $form.ClientSize.Width $Color "Computer Name:" $Global:lastHeight
    $div = addInput 1 $groupBox $env:COMPUTERNAME $Properties.computerName 200
    $form.Controls.Add($div)
    $Global:lastHeight += $div.ClientSize.Height
}

#
# Ethernet
#
& {
    foreach ($eth in $Properties.Ethernet) {
        $groupBox = groupBox $form.ClientSize.Width $Color $eth.InterfaceAlias $Global:lastHeight
        try {
            Get-NetIPInterface -AddressFamily IPv4 -InterfaceAlias $eth.InterfaceAlias -ErrorAction Stop >$null
        }
        catch [Microsoft.PowerShell.Cmdletization.Cim.CimJobException] {
            $infoText = "����������� ��������� � ������ " + $eth.InterfaceAlias
            infoWindow "������" $infoText           
        }
        $div = addInput $el $groupBox $eth.InterfaceAlias $eth.newInterfaceAlias 200
        $form.Controls.Add($div)
    }
}



$form.ShowDialog()
