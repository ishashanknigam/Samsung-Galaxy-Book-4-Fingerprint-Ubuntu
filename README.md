# Samsung Galaxy Book 4 Fingerprint Fix (Ubuntu)

## Supported Hardware
- Focaltech fingerprint sensor (USB ID: 2808:6553)

## Problem
Fingerprint does not work on Ubuntu due to missing libfprint support.

## Solution
This repo provides a patched libfprint package with Focaltech support.

This repository provides:

* Patched `libfprint` with Focaltech support
* Prebuilt `.deb` packages
* Simple installation script

---

## Automatic Permissions Fix

This installer automatically configures system permissions using polkit.

Without this, you may see:
PermissionDenied: Not Authorized

## Installation

### 1. Clone the repository

```bash
git clone https://github.com/YOUR_USERNAME/libfprint-focaltech-ubuntu.git
cd libfprint-focaltech-ubuntu
chmod +x install.sh
./install.sh
