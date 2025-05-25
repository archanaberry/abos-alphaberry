# abos-alphaberry

The first public implementation of **Archana Berry OS**, powered by a hybrid kernel called **BBsh (BlueberryBush)** — a fusion of **Nano**, **Exo**, and **RN** kernel models.  
This public release is only available up to the final version **1.10.10.10_stable, codename: AlphaBerry**.

<div style="display: flex; align-items: center;">
  <img src="archanaberry/logo.png" alt="Logo OS" style="width: 400px; height: auto;">
  <img src="archanaberry/mascot.png" alt="Maskot" style="width: 400px; height: auto; margin-left: 10px;">
</div>

---

## Overview

**Archana Berry OS (ABOS)** is a lightweight, modular, and runtime-driven operating system designed with hybrid execution in mind — combining the best of scripting runtime, high-performance binary execution, and virtualization for general purpose, embedded, and low-latency systems.

This version, `abos-alphaberry`, introduces the first full implementation of the BBsh kernel, runtime orchestration system, and execution model based on BEFB (Berry Executable File Binary) and ABRT (Archana Berry Runtime).

---

## Features

### Kernel: BBsh (BlueberryBush)
- Hybrid kernel model combining:
  - **Nano**: super-minimal execution core.
  - **Exo**: micro/modular extension support.
  - **RN**: (runtime native kernel for bridging interface abrt to kernel access lowlevel) real-time multitasking and message-passing.
- Supports monolithic-like style and modular execution units.

### Executable Formats
- **ABP**: Standard application packages (GUI, CLI).
- **XABP**: Scripting/Compiled abs script to bytecode runtime applications with ABI links.
- **ABPI**: Installer packages for apps, system components, and drivers.
- **BEFB (BEX)**: Core low-latency system binaries.
- All formats are managed and executed by `abrt` runtime orchestrator.

### Runtime: ABRT (Archana Berry Runtime)
- JIT & interpreter hybrid runtime for `.abs` scripts.
- Native interface to ABP/XABP/ABPI executables.
- Comes in 5 runtime profiles:
  1. **Overslim Girl Blueberry's** – Full CLI, no GUI.
  2. **Slim Girl Blueberry's** – Lightweight GUI + CLI.
  3. **Normal Girl Blueberry's** – Standard GUI experience.
  4. **Matture Maid Girl Blueberry's** – Server & service oriented.
  5. **Fatted Girls Blueberry's** – Complete runtime bloated with all modules.

### Scripting: Archana Berry Script (.abs)
- TypeScript-inspired language designed for fast scripting and system automation.
- Compiles Just-In-Time or interpreted via ABRT.
- Uses `.bjsn` (Berry JSON) as manifest format for modules and packages.

### Package & Process System

- **ABPM**: Berry Package Manager to install, upgrade, and remove packages such as `.abpi`, `.abp`, `.xabp`, `.abs`, `.abdll`, `.absll`, "`.befb` or berry binary", "`.abrtcr` runtime component module" and system modules.

- **ABTP (Archana Berry Token Process)**: A secure capatible, prefix-based token identification system for all running processes. Each process is assigned a unique and traceable token name with specific prefixes based on type:

  | Token Prefix        | Description                                |
  |---------------------|--------------------------------------------|
  | `ab_p<token>`       | Standard runtime native application (GUI/CLI)         |
  | `ab_xp<token>`      | Raw abs script runtime packaged application (precompiled or ABI-bound) |
  | `ab_xpc<token>`     | Fully compiled abs from XABP binary bytecode for efficienty abrt execute abs compiled package                | 
  | `befb_<token>`      | Core system-level binary berry executable (BEFB/BEX)        |
  | `ab_i<token>`       | Installer process from `.abpi` package     |
  | `abs_<token>`       | Script process executed from `.abs` files  |
  | `abd_<token>`       | Driver daemon loaded in abrt          |
  | `abrt_cr<token>`    | ABRT core component module                 |
  | `abrt_sv<token>`    | ABRT service (e.g., GUI manager, IPC router, etc.) |

- **Features of ABTP**:
  - Uniquely traceable tokens for better process auditing.
  - Token visibility using `archanaberry --showtokenproc list`.
  - Designed for modular kernel/runtime separation and better debugging.
  - Used internally by `ABRT`, `ABTTY`, and `ABVM` for sandboxing and IPC validation.
  - Enables process-level isolation, kill, and restart controls by token such as PID.
  - Debugable stacktrace token for internal environment.

- **Example Token Output**:

```
ab\_p3893129    => GUI Notes App
ab\_xp2104821   => Raw binary utility
ab\_xpc7781134  => Compiled graphical tool
befb\_0001941   => Core system command (sysinfo)
ab\_i1120391    => Installer for BerryClock.abpi
abs\_8834212    => Running script: disk\_clean.abs
abd\_2849112    => Network card driver daemon
abrt\_cr00001   => ABRT minimal runtime core
abrt\_sv00013   => ABRT GUI compositor bridge
```

- ABTP works across all runtime modes (Overslim to Fatted Girls Blueberry's) and ensures consistency between GUI/CLI environments, runtime containers, and driver spaces.

### Virtualization and GUI
- **ABVM**: Archana Berry Virtual Machine layer for process isolation and containment.
- **BerryX11**: Lightweight GUI compositor.
- **BerryDE**: Default desktop environment with component-based loading.
- **BerryWM**: Window manager managed by ABRT.

### Driver & System
- Drivers in `.abd` format, executed by ABRT in ring 3.
- Hot-pluggable and auto-installable via ABPI.
- Fully userspace-safe, sandboxed driver execution.
- Fast syscall-based communication to runtime — near kernel-level latency (~0.3µs to 0.7µs).

### Boot Modes & CLI
- Boot into ABBL-only mode for pure CLI: `reboot2oabblnative`.
- Multitab terminal support via **ABTTY**: `Alt + Arrow` or `Alt + 0-9`.
- Supports live inits: `archanaberry init mindrv`, `minrt`, `mincom`.

---

## Versioning System

ABOS version format:
Version: codename-000.1.2.3.4_stability-release
Example: `AlphaBerry-000.1.10.10.10_stable-Everberry`  
Where:
- `Codename`
- `000` = Runtime API generation (AlphaBerry)
- `1` = Major OS version
- `10` = Minor system improvement
- `10` = Update version
- `10` = Patch number
- `stable` = stability level (alpha, beta, stable, etc.)
- `release (release cycle)` = `LTS` = `Everberry`, `LTSC/LTSB` = `PreservedBerry`, `Beta/RC` = `UnripeBerry`, etc...

ABOS adapts conventional software release terms (such as LTS, LTSC, RC) using **plant and berry-inspired themes** to reflect its unique character:

| **Common Term**         | **ABOS Term Name** | **Symbolic Meaning**                                                            |
| ----------------------- | ---------------- | --------------------------------------------------------------------------------- |
| **LTS**                 | `Everberry`      | From "Evergreen" + Berry. A stable release that stays fresh and long-lasting.     |
| **LTSC / LTSB**         | `PreservedBerry` | Like a preserved fruit. Designed for long-term industrial or server environments. |
| **ESR**                 | `HardseedBerry`  | Tough seed. Slow to grow (no new features), but resilient and long-living.        |
| **Stable**              | `RipeBerry`      | Fully matured and ready for public use.                                           |
| **Maintenance-only**    | `WiltedLeaf`     | No longer actively developed, but still receives critical patches.                |
| **Beta / RC**           | `UnripeBerry`    | Not yet mature, still in testing phase.                                           |
| **Nightly / Edge**      | `WildSprout`     | A fast-growing wild sprout. Exciting, but possibly unstable.                      |
| **Rolling Release**     | `VineTrack`      | Like a vine that grows endlessly. Always evolving.                                |
| **Dev / Preview Build** | `BloomTest`      | A freshly blooming flower. Beautiful but not yet fruit-bearing.                   |

---

## Use Cases

- General purpose desktop computing.
- Embedded systems with low memory footprint.
- Real-time systems with tight latency constraints.
- Custom environments with scripting-heavy automation.

---

## Future Plans

- Improved sandbox for `.abs` script host abrt runtime security.
- CLI, TUI, or GUI installer for Archana Berry packages (.abpi).
- Expanded ABRT plugin and extension system.
- Enhanced ABVM with better isolation and snapshot support.

---

## Get Started

1. Build the kernel and runtime using `abncc` or `abcc` (fork of slimcc).
2. Boot using Berry Bootloader or integrate into a VM.
3. Use `archanaberry` CLI to initiate runtime.
4. Use `abpm` to install, unsinstall, or manage package in os (support packages.abpi full offline or online package).
5. Explore `./abscripts/` or `./apps/` folder for sample applications.

---

## Credits

Developed by: Archana Berry  
Licensed: [APBL - Archana Berry Public License](https://github.com/archanaberry/Lisensi)
Warning: Don't make an OS distro for this OS!, inspiration is fine but imitation is prohibited!
