**File-Delta-Tracker-VS1**

---

## Overview

**File-Delta-Tracker-VS1** is a lightweight, append-only file change detection tool for Windows. It automatically tracks:

* Added files
* Removed files
* Previously seen files

It maintains a **baseline log** for future comparisons, records all changes in a **changelog**, and provides a clear **summary** of each scan.

This tool is ideal for:

* Monitoring project folders for changes
* Tracking file updates in production or development environments
* Detecting unexpected file modifications

---

## Features

* Scans a directory and records:

  * **Added files**
  * **Removed files**
  * **Previously seen files**

* Maintains a **baseline log**

* Generates a **change log** (append-only)

* Displays a **summary** at the start of the scan

* Requires **only Python 3.14+**; no extra packages or dependencies

* Pauses at the end of execution, requiring the user to press **ENTER** to exit

---

## Installation & Execution

1. Ensure **Python 3.14+** is installed.
2. Copy the `file-delta-tracker-vs1.py` script to the folder you want to monitor.
3. **Double-click** the script to run.
4. Review the scan output directly in the window.
5. Press **ENTER** to exit the program.

All logs are stored in the same folder:

* `file-delta-baseline.log` → Baseline of all files
* `file-delta-change.log` → Append-only log of changes

---

## Notes

* The tool **excludes its own log files** from scans.
* Designed for **simplicity and reliability**, with no GUI dependencies.
* To monitor a different directory, move the script to that directory.

---

## Example Output

```
SCAN SUMMARY
============
Timestamp : 2026-01-28 18:45:06
Root Path : D:\Workbench\Sellables

Added     : 0 file(s)
Removed   : 0 file(s)
Seen      : 10 file(s)
==============================
Baseline saved at : D:\Workbench\Sellables\file-delta-baseline.log
Changes logged at : D:\Workbench\Sellables\file-delta-change.log
==============================

ADDED FILES
===========
(none)

REMOVED FILES
=============
(none)

SEEN FILES
==========
* file-delta-tracker-vs1.py
* DEMO 1 change-detection-audit-tool.PNG
* DEMO 2 change-detection-audit-tool.PNG
