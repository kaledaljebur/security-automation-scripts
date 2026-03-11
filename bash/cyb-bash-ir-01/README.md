# CYB-BASH-IR-01 Case Study  
## Automated Linux Security Integrity Verification using Bash

This case study demonstrates how Bash scripting can be used to automate basic Linux security auditing and integrity verification. The goal is to detect potential indicators of compromise and system misconfigurations through automated checks.

---

# Scenario

A small organisation operates several Linux servers that host internal services such as web applications, file storage, and authentication systems.

Recently, the organisation became concerned about potential **unauthorised modifications to critical system files**, possible **privilege escalation attempts**, and suspicious scheduled tasks that could indicate **persistence mechanisms used by attackers**.

To improve visibility into system integrity, the security team decides to develop a **Bash-based security auditing script**. The script runs automatically on each server and performs several checks to detect potential security issues.

---

# Objectives

The objectives of this case study are to:

- Automate security checks on Linux systems using Bash
- Detect potential indicators of compromise
- Identify misconfigurations that could lead to privilege escalation
- Generate a report that assists administrators in investigating security issues

The script is scheduled to run daily using **cron**, and the generated report is saved in a secure log directory for review.

---

# Security Checks Performed

## Critical File Integrity Check

The script verifies whether critical system files such as:

- `/etc/passwd`
- `/etc/shadow`
- `/etc/sudoers`

have been modified unexpectedly by comparing their hashes with previously stored baseline hashes.

---

## Permission Verification

The script scans critical directories such as:

- `/etc`
- `/usr/bin`
- `/usr/sbin`
- `/var/www`

to detect files with incorrect or overly permissive permissions, such as **world-writable files**.

---

## SUID / SGID Detection

The script identifies binaries with **SUID** or **SGID** permissions. Misconfigured or malicious SUID/SGID binaries could allow attackers to escalate privileges.

---

## Suspicious Cron Job Detection

The script inspects system and user **cron directories** to identify unexpected scheduled tasks that might indicate attacker persistence.

---

## User Account Audit

The script checks for:

- recently created user accounts
- accounts with **UID 0** (root privileges)
- users with empty password fields

These checks help identify unauthorized or misconfigured accounts.

---

## Running Process Inspection

The script reviews running processes to identify suspicious programs running under unusual users or from uncommon directories.

---

## Security Report Generation

After completing all checks, the script generates a **security audit report** summarising findings and highlighting potential risks that require administrator investigation.

---

# Expected Outcome

Administrators can use the generated report to quickly identify potential security issues, investigate suspicious activity, and maintain the integrity of Linux systems.


---

# Solution 

- [Bash Security Audit Script](./case-study.sh)
- [Script Explanation](./case-study.md)