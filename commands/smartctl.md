# `smartctl`

[***Table of Contents***](/README.md)

Notes [on the Arch wiki page](https://wiki.archlinux.org/title/S.M.A.R.T.).

### S.M.A.R.T. 

S.M.A.R.T. (Self-Monitoring, Analysis, and Reporting Technology) is a
supplementary component built into many modern storage devices through which
devices monitor, store, and analyze the health of their operation. Statistics
are collected (temperature, number of reallocated sectors, seek errors...)
which software can use to measure the health of a device, predict possible
device failure, and provide notifications on unsafe values. 

### Enabling & Testing

The `smartmontools` package contains two programs for analyzing and monitoring
storage devices: `smartctl`, `smartd`, and a database update utility
`update-smart-drivedb`.

To see if SMART is available and enabled on a storage device:

```bash
smartctl --info /dev/<device> | grep 'SMART support is:'
# SMART support is: Available - device has SMART capability.
# SMART support is: Enabled
```

If SMART is available but not enabled, you can enable it: 

```bash
smartctl --smart=on /dev/<device>
```

E.g., specifying `--device=ata` tells `smartctl` that the device type is ATA,
and this prevents `smartctl` from issuing SCSI commands to that device.

There are three types of self-tests that a device can execute:

- Short: runs tests that have a high probability of detecting device problems;
- Extended or Long: the test is the same as the short check but with no time
limit and with complete disk surface examination;
- Conveyance: identifies if damage incurred during transportation of the
device;
- Selective: tests a range of LBA (logical block addressing, a scheme for
specifying the location of data blocks on disks)

`-c` prints which tests a device supports and the approximate execution time of
each test:

```bash
smartctl -c /dev/sda
# ...
# Short self-test routine
# recommended polling time:        (   1) minutes.
# Extended self-test routine
# recommended polling time:        (  74) minutes.
# Conveyance self-test routine
# recommended polling time:        (   2) minutes.
# ...
```

`-t` to run a test:

```bash
smartctl -t short /dev/device
smartctl -t long /dev/device
smartctl -t conveyance /dev/device
smartctl -t select,123+345 /dev/device
```

To view a list of recent test results:

```bash
smartctl -l selftest /dev/device
```

`-H` to view a device's health. If the device reports failing health status,
this means either that the device has already failed, or that it is predicting
its own failure within the next 24 hours. If this happens, use `-x` to get more
information, and get your data off the disk and to someplace safe as soon as
you can.

```bash
smartctl -H /dev/device
```

`-x` to view detailed information about a device:

```bash
smartctl -x /dev/device
```

### `smartd`

`smartd` is a service that monitors SMART statuses. Refer to the wiki or the
man page:

```bash
man 8 smartd
```
