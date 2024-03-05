# eSport app installer
Installation scripts for esport gaming PCs

On a fresh Windows 10 or Windows 11, you need to do the following steps:

1. Open Powershell as Admin

2. In the Powershell window, run the following command "Set-ExecutionPolicy Bypass". This will enable the script to run

3. Download the script file into a folder and navigate to the folder in Powershell

4. Run the script by typing .\installscript.ps1

5. The script will then download the apps.txt file.  

6. Then it will check if Chocolatey is already installed, if it's not installed, it will run the install script to install Chocolatey

7. Just leave the script until it's done. Check the output.

8. Done.


The script can be invoked with the -u parameter to update the apps.txt from Github.
