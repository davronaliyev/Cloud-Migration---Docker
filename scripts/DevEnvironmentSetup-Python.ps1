# This script will install and setup
#    - Git
#    - Python
#    - Docker Desktop
#    - Visual Studio Code
#    - VS Code Python extension
#    - Sets up User Variable path for Python



# How to use it
#    1. Download the 'DevEnvironmentSetup-Python.ps1' file into 'C:/' drive.
#    2. Open PowerShell as an admin
#    3. Navigate to C drive 'cd /'
#    4. Run the script '.\DevEnviromentSetup-Python.ps1'
#    5. Restart your machine

echo "***************** Installing Chocolatey *****************"
    Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

echo "***************** Installing Git *****************"
    choco install git -y

echo "***************** Installing Python *****************"
    choco install python -y 

echo "***************** Setting User Variable Path for Python *****************"

    $pythonDestination = $env:userprofile + "\AppData\Local\Programs\Python\Python39;"
    [Environment]::SetEnvironmentVariable("Path", $pythonDestination + $env:Path, [EnvironmentVariableTarget]::User)

echo "***************** Setting User Variable Path for Python Scripts *****************"

    $pythonScriptsDestination = $env:userprofile + "\AppData\Local\Programs\Python\Python39\Scripts;"
    $newPath = ([Environment]::GetEnvironmentVariable("Path", "User"))
    [Environment]::SetEnvironmentVariable("Path", $pythonScriptsDestination + $newPath, [EnvironmentVariableTarget]::User)

echo "***************** Installing Docker Desktop *****************"
    choco install docker-desktop -y

echo "***************** Installing VS Code *****************"
    choco install vscode -y

echo "***************** Installing VS Code Extensions *****************"
    choco install vscode-python -y

echo "***************** Installation Completed *****************"