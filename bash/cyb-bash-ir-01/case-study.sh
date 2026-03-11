#!/bin/bash

# ==========================================================
# Case Code: CYB-BASH-IR-01
# Case Study: Automated Linux Security Integrity Verification
# Tested in Kali
# https://github.com/kaledaljebur/security-automation-scripts
# ==========================================================

set -u

DATE="$(date '+%Y-%m-%d %H:%M:%S')"
HOSTNAME="$(hostname)"
REPORT_DIR="./bash/cyb-bash-ir-01/security_reports"
BASELINE_DIR="./bash/cyb-bash-ir-01/security_baseline"
REPORT_FILE="$REPORT_DIR/security_audit_$(date '+%Y%m%d_%H%M%S').log"

CRITICAL_FILES=(
    "/etc/passwd"
    "/etc/shadow"
    "/etc/sudoers"
    "/etc/group"
)

SENSITIVE_PATHS=(
    "/etc"
    "/usr/bin"
    "/usr/sbin"
    "/var/www"
)

mkdir -p "$REPORT_DIR"
mkdir -p "$BASELINE_DIR"

log() {
    echo "$1" | tee -a "$REPORT_FILE"
}

section() {
    echo >> "$REPORT_FILE"
    echo "==================================================" | tee -a "$REPORT_FILE"
    echo "$1" | tee -a "$REPORT_FILE"
    echo "==================================================" | tee -a "$REPORT_FILE"
}

check_root() {
    section "1. EXECUTION CONTEXT CHECK"
    if [ "$EUID" -ne 0 ]; then
        log "[WARNING] This script is not running as root."
        log "[WARNING] Some checks may be incomplete."
    else
        log "[OK] Script is running as root."
    fi
}

init_report() {
    echo "Linux Security Audit Report" > "$REPORT_FILE"
    echo "Host: $HOSTNAME" >> "$REPORT_FILE"
    echo "Date: $DATE" >> "$REPORT_FILE"
    echo >> "$REPORT_FILE"
}

create_or_check_baseline() {
    section "2. CRITICAL FILE INTEGRITY CHECK"

    for file in "${CRITICAL_FILES[@]}"; do
        if [ -e "$file" ]; then
            safe_name="$(echo "$file" | sed 's#/#_#g')"
            baseline_file="$BASELINE_DIR/${safe_name}.sha256"
            current_hash="$(sha256sum "$file" 2>/dev/null | awk '{print $1}')"

            if [ ! -f "$baseline_file" ]; then
                echo "$current_hash" > "$baseline_file"
                log "[BASELINE CREATED] $file"
            else
                baseline_hash="$(cat "$baseline_file")"
                if [ "$current_hash" = "$baseline_hash" ]; then
                    log "[OK] No change detected in $file"
                else
                    log "[ALERT] Integrity change detected in $file"
                fi
            fi
        else
            log "[WARNING] File not found: $file"
        fi
    done
}

check_sensitive_permissions() {
    section "3. SENSITIVE FILE PERMISSION CHECK"

    for file in /etc/passwd /etc/shadow /etc/sudoers; do
        if [ -e "$file" ]; then
            perms="$(stat -c '%a' "$file" 2>/dev/null)"
            owner="$(stat -c '%U' "$file" 2>/dev/null)"
            log "[INFO] $file | permissions=$perms | owner=$owner"
        else
            log "[WARNING] Missing sensitive file: $file"
        fi
    done
}

find_world_writable_files() {
    section "4. WORLD-WRITABLE FILE CHECK"

    found=0
    for path in "${SENSITIVE_PATHS[@]}"; do
        if [ -d "$path" ]; then
            results="$(find "$path" -xdev -type f -perm -0002 2>/dev/null)"
            if [ -n "$results" ]; then
                found=1
                log "[ALERT] World-writable files found in $path:"
                echo "$results" | tee -a "$REPORT_FILE"
            fi
        fi
    done

    if [ "$found" -eq 0 ]; then
        log "[OK] No world-writable files found in monitored paths."
    fi
}

find_suid_sgid() {
    section "5. SUID/SGID BINARY CHECK"

    log "[INFO] Searching for SUID/SGID files. This may take a moment..."
    results="$(find / -xdev \( -perm -4000 -o -perm -2000 \) -type f 2>/dev/null)"

    if [ -n "$results" ]; then
        log "[INFO] SUID/SGID files detected:"
        echo "$results" | tee -a "$REPORT_FILE"
    else
        log "[OK] No SUID/SGID files found."
    fi
}

check_cron_persistence() {
    section "6. CRON AND PERSISTENCE CHECK"

    cron_paths=(
        "/etc/crontab"
        "/etc/cron.d"
        "/etc/cron.daily"
        "/etc/cron.hourly"
        "/etc/cron.weekly"
        "/etc/cron.monthly"
        "/var/spool/cron"
        "/var/spool/cron/crontabs"
    )

    for path in "${cron_paths[@]}"; do
        if [ -e "$path" ]; then
            log "[INFO] Found: $path"
            ls -la "$path" 2>/dev/null | tee -a "$REPORT_FILE"
            echo >> "$REPORT_FILE"
        fi
    done
}

audit_user_accounts() {
    section "7. USER ACCOUNT AUDIT"

    log "[INFO] Accounts with UID 0:"
    awk -F: '($3 == 0) {print $1 ":" $3 ":" $7}' /etc/passwd | tee -a "$REPORT_FILE"

    echo >> "$REPORT_FILE"
    log "[INFO] Accounts with interactive shells:"
    awk -F: '($7 ~ /bash|sh|zsh|ksh/) {print $1 ":" $7}' /etc/passwd | tee -a "$REPORT_FILE"

    echo >> "$REPORT_FILE"
    log "[INFO] Accounts with empty password field in /etc/shadow:"
    awk -F: '($2 == "") {print $1}' /etc/shadow 2>/dev/null | tee -a "$REPORT_FILE"
}

check_running_processes() {
    section "8. RUNNING PROCESS CHECK"

    log "[INFO] Top running processes:"
    ps aux --sort=-%cpu | head -n 15 | tee -a "$REPORT_FILE"
}

check_network_listeners() {
    section "9. NETWORK LISTENER CHECK"

    if command -v ss >/dev/null 2>&1; then
        ss -tulpn 2>/dev/null | tee -a "$REPORT_FILE"
    elif command -v netstat >/dev/null 2>&1; then
        netstat -tulpn 2>/dev/null | tee -a "$REPORT_FILE"
    else
        log "[WARNING] Neither ss nor netstat is available."
    fi
}

check_failed_logins() {
    section "10. FAILED LOGIN CHECK"

    if [ -f /var/log/auth.log ]; then
        grep -i "failed password" /var/log/auth.log 2>/dev/null | tail -n 20 | tee -a "$REPORT_FILE"
    elif [ -f /var/log/secure ]; then
        grep -i "failed password" /var/log/secure 2>/dev/null | tail -n 20 | tee -a "$REPORT_FILE"
    else
        log "[WARNING] No supported authentication log found."
    fi
}

final_summary() {
    section "11. AUDIT SUMMARY"

    alerts_count="$(grep -c '\[ALERT\]' "$REPORT_FILE" 2>/dev/null || true)"
    warnings_count="$(grep -c '\[WARNING\]' "$REPORT_FILE" 2>/dev/null || true)"
    ok_count="$(grep -c '\[OK\]' "$REPORT_FILE" 2>/dev/null || true)"

    log "[SUMMARY] OK entries: $ok_count"
    log "[SUMMARY] Warnings: $warnings_count"
    log "[SUMMARY] Alerts: $alerts_count"
    log "[SUMMARY] Report saved to: $REPORT_FILE"
}

main() {
    init_report
    check_root
    create_or_check_baseline
    check_sensitive_permissions
    find_world_writable_files
    find_suid_sgid
    check_cron_persistence
    audit_user_accounts
    check_running_processes
    check_network_listeners
    check_failed_logins
    final_summary
}

main