# power-controllable-machine #

This is for machines that have no remote control build in but (can) remember their power state when power is removed. They automatically power on as soon as power is provided again. This also works for machines that have a power switch instead of a power button.

## Configuration ##

Configuration is done by creating a symlink to an existing PDU port where the respective machine is connected to in `./config` named `power-source`. Afterwards the respective machine can be controlled as usual using the control scripts in `./control`. Only `power-on` and `power-off` are supported. Alternatively the machine can also be controlled by using the controls of the PDU port throufh the symlink. 

## Requirements ##

You need a PDU or at least one remote controllable power outlet with in-control support for this to work.

Machines that support this method of power on:

* Silicon Graphics Indy
* Silicon Graphics Octane/Octane 2
* Sun Blade 100
* Sun Ultra 10
* Sun Ultra 80
* HP xw9400
* HP J5600
* HP c3700
* Digital AlphaStation 200 4/166
* Digital AlphaStation 255 300
* Digital Personal Workstation 500au
* [...]
