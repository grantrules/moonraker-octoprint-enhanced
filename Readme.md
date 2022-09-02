# Moonraker-OctoPrint-Enhanced

This Moonraker component brings more compatability with the OctoPrint API

This has mainly been built to work with Cura-OctoPrint and run on MainsailOS. This provides function for estimated & remaining time, progress bar, and pause/resume/abort features.

## Installing the component
To install the component you need to connect to your RaspberryPi on which you have Moonraker installed and
execute the following commands:

```
cd ~/
git clone https://github.com/grantrules/moonraker-octoprint-enhanced.git
bash ~/moonraker-octoprint-enhanced/install.sh
```

This will clone the repository and execute the installer script.

> **NOTE:** The script assumes that moonraker is in your home directory under
> "moonraker": `${HOME}\moonraker`.

## Configuration

If you currently have octoprint_compat configured in moonraker.conf, simply replace `[octoprint_compat]` with `[octoprint_enhanced]`, the settings remain the same.

You cannot have both a `[octoprint_compat]` and `[octoprint_enhanced]` section in your config, as they will conflict.

The configuration options are the same as the [`[octoprint_compat]` configuration options](https://github.com/Arksine/moonraker/blob/d04e99a8ecb8ad4e6adfc1e0631644e21cc0778e/docs/configuration.md#octoprint_compat)

## Enable updating with moonraker update manager

This repo can be updated with the update manager of moonraker. To do so 
add following to your 'moonraker.conf' 

```
# moonraker.conf

[update_manager octoprint_enhanced]
type: git_repo
primary_branch: master
path: ~/moonraker-octoprint-enhanced
origin: https://github.com/grantrules/moonraker-octoprint-enhanced.git
managed_services: moonraker
```
