# We will use destination directory to download and save Java OpenJDK and Maven.
$destination = "C:\Program Files\JAVA"
 
# These are source locations that we will download from.
$javaSource = "https://download.java.net/java/GA/jdk15/779bf45e88a44cbd9ea6621d33e33db1/36/GPL/openjdk-15_windows-x64_bin.zip"
$mavenSource = "https://apache.osuosl.org/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.zip"
 
$javaZip = $destination + "\openjdk.zip"
$mavenZip = $destination + "\maven.zip"
 
# Lets create JAVA folder if not exists.
If(!(test-path $destination))
{
    Write-Output "Creating JAVA destination."
    New-Item -ItemType Directory -Force -Path $destination
}
 
# We start downloading zip files.
[Net.ServicePointManager]::SecurityProtocol = "tls12, tls11, tls"
$client = new-object System.Net.WebClient
Write-Output "Downloading OpenJDK."
$client.DownloadFile($javaSource, $javaZip)
Write-Output "OpenJDK downloaded."
 
Write-Output "Downloading Maven."
$client.DownloadFile($mavenSource, $mavenZip)
Write-Output "Maven downloaded."
 
# Lets extract files and delete zip folder.
Write-Output "Extracting Zip files."
Expand-Archive -LiteralPath $javaZip -DestinationPath $destination
Remove-Item $javaZip
Expand-Archive -LiteralPath $mavenZip -DestinationPath $destination
Remove-Item $mavenZip
Write-Output "Extract completed."
 
# Setting up JAVA_HOME environment variable.
$javaPath = $destination + "\jdk-15"
Write-Output "Adding new JAVA_HOME environment variable."
[Environment]::SetEnvironmentVariable("JAVA_HOME", $javaPath, "Machine")
$newJavaPath = ([Environment]::GetEnvironmentVariable("Path", "Machine") -split ';' |
             Where-Object { $_ -match '\S' }) + "$javaPath\bin" | Select-Object -Unique
[Environment]::SetEnvironmentVariable("Path", ($newJavaPath -join ';'), "Machine")
 
# Setting up M2_HOME environment variable
$mavenPath = $destination + "\apache-maven-3.6.3"
Write-Output "Adding new M2_HOME environment variable."
[Environment]::SetEnvironmentVariable("M2_HOME", $mavenPath, "Machine")
$newMavenPath = ([Environment]::GetEnvironmentVariable("Path", "Machine") -split ';' |
             Where-Object { $_ -match '\S' }) + "$mavenPath\bin" | Select-Object -Unique
[Environment]::SetEnvironmentVariable("Path", ($newMavenPath -join ';'), "Machine")
Write-Output "Job Completed!"