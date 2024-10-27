# Secure Boot

### Creating keys
```console
# sbctl create-keys
```
installs to /etc/secureboot by default

### Checking that your machine is ready for Secure Boot enforcement
```console
# sbctl verify
```

It is expected that the files ending with `bzImage.efi` are _not_ signed.

### Entering Secure Boot Setup Mode

#### Thinkpad
1. Security > Secure Boot
2. Set "Secure Boot" to enabled
3. Select "Reset to Setup Mode".
4. Save and Exit

### Enroll Keys
```console
# sbctl enroll-keys --microsoft
```

Installing Microsoft keys avoids boot issues with certain hardware

