$dir = $MyInvocation.MyCommand.Path | Split-Path -Parent
$ErrorActionPreference = "stop"
try {
    mkdir "$dir\test1" -ErrorAction Stop > $null
    "������ ������� $dir\test1"
}
catch [System.Exception] {
    $Error[0].exception
    exit
}
