---
name: setup-pstack
description: Configure which models pstack uses per role. Detects your available models and writes an always-applied rule that overrides the skill defaults. Use for /setup-pstack, "configure pstack models", or changing pstack's model choices.
---

# Setup pstack

Write `~/.gemini/config/rules/pstack-models.md`, an always-applied rule that sets pstack's model per role. The skills read it and fall back to their inline defaults when a line is absent, so this is an override layer, not a requirement.

## Steps

### 1. Detect available models

Enumerate the model slugs available to `invoke_subagent` in this session, or run `agy models` in Antigravity CLI. If you cannot detect any, ask the user to paste the slugs they have access to. Never write a real slug you have not confirmed is available. The aliases `inherit` (or `inherit-parent`) and `auto` are always valid even though they are not detected slugs.

### 2. Load current state

The default role-to-model mapping is the rule shape shown in step 5 below. If `~/.gemini/config/rules/pstack-models.md` already exists, read it and treat its values as the current choices. Otherwise start from those defaults.

### 3. Map and confirm

Show every role with its current model, marking any real slug not in the detected set as needing a choice. Ask whether to accept as-is or change specific roles, offering the detected models plus `inherit` and `auto` (both mean: this role runs on the parent chat model) as the options. Prefer ask_question over free text. For panel roles (how critics, arena runners, architect runners, interrogate reviewers) the value is a list, and one subagent runs per entry, alias entries included, so the list length sets the count. `arena cross-judge pool` is also a list, but Arena selects one value from it whose model family differs from the parent's when possible. `swarm workers` is the default model for every worker unless a race or comparison assigns another model per arm.

### 4. Validate

Every real slug written must be in the detected set; `inherit` and `auto` always pass. If a chosen real slug is not available, stop and ask again. A rule pointing at a model the user cannot use breaks every delegation that reads it.

### 5. Write the rule

Write `~/.gemini/config/rules/pstack-models.md` with one line per role, using the same labels poteto-mode uses. Overwrite the whole file so re-runs stay idempotent. Shape:

```markdown
# pstack model configuration. One line per role. Delete a line to fall back to the skill default.
# `inherit` or `auto` as a value: the role runs on the parent chat model (omit invoke_subagent `Model`).
feature, refactoring: gemini-3.8-flash-high
bug-fix: gemini-3.1-pro-high
perf-issue: gemini-3.1-pro-high
hillclimb: gemini-3.1-pro-high
judgment and prose: gemini-3.1-pro-high
hardest tasks: gemini-3.1-pro-high
how explorer: gemini-3.8-flash-high
how explainer: gemini-3.1-pro-high
how critics: gemini-3.8-flash-high, gemini-3.1-pro-high, claude-sonnet-4-6, claude-opus-4-6-thinking
why investigators: gemini-3.8-flash-high
why synthesizer: gemini-3.1-pro-high
reflect tooling: gemini-3.8-flash-high
reflect judgment, divergent, synthesizer: gemini-3.1-pro-high
arena runners: gemini-3.8-flash-high, gemini-3.1-pro-high, claude-sonnet-4-6, claude-opus-4-6-thinking
arena cross-judge pool: gemini-3.8-flash-high, gemini-3.1-pro-high, claude-sonnet-4-6, claude-opus-4-6-thinking
swarm workers: gemini-3.8-flash-high
architect runners: gemini-3.8-flash-high, gemini-3.1-pro-high, claude-sonnet-4-6, claude-opus-4-6-thinking
interrogate reviewers: gemini-3.8-flash-high, gemini-3.1-pro-high, claude-sonnet-4-6, claude-opus-4-6-thinking
```

### 6. Confirm

Tell the user the rule was written and that it applies to new sessions. Re-running this skill updates it.

### 7. Offer a verification skill (optional)

Check whether the project has a way to drive the real app for proof (a `verify-*` skill, or an existing harness). If not, offer once: "want a project-local verification skill, so agents can drive the app the way a user does and prove changes work? I can generate one with /create-verification-skill." On yes, invoke `/create-verification-skill` (resolves wherever pstack is installed — workspace, user, or plugin). On no, move on without pushing.
