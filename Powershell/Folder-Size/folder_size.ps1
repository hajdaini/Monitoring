# @Author : AJDAINI Hatim
# @GitHub : https://github.com/Hajdaini

$folder = $args[0]

$folderSizeOutput = "{0:N2}" -f ( ( Get-ChildItem $folder -Recurse -Force | Measure-Object -Property Length -Sum ).Sum / 1GB )
$folderSizeOutput = $folderSizeOutput -replace "\s", ""
write-host "Espace utilise" $folderSizeOutput "GB | used=${folderSizeOutput}GB"
exit 0;
