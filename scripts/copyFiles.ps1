$SourceFile = "C:\MyFolder\.local-prod10.yml"
$DestinationFile = "C:\MyFolder\.local-prod10.yml"

if (Test-Path $DestinationFile) {
    $i = 0
    While (Test-Path $DestinationFile) {
        $i += 1
        $DestinationFile = "C:\MyFolder\.local-prod$i.yml"
    }
} Else {
    New-Item -ItemType File -Path $DestinationFile -Force
}

Copy-Item -Path $SourceFile -Destination $DestinationFile -Force