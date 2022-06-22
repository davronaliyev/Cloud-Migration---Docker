# This script will install and setup
#    - Git
#    - Docker Desktop
#    - Ubuntu 20.04
#    - Python
#    - Setup User Variable Path for Python
#    - Java (Amazon Corretto 11 OpenJDK)
#    - Setup JAVA_HOME and PATH environment variables
#    - Maven (v3.8.1)
#    - Setup M2_HOME and PATH environment variables
#    - Visual Studio Code
#    - VSCode Extension
#    - IntelliJ IDEA (Community Edition)


# How to use it
#    1. Download the 'DevEnvironmentSetup.ps1' file into 'C:/' drive
#    2. Open PowerShell as an admin
#    3. Navigate to C drive 'cd /'
#    4. Run the script '.\DevEnviromentSetup-Python.ps1'
#    5. Restart your machine


#   Chocolatey
Write-Output "***************** Installing Chocolatey *****************"
Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

#   Git
Write-Output "***************** Installing Git *****************"
choco install git -y

#   Docker Desktop
Write-Output "***************** Installing Docker Desktop *****************"
choco install docker-desktop -y
  
Write-Output "***************** Installing Ubuntu *****************"
choco install wsl-ubuntu-2004 -y

#   Python
Write-Output "***************** Installing Python *****************"
choco install python -y 
Write-Output "***************** Setting User Variable Path for Python *****************"
$pythonDestination = $env:userprofile + "\AppData\Local\Programs\Python\Python39;"
[Environment]::SetEnvironmentVariable("Path", $pythonDestination + $env:Path, [EnvironmentVariableTarget]::User)
Write-Output "***************** Setting User Variable Path for Python Scripts *****************"
$pythonScriptsDestination = $env:userprofile + "\AppData\Local\Programs\Python\Python39\Scripts;"
$newPath = ([Environment]::GetEnvironmentVariable("Path", "User"))
[Environment]::SetEnvironmentVariable("Path", $pythonScriptsDestination + $newPath, [EnvironmentVariableTarget]::User)

#   Java and Maven
Write-Output "***************** Installing Java and Maven *****************"
# We will use destination directory to download and save Java OpenJDK and Maven.
$destination = "C:\Program Files\JAVA"
# These are source locations that we will download from.
$javaSource = "https://corretto.aws/downloads/latest/amazon-corretto-11-x86-windows-jdk.zip"
$mavenSource = "https://apache.claz.org/maven/maven-3/3.8.1/binaries/apache-maven-3.8.1-bin.zip" 
$javaZip = $destination + "\openjdk.zip"
$mavenZip = $destination + "\maven.zip" 
# Lets create JAVA folder if not exists.
$javaDestination = $destination + "\jdk11.0.10_9"
$mavenDestination = $destination + "\apache-maven-3.8.1"
If (!(Test-Path $destination)) {
    Write-Output "Creating JAVA destination."
    New-Item -ItemType Directory -Force -Path $destination
}
else {
    Write-Output "$destination folder is already exist."
}
If (!(Test-Path $javaDestination)) {
    # We start downloading zip files.
    [Net.ServicePointManager]::SecurityProtocol = "tls12, tls11, tls"
    $client = new-object System.Net.WebClient
    Write-Output "Downloading Amazon Corretto 11 OpenJDK."
    $client.DownloadFile($javaSource, $javaZip)
    Write-Output "OpenJDK downloaded."
    Write-Output "Extracting Zip files."
    Expand-Archive -LiteralPath $javaZip -DestinationPath $destination
    Remove-Item $javaZip
}
else {
    Write-Output "$javaDestination folder is already exist."
}
If (!(Test-Path $mavenDestination)) {
    Write-Output "Downloading Maven."
    $client.DownloadFile($mavenSource, $mavenZip)
    Write-Output "Maven downloaded."
    Expand-Archive -LiteralPath $mavenZip -DestinationPath $destination
    Remove-Item $mavenZip
    Write-Output "Extract completed."
}
else {
    Write-Output "$mavenDestination folder is already exist."
}
# Setting up JAVA_HOME environment variable.
$javaPath = $destination + "\jdk11.0.10_9"
Write-Output "Adding new JAVA_HOME environment variable."
[Environment]::SetEnvironmentVariable("JAVA_HOME", $javaPath, "Machine")
$newJavaPath = ([Environment]::GetEnvironmentVariable("Path", "Machine") -split ';' |
    Where-Object { $_ -match '\S' }) + "$javaPath\bin" | Select-Object -Unique
[Environment]::SetEnvironmentVariable("Path", ($newJavaPath -join ';'), "Machine") 
# Setting up M2_HOME environment variable
$mavenPath = $destination + "\apache-maven-3.8.1"
Write-Output "Adding new M2_HOME environment variable."
[Environment]::SetEnvironmentVariable("M2_HOME", $mavenPath, "Machine")
$newMavenPath = ([Environment]::GetEnvironmentVariable("Path", "Machine") -split ';' |
    Where-Object { $_ -match '\S' }) + "$mavenPath\bin" | Select-Object -Unique
[Environment]::SetEnvironmentVariable("Path", ($newMavenPath -join ';'), "Machine")
Write-Output "Java and Maven Installation Completed!"

#   VS Code
Write-Output "***************** Installing VS Code *****************"
choco install vscode -y

Write-Output "***************** Installing VS Code Extensions *****************"
choco install vscode-java -y
choco install vscode-java-test -y
choco install vscode-python -y
choco install vscode-docker

#   IntelliJ
Write-Output "***************** Installing IntelliJ IDEA *****************"
choco install intellijidea-community -y

Write-Output "***************** Installation Completed *****************"