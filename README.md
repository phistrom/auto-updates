# Auto-Updates

Automatic update scripts for RouterOS 6. Set these scripts up as scheduled 
tasks to check for a new update, and perform the reboots necessary to install 
the packages and the new firmware.

## Usage
Add the content of update-packages.rsc and/or update-firmware.rsc as new 
scripts on your RouterOS device. Run a scheduled task to execute
```routeros
/system script run update-packages
```
whenever you want to check for updates. If there is a new update, it is 
downloaded and installed, and your router will immediately reboot.
Create a scheduled task that runs at startup to execute
```routeros
/system script run update-firmware
```
to make the router check if its current firmware needs to be updated. If it 
does need to be updated, the router will reboot. This means that when package 
updates are installed, the router will reboot twice so that the packages and 
the firmware match.
