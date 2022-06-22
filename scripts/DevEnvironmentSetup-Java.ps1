# This script will install and setup
#    - Git
#    - Java (Amazon Corretto 11 OpenJDK).
#    - Sets up JAVA_HOME and PATH environment variables.
#    - Maven (v3.8.1).
#    - Sets up M2_HOME and PATH environment variables.
#    - Eclipse IDE for Java Developers (Oxygen).
#    - Visual Studio Code.
#    - Java Test Runner VSCode Extension (testing junit junit4 junit5).
#    - Java Language Support VSCode Extension.
#    - IntelliJ IDEA (Community Edition).
#    Info: You can comment out not needed packages.


# How to use it
#    1. Download the 'DevEnvironmentSetup-Python.ps1' file into 'C:/' drive.
#    2. Open PowerShell as an admin.
#    3. Navigate to C drive 'cd /'.
#    4. Run the script '.\DevEnviromentSetup-Python.ps1'.
#    5. Restart your machine.


Write-Output "***************** Installing Chocolatey *****************"
Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

Write-Output "***************** Installing Git *****************"
choco install git -y

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

Write-Output "***************** Installing Eclipse *****************"
choco install eclipse-java-oxygen -y

Write-Output "***************** Installing VS Code *****************"
choco install vscode -y

Write-Output "***************** Installing VS Code Extensions *****************"
choco install vscode-java -y
choco install vscode-java-test -y

Write-Output "***************** Installing IntelliJ IDEA *****************"
choco install intellijidea-community -y

Write-Output "***************** Installation Completed *****************"