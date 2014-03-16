## Installation ##

Run `sudo -E profile=work|home|laptop ./dotfiles install` to install all
configuration file for specified profile.

### tt4 specific: laptop ###

Additional packages installed:
* laptop-mode-tools (https://aur.archlinux.org/packages/laptop-mode-tools/); see NOTE below
* acpi-eeepc-generic (https://aur.archlinux.org/packages/acpi-eeepc-generic/)

NOTE: for Asus Super Hybrid Engine (watafak wiz da name?) to work it's also required eeepc_laptop kernel module to be loaded. For now it is disabled by default. Grub option <code>acpi_osi=Linux</code> can be used to enable it (see https://bugs.archlinux.org/task/17616).

## Agreements ##

Directory structure is the same that under home dir (~/). Exception is rootfs/
directory, that contains global system configuration files that are located
in /.

All missing directories would be created.
All missing files would by symlinked.

If filename ends on `.template`, than same file without `.template` would be
created and all `{{PLACEHOLDER}}` strings in that file would be replaced with
user prompted values.

If filename ends on `.$placeholder`, then `placeholder=value` should be specified
as environment variable on invokation of `./dotfiles.sh` (see usage for more info),
and file, that ends on specified `.value` would be symlinked. Example: if
there are files:

* xorg.conf.$profile,
* xorg.conf.laptop,
* xorg.conf.work,
* xorg.conf.home,

then `$profile` variable would be requested and filename, that evaluated from
`xorg.conf.$profile` would be symlinked into `xorg.conf`.
