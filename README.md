# Samsung Galaxy Book 4 Fingerprint Fix (Ubuntu)

## Overview

This repository provides a working solution to enable the fingerprint sensor on Samsung Galaxy Book 4 devices running Ubuntu.

The issue is caused by missing support for certain Focaltech fingerprint sensors in the default libfprint package. This repo includes a patched version of libfprint packaged as `.deb` files for easy installation.

---

## Supported Hardware

* Device: Samsung Galaxy Book 4 series
* Fingerprint Sensor: Focaltech
* USB ID: `2808:6553`

To verify your device:

```bash
lsusb
```

If you see `2808:6553`, this fix applies to your system.

---

## Problem

On Ubuntu, the fingerprint sensor is:

* Not detected
* Not supported by default `libfprint`

As a result:

* `fprintd-enroll` shows no devices
* Fingerprint login does not work

---

## Solution

This repository provides:

* Patched `libfprint` with Focaltech support
* Prebuilt `.deb` packages
* Simple installation script

---

## Installation

### 1. Clone the repository

```bash
git clone https://github.com/ishashanknigam/libfprint-focaltech-ubuntu.git
cd libfprint-focaltech-ubuntu
```

### 2. Run installer

```bash
chmod +x install.sh
./install.sh
```

---

## Setup Fingerprint

After installation:

```bash
fprintd-enroll
fprintd-verify
```

Test with sudo:

```bash
sudo -k
sudo ls
```

---

## What the Installer Does

* Installs required packages (`fprintd`, `libpam-fprintd`)
* Installs patched `libfprint` `.deb` packages
* Updates linker cache (`ldconfig`)
* Restarts fingerprint service

---

## Verification

Check that the correct library is being used:

```bash
ldd /usr/libexec/fprintd | grep fprint
```

Expected output:

```
libfprint-2.so.2 => /usr/lib/x86_64-linux-gnu/libfprint-2.so.2
```

---

## After System Updates (Important)

This setup uses a patched version of `libfprint`, which is not part of official Ubuntu packages.

### What can happen

After running:

```bash
sudo apt upgrade
```

Ubuntu may:

* Replace `libfprint` with the default version
* Break fingerprint functionality

---

### How to prevent it (recommended)

Lock the working version:

```bash
sudo apt-mark hold libfprint-2-2
sudo apt-mark hold fprintd libpam-fprintd
```

---

### If fingerprint stops working

Reinstall the patched version:

```bash
sudo dpkg -i libfprint-2-2_*.deb libfprint-dev_*.deb
sudo ldconfig
sudo systemctl restart fprintd
```

---

### Verify it's working

```bash
ldd /usr/libexec/fprintd | grep fprint
```

Expected output:

```
libfprint-2.so.2 => /usr/lib/x86_64-linux-gnu/libfprint-2.so.2
```

### Notes

* This fix survives reboot automatically
* It may need reinstallation after major updates
---


## Important Notes

* This is **experimental support**
* Not officially included in upstream libfprint
* May break after system updates
* Works best on Ubuntu 22.04 / 24.04

---

## Known Limitations

* Suspend/resume may affect fingerprint reliability
* Kernel updates may break compatibility
* Hardware support is incomplete upstream

---

## Rollback

To revert to the original Ubuntu version:

```bash
sudo apt install --reinstall libfprint-2-2
sudo systemctl restart fprintd
```

---

## Source / Credits

* Based on upstream libfprint development work
* Focaltech support patch (unmerged)
* Thanks to contributors working on reverse-engineering support

---

## Contributing

If you have:

* fixes
* improvements
* support for other devices

Open a pull request or issue.

---

## Disclaimer

This project modifies system libraries.
Use at your own risk.

---

## Author

Maintained by: Shashank
