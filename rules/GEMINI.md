# Pstack & Poteto Mode Engineering Rules (Automatic & Mandatory)

Antigravity and Gemini agents must operate in **Poteto Mode** (`pstack`) automatically and continuously for every conversation turn and task.

## 1. Automated Lifecycle & Universal Enforcement
- **Universal Activation**:
  - Poteto Mode is ALWAYS active. The user does not need to type `/poteto-mode` or explicitly request it.
  - Every user request, question, bug fix, feature, refactoring, or maintenance task must be automatically evaluated through pstack's engineering lens.
- **Immediate Playbook Routing**:
  - The agent must automatically match the user's task to the appropriate pstack playbook and execute its steps with full rigor:
    - **Investigation** (`playbooks/investigation.md`): Read-only question, how does X work, why was Y built this way, are we sure about Z.
    - **Bug fix** (`playbooks/bug-fix.md`): Reproduce the defect first, root-cause it, fix with runtime evidence.
    - **Feature** (`playbooks/feature.md`): New or changed behavior. Name the data shape first per `principle-model-the-domain`.
    - **Refactoring** (`playbooks/refactoring.md`): Behavior-preserving structural change.
    - **Perf issue** (`playbooks/perf-issue.md`): Trace measured slowness and improve against a measured baseline.
    - **Hillclimb** (`playbooks/hillclimb.md`): Sustained scientific metric optimization with hypothesis loops.
    - **Runtime / Trace Forensics** (`playbooks/runtime-forensics.md`, `playbooks/trace-forensics.md`): Diagnose live runtime symptoms or profiling traces.
    - **Prototype** (`playbooks/prototype.md`): Throwaway sketch to settle design or behavioral forks empirically.
    - **Visual parity** (`playbooks/visual-parity.md`): Pixel-exact UI equivalence.
    - **Autonomous run** (`playbooks/autonomous-run.md`): Long tasks to drive to completion without stopping.
    - **Session pickup / Pause safely** (`playbooks/session-pickup.md`, `playbooks/pause-safely.md`): Clean suspension and resumption of state.
    - **Figure-it-out** (`skills/figure-it-out/SKILL.md`): Bespoke rigorous playbook when no standard playbook fits.

## 2. Core Engineering Principles (Always Active)
Whenever planning or writing code, adhere strictly to the 21 principles:
- **Laziness Protocol** (`principle-laziness-protocol`): Smallest change that solves the problem. Delete before creating abstractions.
- **Foundational Thinking** (`principle-foundational-thinking`): Ground logic in core data structures and types first.
- **Redesign from First Principles** (`principle-redesign-from-first-principles`): Design new requirements as if foundational from day one.
- **Subtract Before You Add** (`principle-subtract-before-you-add`): Remove dead weight before building new additions.
- **Minimize Reader Load** (`principle-minimize-reader-load`): Collapse one-caller wrappers, shrink mutable scope, make code linear.
- **Model the Domain** (`principle-model-the-domain`): Use state machines, registries, or domain models instead of scattered booleans.
- **Boundary Discipline** (`principle-boundary-discipline`): Validate at the boundary; keep domain logic pure.
- **Type System Discipline** (`principle-type-system-discipline`): Make illegal states unrepresentable; brand primitives.
- **Prove It Works** (`principle-prove-it-works`): Every change must be verified against real runtime evidence or test execution, never mere compilation or guesswork.
- **Fix Root Causes** (`principle-fix-root-causes`): Trace symptoms to their underlying source; reproduce before fixing.
- **Sequence Work into Verifiable Units** (`principle-sequence-verifiable-units`): Decompose work into small verifiable steps.
- **Guard the Context Window** (`principle-guard-the-context-window`): Delegate bulky reads and searches to subagents; summarize in the main thread.
- **Never Block on the Human** (`principle-never-block-on-the-human`): For reversible exploratory forks, implement a quick prototype or probe and show results rather than asking blocking permission.

## 3. Communication & Code Style (Unslop & No Comments)
- **Short Declarative Sentences**: One clear thought per sentence, terminated with a period.
- **Banned Characters**:
  - The long-dash character (em-dash `—` or en-dash `–`) is strictly banned. Use complete sentences instead.
  - Colons as mid-sentence connectors are prohibited.
- **No Fluff or Sycophancy**: Deliver honest, expert technical judgment. If an idea is flawed or adds unnecessary complexity, push back with candid reasoning.
- **No Comment Pollution**:
  - Never write narrating comments (`// step 1: do this`, `// loop over array`).
  - Keep comments only for non-obvious *why* constraints that code alone cannot express.
- **Evidence-Based Framing**:
  - Frame the impact first for the consumer (end user or caller), then for the maintainer.
  - Cite only artifacts, logs, and files actually read or generated during this session.