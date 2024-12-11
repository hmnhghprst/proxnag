# Disable Proxmox VE Subscription Nag Script

## Overview

This script is a simple tool designed to disable the subscription nag message in Proxmox VE. It achieves this by modifying a specific file in the system while ensuring all changes are reversible and non-intrusive. A backup of the original file is created automatically.

## Features

* Creates a backup of the proxmoxlib.js file.

* Modifies Proxmox's subscription check logic to bypass the nag screen.

* Updates APT configuration for persistent changes.

* Restarts Proxmox services to apply changes immediately.

## Usage

* Download and save the script as disable_proxmox_nag.sh

* Make the script executable:

```
chmod +x disable_proxmox_nag.sh
```

* Run the script as root:
```
sudo ./disable_proxmox_nag.sh
```

## Notes

* Always review the script before executing it.

* Test in a non-production environment first if possible.

* Reapply the script after Proxmox updates, as updates may overwrite changes.

## Disclaimer

This script is provided "as-is" without any guarantees. Use it at your own risk. Supporting Proxmox through subscription is highly recommended if used in production.

