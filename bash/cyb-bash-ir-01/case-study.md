# CYB-BASH-IR-01
## Case Study: Automated Linux Security Integrity Verification

<!-- # ==========================================================
# Case Code: CYB-BASH-IR-01
# Case Study: Automated Linux Security Integrity Verification
# Tested in Kali
# https://github.com/kaledaljebur/security-automation-scripts
# ========================================================== -->

This case study demonstrates how Bash scripting can be used to perform a **basic security audit and integrity verification on a Linux system**.

The script checks critical system files, permissions, suspicious binaries, user accounts, running processes, network listeners, and authentication logs. It also creates a **baseline hash** for important system files to detect tampering.

Tested in: Kali Linux

Repository:
https://github.com/kaledaljebur/security-automation-scripts

---

# 1. Purpose of the Script

The script simulates a lightweight **incident response and security audit tool** that can help detect:

- File integrity changes
- Misconfigured file permissions
- Suspicious world-writable files
- Privileged SUID/SGID binaries
- Persistence mechanisms (cron jobs)
- Suspicious user accounts
- Unusual running processes
- Network services listening on the system
- Failed login attempts

It produces a **security audit report stored in a log file**.

---

# 2. Script Safety Setting

```bash
set -u
```

This instructs Bash to treat **undefined variables as errors**.  
It prevents mistakes caused by accidentally using variables that were never defined.

---

# 3. Initial System Information

The script collects metadata for the audit report.

```bash
DATE="$(date '+%Y-%m-%d %H:%M:%S')"
HOSTNAME="$(hostname)"
```

These values identify:

- when the audit ran
- which system generated the report

---

# 4. Report and Baseline Directories

Two directories are created:

```bash
REPORT_DIR="./security_reports"
BASELINE_DIR="./security_baseline"
```

Purpose:

| Directory | Purpose |
|---|---|
| security_reports | Stores generated audit reports |
| security_baseline | Stores baseline integrity hashes |

Directories are created automatically using:

```bash
mkdir -p
```

---

# 5. Critical Files for Integrity Monitoring

The script monitors important Linux security files.

```bash
CRITICAL_FILES=(
    "/etc/passwd"
    "/etc/shadow"
    "/etc/sudoers"
    "/etc/group"
)
```

These files control:

- user accounts
- password storage
- sudo privileges
- group membership

Attackers often modify them to gain persistence or escalate privileges.

---

# 6. Sensitive Paths to Scan

The script scans high-risk directories.

```bash
SENSITIVE_PATHS=(
    "/etc"
    "/usr/bin"
    "/usr/sbin"
    "/var/www"
)
```

These locations contain:

- system configuration
- executable binaries
- web server files

They are commonly targeted during attacks.

---

# 7. Logging Functions

Two helper functions simplify logging.

### log()

Writes messages to the terminal and to the report file.

```bash
log() {
    echo "$1" | tee -a "$REPORT_FILE"
}
```

### section()

Creates visible section headers inside the report to improve readability.

---

# 8. Root Execution Check

Function:

```bash
check_root()
```

Some checks require administrative privileges.

The script verifies if it is running as root.

- If not root -> warning is logged
- If root -> full audit can run

---

# 9. Report Initialization

Function:

```bash
init_report()
```

Creates the report file and writes:

- report title
- host name
- date

Each run generates a **timestamped report file**, for example:

```
security_reports/security_audit_20260120_101455.log
```

---

# 10. Critical File Integrity Check

Function:

```bash
create_or_check_baseline()
```

This is the **core integrity monitoring mechanism**.

### First run

The script creates a **baseline SHA256 hash** for each monitored file.

Example:

```
/etc/passwd -> stored baseline hash
```

### Later runs

The script compares:

```
current file hash
vs
stored baseline hash
```

If they differ:

```
[ALERT] Integrity change detected
```

This may indicate:

- privilege escalation
- unauthorized account creation
- malicious modification

---

# 11. Sensitive File Permission Check

Function:

```bash
check_sensitive_permissions()
```

Checks permissions and ownership of:

```
/etc/passwd
/etc/shadow
/etc/sudoers
```

Example output:

```
permissions=640 owner=root
```

Incorrect permissions can expose password data or enable privilege escalation.

---

# 12. World-Writable File Detection

Function:

```bash
find_world_writable_files()
```

Searches for files writable by **any user**.

Command used:

```
find -perm -0002
```

World-writable files are dangerous because attackers may:

- modify executables
- inject malicious code
- escalate privileges

---

# 13. SUID and SGID Binary Detection

Function:

```bash
find_suid_sgid()
```

Searches the system for privileged binaries.

| Permission | Meaning |
|---|---|
| SUID | program runs with owner privileges |
| SGID | program runs with group privileges |

Attackers sometimes hide malicious binaries using these permission bits.

---

# 14. Cron Persistence Check

Function:

```bash
check_cron_persistence()
```

Cron jobs are frequently abused for persistence.

The script inspects locations such as:

```
/etc/cron.d
/etc/cron.daily
/etc/cron.weekly
/var/spool/cron
```

Unexpected scheduled tasks may indicate:

- malware persistence
- hidden backdoors

---

# 15. User Account Audit

Function:

```bash
audit_user_accounts()
```

The script checks for suspicious user accounts.

### Accounts with UID 0

UID 0 represents **root privileges**.

Any unexpected UID 0 account is a major security risk.

### Accounts with interactive shells

These accounts can log in to the system.

### Accounts with empty password fields

Accounts without passwords may allow unauthorized access.

---

# 16. Running Process Analysis

Function:

```bash
check_running_processes()
```

Lists the **top CPU-consuming processes**.

This helps identify:

- cryptominers
- suspicious background programs
- malware activity

---

# 17. Network Listener Detection

Function:

```bash
check_network_listeners()
```

Lists active listening services using:

```
ss
```

or

```
netstat
```

This reveals:

- open ports
- running services
- associated processes

Unexpected listeners may indicate compromise.

---

# 18. Failed Login Detection

Function:

```bash
check_failed_logins()
```

Searches authentication logs for failed login attempts.

Possible log locations:

```
/var/log/auth.log
/var/log/secure
```

Repeated failures may indicate:

- brute force attacks
- password guessing attempts

---

# 19. Audit Summary

Function:

```bash
final_summary()
```

Counts results in the report:

- OK entries
- warnings
- alerts

Example:

```
[SUMMARY] OK entries: 18
[SUMMARY] Warnings: 2
[SUMMARY] Alerts: 1
```

The final report location is also displayed.

---

# 20. Script Execution Flow

The `main()` function controls the execution order.

```bash
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
```

Execution starts with:

```
main
```

---

# 21. Example Use Cases

This script can be used for:

- Linux security lab exercises
- security automation demonstrations
- incident response practice
- Bash scripting training
- baseline integrity monitoring

---

# 22. Limitations

This script demonstrates how security auditing tasks can be automated using Bash. 
Scripts like this are commonly used in real environments to collect system information, 
perform integrity checks, and send results to monitoring or analysis systems.

However, large enterprise environments typically integrate these types of checks 
into centralized security platforms that provide additional capabilities such as 
centralized logging, real-time alerting, correlation analysis, and large-scale 
deployment across many systems.

Examples of such platforms and tools include:

- AIDE
- Wazuh
- OSSEC
- Tripwire
- auditd
---

# 23. Learning Outcomes

This case study demonstrates the following concepts:

- Bash security automation
- Linux file integrity verification
- common Linux privilege escalation risks
- basic persistence mechanisms (e.g., cron jobs)
- basic incident response techniques

---

# End of CYB-BASH-IR-01 Case Study

