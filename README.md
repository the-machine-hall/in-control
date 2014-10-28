# INVENTORY CONTROL #

This is a collection of scripts (`expect` and `bash` so far) that allows to control various hardware (=inventory items) by software.

A simple directory structure is used for the inventory which is therefore organized in a tree fashion.

Each item of the inventory can be controlled or contains sub-items that can be controlled. E.g. think about a PDU (item) with controllable power outlets (sub-items).


## How to use ##

1. Download the [tarball] or clone this repository.
2. Create a directory to contain your inventory items.  
   ```
   ~$ mkdir $HOME/inventory && cd $HOME/inventory
   ```
3. Create an item by copying an item template to your inventory.  
   ```
   ~/inventory$ cp ../inventory-control/[...]/item-template my-item
   ```
4. Adapt the configuration to your needs.  
   ```
   ~/inventory$ nano my-item/config/config.[...]
   ```
5. Control your gear by software.  
   ```
   ~$ inventory/my-item/controls/power-on
   ```

[tarball]: https://github.com/the-machine-hall/inventory-control/archive/master.tar.gz


## Usage example ##

A computer that can be powered on via WOL is connected to a power outlet of a PDU:

```
~/inventory$ tree
.
├── my-pdu
│   ├── config
│   │   └── config.tcl
[...]
│   ├── port_02
│   │   ├── config
│   │   │   ├── config.tcl
│   │   │   └── used-by -> ../../../my-computer/
│   │   └── controls
│   │       ├── off -> off.exp
│   │       ├── off.exp
│   │       ├── on -> on.exp
│   │       └── on.exp
[...]
|
├── my-computer
│   ├── config
│   │   ├── config.bash
│   │   └── power-source -> ../../my-pdu/port_02/
│   └── controls
│       ├── power-on -> wol-power-on.bash
│       └── wol-power-on.bash
|
[...]
```

You can "link" items by using symlinks. This way you can easily determine which outlet powers a specific machine or which machine is powered by a specfic outlet. Due to this linkage you can access the controls of a linked item in the context of the currently selected item:

```
~$ inventory/my-computer/config/power-source/controls/on
~$ inventory/my-computer/controls/power-on
```

## License ##

(GPLv3)

Copyright (C) 2014 Frank Scheiner

The software is distributed under the terms of the GNU General Public License

This software is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This software is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a [copy] of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.

[copy]: /COPYING

