[CmdletBinding()]
param()

[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$OutputEncoding = [System.Text.Encoding]::UTF8

$msg = @"
[Pstack Active] Mode: poteto-mode | Automated Engineering Rigor Enforced
Directive: Operate in poteto-mode on this turn and every turn.
- Automatically match the task to the appropriate pstack playbook (investigation, bug-fix, feature, refactoring, perf-issue, etc.) and execute its steps.
- Enforce the 21 engineering principles (laziness protocol, foundational thinking, model-the-domain, prove-it-works, etc.).
- Verify every change against concrete runtime evidence before declaring done.
- Keep replies concise, using short declarative sentences with no long-dashes, no comment narration, and zero slop.
"@

$response = @{
    injectSteps = @(
        @{
            ephemeralMessage = $msg
        }
    )
}

Write-Output ($response | ConvertTo-Json -Compress -Depth 5)