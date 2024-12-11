#!/usr/bin/env bash
# Disable the Subscription Nag in Proxmox VE 
# Author: HOOMAAN HAGHPARAST
# Version 1.0 (2024-12)

user_notice(){

    local mode="$1"
    local data="$2"

    RD=$(echo "\033[01;31m")
    YW=$(echo "\033[33m")
    GN=$(echo "\033[1;92m")
    CL=$(echo "\033[m")
    BFR="\\r\\033[K"
    HOLD="-"
    CM="${GN}✓${CL}"
    CROSS="${RD}✗${CL}"

    if [[ -z "$data" ]]; then
        echo "ERR - No data for User Notice"
        return
    fi

    case "$mode" in
        info)
            echo -e " ${HOLD} ${YW}${data}..."
            ;;
        ok)
            echo -e "${BFR} ${CM} ${GN}${data}${CL}"
            ;;
        error)
            echo -e "${BFR} ${CROSS} ${RD}${data}${CL}"
            ;;
        header)
            echo -e "${BFR} ${GN}${data}${CL}"
            ;;
    esac
        
}

user_notice header "------------------------------------------"
user_notice header "Proxmox VE Disable Subscription Nag"
user_notice header "Author: HOOMAAN HAGHPARAST"
user_notice header "Version 1.0 (2024-12)"
user_notice header "------------------------------------------"

cp /usr/share/javascript/proxmox-widget-toolkit/proxmoxlib.js /usr/share/javascript/proxmox-widget-toolkit/proxmoxlib.js.bak
user_notice ok "Generate Backup from proxmoxlib.js in /usr/share/javascript/proxmox-widget-toolkit/proxmoxlib.js.bak"

if [[ ! -f /etc/apt/apt.conf.d/99proxnonag ]]; then
    sed -i '/checked_command: function(orig_cmd) {/a\    orig_cmd();\n    return;' /usr/share/javascript/proxmox-widget-toolkit/proxmoxlib.js
    echo "DPkg::Pre-Invoke {\"sed -i '/checked_command: function(orig_cmd) {/a\    orig_cmd();\n    return;' /usr/share/javascript/proxmox-widget-toolkit/proxmoxlib.js\";};" >/etc/apt/apt.conf.d/99proxnonag
    apt --reinstall install proxmox-widget-toolkit &>/dev/null
    user_notice ok "Proxmoxlib configured successfully , proxnag-disable added to apt.conf.d and proxmox-widget-toolkit reinstalled"
fi

user_notice info "System will try to restart pveproxy.service"

systemctl restart pveproxy.service

if systemctl is-active --quiet pveproxy.service; then
    user_notice ok "pveproxy.service is running."
else
    user_notice error "pveproxy.service is not running."
fi

user_notice ok "All Done"

