#Текущая директория
$currentDir=$MyInvocation.MyCommand.Path | Split-Path -Parent
#Путь к файлу конфигурации
$mqscFile=$currentDir+"\src\mz_11_config.mqsc"
#Чтение содержимого файла
$mqsc=gc "D:\SynologyDrive\git\powershell\src\mz_11_config.mqsc"

#Обьявление переменных
$setObjProp=$false
$obj=@{}
$objTypeList="QLOCAL", "QREMOTE", "LISTENER", "CHANNEL"

#Функции

function printObj($obj){
    switch ( $obj.type )
    {
        QLOCAL {
            $file=$currentDir+"\$qmname\qlocal.html"

            if ($obj.USAGE -eq "XMITQ") {            
                "<tr>`n" +
                "<td rowspan='8'>" + $obj.NAME+"</td>`n" +
                "<td rowspan='8'>transmission</td>`n" +
                "<td>DEFPSIST</td><td>"+$obj.DEFPSIST+"</td></tr>`n" +
                "<tr><td>MAXDEPTH</td><td>"+$obj.MAXDEPTH+"</td></tr>`n" +
                "<tr><td>MAXMSGL</td><td>"+$obj.MAXMSGL+"</td></tr>`n" +
                "<tr><td>TRIGGER</td><td>ON</td></tr>`n" +
                "<tr><td>TRIGTYPE</td><td>"+$obj.TRIGTYPE+"</td></tr>`n" +
                "<tr><td>TRIGDPTH</td><td>"+$obj.TRIGDPTH+"</td></tr>`n" +
                "<tr><td>TRIGDATA</td><td>"+$obj.MAXMSGL+"</td></tr>`n" +
                "<tr><td>INITQ</td><td>"+$obj.MAXMSGL+"</td></tr>`n" | Out-File $file -Append
            }

            if ($obj.USAGE -eq "NORMAL") {
                "<tr>`n" +
                "<td rowspan='3'>" + $obj.NAME+"</td>`n" +
                "<td rowspan='3'>local</td>`n" +
                "<td>DEFPSIST</td><td>"+$obj.DEFPSIST+"</td></tr>`n" +
                "<tr><td>MAXDEPTH</td><td>"+$obj.MAXDEPTH+"</td></tr>`n" +
                "<tr><td>MAXMSGL</td><td>"+$obj.MAXMSGL+"</td></tr>`n" | Out-File $file -Append
            
            }
            
        }
        QREMOTE {
            $file=$currentDir+"\$qmname\qlocal.html"
                "<tr>`n" +
                "<td rowspan='4'>" + $obj.NAME+"</td>`n" +
                "<td rowspan='4'>remote queue</td>`n" +
                "<td>DEFPSIST</td><td>"+$obj.DEFPSIST+"</td></tr>`n" +
                "<tr><td>XMITQ</td><td>"+$obj.XMITQ+"</td></tr>`n" +
                "<tr><td>RNAME</td><td>"+$obj.RNAME+"</td></tr>`n" +
                "<tr><td>RQMNAME</td><td>"+$obj.RQMNAME+"</td></tr>`n" | Out-File $file -Append
            
        }
        CHANNEL {
            $file=$currentDir+"\$qmname\channel.html"
                "<tr>`n" +
                "<td rowspan='3'>" + $obj.NAME+"</td>`n" +
                "<td rowspan='3'>" + $obj.CHLTYPE+"</td>`n" +
                "<td>BATCHSZ</td><td>"+$obj.BATCHSZ+"</td></tr>`n" +
                "<tr><td>HBINT</td><td>"+$obj.HBINT+"</td></tr>`n" +
                "<tr><td>MAXMSGL</td><td>"+$obj.MAXMSGL+"</td></tr>`n" | Out-File $file -Append
            
        }
    }
}

function checkObjtype ($name, $type){
    foreach ($t in $objTypeList) {
        if ($type -eq $t -and -not $name.StartsWith("SYSTEM") ) {
        return $true  
        }
    }
    

}

#Построчный перебор
$i=1;
foreach ($str in $mqsc) {
    if ($str.StartsWith("* QMNAME")){
        $str=[regex]::replace($str,"[* +'\r]",'')
        $qmname=$str.Split("(,)")[1]
        md $currentDir"\$qmname"
        "<table lang='en'>`n<tr lang='ru'><th>Наименование</th><th>Тип</th><th colspan=2>Параметры</th></tr>`n" | Out-File "$currentDir\$qmname\qlocal.html"
        "<table lang='en'>`n<tr lang='ru'><th>Наименование</th><th>Тип</th><th colspan=2>Параметры</th></tr>`n" | Out-File "$currentDir\$qmname\channel.html"
        }
    if ($str.StartsWith("DEFINE")){
        if ($setObjProp){
            printObj $obj
            $obj=@{}
        }
        $obj.type=$str.Split(" ,(,'")[1]
        $obj.NAME=$str.Split(" ,(,',)")[4]
        if (checkObjtype $obj.name $obj.type) { $setObjProp=$true } else { $setObjProp=$false }
        if ($str.StartsWith("DEFINE CHANNEL")) { $obj.CHLTYPE=$str.Split(" ,(,',)")[8] }
        continue;
    }
    if ($setObjProp) {
        $str=[regex]::replace($str,"[* +'\r]",'')
        $objArray=$str.Split(" ,(,),',*")
        $obj.($objArray[0])=$objArray[1]
    }

$i++
}
