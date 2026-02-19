# Change Detection Audit Tool

*(formerly Tree Chronicle v2 / TreeMapper Next-Gen)*

A lightweight, append-only **filesystem change detection and audit utility** for Windows environments using Git Bash.

This tool continuously answers one question with precision:

> **“What changed in this directory tree since the last time I looked?”**

---

## What It Does

The Change Detection Audit Tool scans a directory tree and produces:

* **Real-time visual change detection**
* **Persistent historical audit logging**
* **Append-only ledger tracking**
* **Human-readable terminal output**
* **Zero destructive operations**

It detects and classifies filesystem events as:

* **NEW** — first time seen
* **RESEEN** — previously observed, still present
* **REMOVED** — previously observed, now missing

All events are recorded permanently in a ledger file.

---

## Key Features

### 1. Visual Change Detection (Terminal Output)

Color-coded, schema-oriented output:

* 🟢 **Green** → Newly detected files or folders
* 🟡 **Yellow** → Re-seen (unchanged, persistent items)
* 🔴 **Red** → Removed files or folders

Large directory trees become instantly readable without manual inspection.

---

### 2. Persistent Audit Ledger (Append-Only)

Every scan appends entries to a ledger file:

```
logs/tree_ledger.csv
```

Each entry records:

* Timestamp
* Path
* Type (FILE / DIR)
* Status (NEW / RESEEN / REMOVED)
* Depth in tree

No overwrites. No deletions. No mutation of historical data.

This makes the tool suitable for:

* Auditing
* Forensics
* Compliance tracking
* Change monitoring
* Environment integrity checks

---

### 3. Tree Visualization with Depth Awareness

The tool reconstructs a tree-style view of the directory structure with:

* Depth-aware indentation
* Status-based coloring
* Clear hierarchical relationships

This allows quick detection of:

* Unexpected directory creation
* Silent file movement
* Structural drift over time

---

### 4. Passive & Non-Destructive

* **Read-only**
* **No file modification**
* **No permission changes**
* **No background services**
* **No scheduled tasks**

The tool only observes and records.

---

## Requirements

### Required

* **Windows**
* **Git Bash**
  Download from: [https://git-scm.com/downloads](https://git-scm.com/downloads)

Git Bash is required to provide:

* `bash`
* `find`
* `awk`
* POSIX-compatible shell behavior

### Optional (Recommended)

* Terminal with ANSI color support (Git Bash default is sufficient)

---

## Installation

1. Install **Git Bash**
2. Place the script in the directory you want to monitor
3. Ensure it is executable (Git Bash):

   ```bash
   chmod +x change-detection-audit-tool.sh
   ```

---

## Usage

Run the script from the directory you want to audit:

```bash
./change-detection-audit-tool.sh
```

On first run:

* All files and folders will be marked **NEW**
* A ledger file will be created automatically

On subsequent runs:

* Existing items → **RESEEN**
* Missing items → **REMOVED**
* New items → **NEW**

---

## Output Files

```
/logs
  └── tree_ledger.csv
```

This file grows over time and represents the complete historical change record of the directory tree.

---

## Scan Summary

At the end of each run, the tool reports:

* Total directories
* Total files
* Maximum directory depth

This provides quick situational awareness for large environments.

---

## Intended Use Cases

* Change monitoring for development directories
* Detecting unauthorized file changes
* System integrity validation
* Project structure tracking
* Lightweight audit trails
* Offline environments
* Frozen or hardened systems

---

## Design Philosophy

* Deterministic
* Transparent
* Append-only
* Human-readable
* Scriptable
* No dependencies beyond Git Bash

This tool is intentionally simple, inspectable, and trustworthy.

---

## License

This tool is provided as-is.
No warranty is expressed or implied.

---

## Final Notes

If you need to know **what changed**, **when it changed**, and **what no longer exists**, without installing heavy monitoring software or agents, this tool does exactly that.

Nothing more. Nothing hidden.