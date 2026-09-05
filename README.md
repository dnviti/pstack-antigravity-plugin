<div align="center">

# 👑 pstack for Antigravity & Gemini

**Autonomous, rigorous engineering workflows, 45 skills, and Poteto Mode for Google Antigravity & Gemini.**

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Antigravity](https://img.shields.io/badge/Platform-Google%20Antigravity-4285F4.svg)](https://deepmind.google/technologies/gemini/)
[![Upstream](https://img.shields.io/badge/Upstream-cursor%2Fplugins%2Fpstack-blueviolet.svg)](https://github.com/cursor/plugins/tree/main/pstack)

</div>

---

## 💡 What is pstack?

`pstack` was created by [Lauren Tan (poteto)](https://x.com/poteto) (React core team, formerly Meta, Netflix, Cursor) to combat AI slop code.

> *"There's a growing sense that AI writes too much slop code. I agree. I don't want to ship like a team of twenty slop artists. Throughput without quality is not a goal I aspire to. If you want to go fast, go deep first."*

This repository ports `pstack` from Cursor to **Google Antigravity & Gemini**, fully adapting its skills, subagents, playbooks, and principles, while adding **permanent, automated execution** so that every single chat turn automatically operates under the Poteto engineering standard.

---

## 🚀 Quickstart (One-Line Installation)

### 🪟 Windows (PowerShell)
Run PowerShell and paste:
```powershell
irm https://raw.githubusercontent.com/dnviti/pstack-antigravity-plugin/main/install.ps1 | iex
```

### 🍎 macOS / 🐧 Linux (Bash)
Run Terminal and paste:
```bash
curl -fsSL https://raw.githubusercontent.com/dnviti/pstack-antigravity-plugin/main/install.sh | bash
```

---

## ⚙️ How It Works in Antigravity

In Cursor, `poteto-mode` can be run with `/poteto-mode`.
In this Antigravity plugin, `pstack` is configured to operate **automatically and continuously** at three levels:

1. **PreInvocation Lifecycle Hook (`hooks.json`)**:
   Runs before every turn, injecting dynamic awareness of active playbooks and principles.
2. **Native Plugin Rules (`rules/AGENTS.md` & `rules/GEMINI.md`)**:
   Enforces automatic playbook selection, verification against runtime evidence, and concise unslopped replies.
3. **Global Machine Rules (`~/.gemini/GEMINI.md`)**:
   Ensures the Poteto engineering lens is active across all workspaces without requiring user prompting.

---

## 📋 The 23 Task Playbooks

Whenever a task is presented, the agent automatically maps it to the right playbook:

| Playbook | Purpose |
| :--- | :--- |
| **Investigation** | Read-only question: how does X work, why was Y built this way, are we sure. |
| **Bug Fix** | Reproduce defect first, root-cause it, fix with runtime evidence. |
| **Feature** | New or changed behavior. Name data shape first per `principle-model-the-domain`. |
| **Refactoring** | Behavior-preserving structural change. |
| **Perf Issue** | Trace measured slowness and improve against a measured baseline. |
| **Hillclimb** | Sustained scientific metric optimization with hypothesis loops. |
| **Runtime Forensics** | Diagnose live symptoms (memory leak, CPU spin) from runtime instrumentation. |
| **Trace Forensics** | Diagnose profiling artifacts (cpuprofile, trace, spindump, heap snapshot). |
| **Prototype** | Throwaway sketch to settle design or behavioral forks empirically. |
| **Visual Parity** | Pixel-exact UI equivalence between implementations. |
| **Autonomous Run** | Drive a long task to completion without stopping. |
| **Babysit** | Drive PR or stack to merge-ready (conflicts, review threads, CI). |
| **Shipping** | Independently verify green stack, then land bottom-up. |
| **Orchestrate** | Multi-day project coordinator across many stacked PRs and subagents. |
| **Session Pickup** | Resume or take over in-flight work from prior agents. |
| **Pause Safely** | Suspend in-flight work cleanly for future resumption. |
| **Figure-it-out** | Bespoke rigorous playbook when no standard playbook fits. |

---

## 🧠 The 21 Core Engineering Principles

- **Laziness Protocol**: Smallest change that solves the problem. Delete before abstracting.
- **Foundational Thinking**: Ground logic in core data structures and types first.
- **Redesign from First Principles**: Design new requirements as if foundational from day one.
- **Subtract Before You Add**: Remove dead weight before building new additions.
- **Minimize Reader Load**: Collapse one-caller wrappers, shrink mutable scope.
- **Model the Domain**: Use state machines, registries, or domain models instead of scattered booleans.
- **Boundary Discipline**: Validate at boundaries; keep domain logic pure.
- **Type System Discipline**: Make illegal states unrepresentable.
- **Prove It Works**: Every change must be verified against real runtime evidence or test execution.
- **Fix Root Causes**: Trace symptoms to underlying source; reproduce before fixing.
- **Sequence Work into Verifiable Units**: Decompose work into small verifiable steps.
- **Guard the Context Window**: Delegate bulky reads to subagents; summarize in the main thread.
- **Never Block on the Human**: Implement quick throwaway probes for reversible forks.

---

## 🛠️ The 45 Workflow Skills Included

`architect`, `arena`, `automate-me`, `blast-radius`, `bro`, `create-verification-skill`, `figure-it-out`, `how`, `interrogate`, `maintain-verification-skill`, `make-bot-ui`, `no-comments`, `poteto-mode`, `principle-boundary-discipline`, `principle-build-the-lever`, `principle-encode-lessons-in-structure`, `principle-exhaust-the-design-space`, `principle-experience-first`, `principle-fix-root-causes`, `principle-foundational-thinking`, `principle-guard-the-context-window`, `principle-laziness-protocol`, `principle-make-operations-idempotent`, `principle-migrate-callers-then-delete-legacy-apis`, `principle-minimize-reader-load`, `principle-model-the-domain`, `principle-never-block-on-the-human`, `principle-outcome-oriented-execution`, `principle-prove-it-works`, `principle-redesign-from-first-principles`, `principle-separate-before-serializing-shared-state`, `principle-sequence-verifiable-units`, `principle-subtract-before-you-add`, `principle-type-system-discipline`, `recall`, `reflect`, `setup-pstack`, `show-me-your-work`, `swarm`, `tdd`, `teach`, `technical-writing`, `typescript-best-practices`, `unslop`, `why`.

---

## 📦 Manual Installation

If you prefer to clone and install manually:

```bash
git clone https://github.com/dnviti/pstack-antigravity-plugin.git
cd pstack-antigravity-plugin
```

**Windows PowerShell:**
```powershell
.\install.ps1
```

**macOS / Linux:**
```bash
chmod +x install.sh
./install.sh
```

---

## 🗑️ Uninstallation

**Windows PowerShell:**
```powershell
.\uninstall.ps1
```

**macOS / Linux:**
```bash
./uninstall.sh
```

---

## 📄 License & Attribution

- Original pstack created by [Lauren Tan (poteto)](https://github.com/cursor/plugins/tree/main/pstack).
- Licensed under the [MIT License](LICENSE).