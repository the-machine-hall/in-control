# IN(VENTORY) CONTROL #

Remote control makes it possible to e.g. *power on*, *power off* or *reset* machines from virtually everywhere. And many modern but also historic machines feature at least some sort of remote control or can be modified for remote control.

**A problem remains.**

A lot of manufacturers use different and often incompatible remote control systems from a syntax point of view: E.g. there exists RSC, LOM, ALOM, ILOM (all SUN), iLO (HP), iRMC (Fujitsu(-Siemens)) and many more, and most of them use a different syntax, which makes it hard to interact with machines of different manufacturers at the same time.

**See the problem?**

Or can you remotely power on a SUN Fire V240, a HP Proliant DL385 G2, a Fujitsu-Siemens RX200 S3 or a SGI Origin 200 without studiyng the documentation first? And also think about the different connection mechanisms: Do you have to use a network connection and then was it `telnet` or `ssh` you have to use for login or do you have to use a serial connection for this specific machine?

**In-control** tries to solve this dilemma by offering an easy to use and - most important - syntactically identical interface to the remote control functionality of various hardware. I.e. regardless of its manufacturer, if you want to power on a specific server machine, with **in-control** the command is `[...]/machine-1/controls/power-on` or if you want to reset it and the machine supports this action, the command is `[...]/machine-1/controls/reset` and so forth. Or if you need to switch on or switch off a specific power outlet of a PDU, the command is just `[...]/pdu-1/port_01/controls/on` or `[...]/pdu-1/port_01/controls/off`.

This is done by abstracting the remote control functionality of various hardware (= inventory items) with a collection of scripts (written in `expect` and `bash` so far). Each item of the inventory can be controlled or contains sub-items that can be controlled. E.g. think about a PDU (item) with controllable power outlets (sub-items). Necessary configuration values (like IP addresses, serial ports, credentials, etc.) are stored in configuration files. Access to the configuration files can be limited with file system permissions or access control lists (ACLs).

**In-control** uses a simple directory tree for storage of configuration and controls, so you can easily group and subgroup particular items or whole collections of items (e.g. the machines in machine hall #1, all DNS server machines, etc.) by placing or symlinking them in subdirectories:

```
~/inventory$ tree
.
├── dns-servers
│   ├── machine-3 -> ../machine-hall-1/machine-3
│   └── machine-7 -> ../machine-hall-2/machine-7
├── gluster-peers
│   ├── machine-1 -> ../machine-hall-1/machine-1
│   ├── machine-2 -> ../machine-hall-1/machine-2
│   ├── machine-5 -> ../machine-hall-2/machine-5
│   └── machine-6 -> ../machine-hall-2/machine-6
├── machine-hall-1
│   ├── machine-1
│   │   ├── config
│   │   └── controls
│   ├── machine-2
│   │   ├── config
│   │   └── controls
│   ├── machine-3
│   │   ├── config
│   │   └── controls
│   └── machine-4
│       ├── config
│       └── controls
└── machine-hall-2
    ├── machine-5
    │   ├── config
    │   └── controls
    ├── machine-6
    │   ├── config
    │   └── controls
    └── machine-7
        ├── config
        └── controls
```


## How to use ##

1. Download the [tarball] or clone this repository.
2. Create a directory to contain your inventory items.  
   ```
   ~$ mkdir inventory && cd inventory
   ```
3. Create an item by copying an item template to your inventory.  
   ```
   ~/inventory$ cp -rd [...]/in-control/[...]/item-template my-item
   ```
4. Adapt the configuration to your needs.  
   ```
   ~/inventory$ nano my-item/config/config.[...]
   ```
5. Control your gear by software.  
   ```
   ~$ inventory/my-item/controls/power-on
   ```

> **NOTICE:** If your shell supports directory and filename completion, you can simply follow the directory tree and hit the completion key (usually the TAB key) to see your options during traversal.

[tarball]: https://github.com/the-machine-hall/in-control/archive/master.tar.gz


## Usage example ##

A computer that can be powered on via [WOL] is connected to a power outlet of a PDU:

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

You can also "link" items by using symlinks. This way you can easily determine which outlet powers a specific machine or which machine is powered by a specfic outlet. Due to this linkage you can access the controls of a linked item in the context of the currently selected item:

```
~$ inventory/my-computer/config/power-source/controls/on
~$ inventory/my-computer/controls/power-on
```

[WOL]: http://en.wikipedia.org/wiki/Wake-on-LAN

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

