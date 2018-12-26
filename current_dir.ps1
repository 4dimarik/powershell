#Текущая директория 
$curDir = $MyInvocation.MyCommand.Path | Split-Path -Parent

#

if (-not (Test-Path -Path "$curDir\TryCatch1.ps1")) {"нету"}