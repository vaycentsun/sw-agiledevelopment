# sw-agiledevelopment Installation Guide (for AI Agent)

> **Target reader**: AI Agent assisting the user.  
> **Goal**: Install the sw-agiledevelopment skill framework into the user's current project.

## Overview

The sw-agiledevelopment repository provides a set of software development skills (in `sw-*/SKILL.md` files) and a GitHub Copilot instructions file. To use these skills in the user's project, you must copy two things from the sw-agiledevelopment source repository to the user's project root.

## Installation Steps

### Step 1: Copy `copilot-instructions.md`

Copy the Copilot instructions file to the user's project:

```bash
# From: <sw-agiledevelopment-repo>/.github/copilot-instructions.md
# To:   <user-project-root>/.github/copilot-instructions.md

cp /path/to/sw-agiledevelopment/.github/copilot-instructions.md \
   /path/to/user-project/.github/copilot-instructions.md
```

If the user's project does not have a `.github/` directory, create it first:

```bash
mkdir -p /path/to/user-project/.github
```

### Step 2: Copy Skill Directories

Copy **all** `sw-*/` directories (the actual skill source directories) into the user's project under `.sw-agiledevelopment/`.

**Important**: The `skills/` directory in the sw-agiledevelopment repo contains **symbolic links** pointing to `../sw-*`. You must copy the **source directories** (`sw-*/`), not the `skills/` symlink directory, to avoid broken links in the user's project.

```bash
# Create the target directory
mkdir -p /path/to/user-project/.sw-agiledevelopment

# Copy all sw-* directories (source skill directories)
cp -r /path/to/sw-agiledevelopment/sw-* \
   /path/to/user-project/.sw-agiledevelopment/
```

### Step 3: Verify the Structure

After installation, the user's project should look like this:

```
user-project/
├── .github/
│   └── copilot-instructions.md          ← Copilot instructions (injected into every Copilot Chat session)
├── .sw-agiledevelopment/                 ← Skill source files (for detailed reference)
│   ├── sw-code-review/
│   │   └── SKILL.md
│   ├── sw-execute-plan/
│   │   └── SKILL.md
│   ├── sw-finishing-branch/
│   │   └── SKILL.md
│   ├── sw-parallel-debugging/
│   │   └── SKILL.md
│   ├── sw-requirements-clarification/
│   │   └── SKILL.md
│   ├── sw-subagent-development/
│   │   └── SKILL.md
│   ├── sw-systematic-debugging/
│   │   └── SKILL.md
│   ├── sw-task-verification/
│   │   └── SKILL.md
│   ├── sw-technical-spec/
│   │   └── SKILL.md
│   ├── sw-test-driven-dev/
│   │   └── SKILL.md
│   ├── sw-using-agiledevelopment/
│   │   └── SKILL.md
│   ├── sw-working-plan/
│   │   └── SKILL.md
│   └── sw-writing-skills/
│       └── SKILL.md
├── src/
├── package.json
└── README.md
```

## What Each File Does

| File / Directory | Purpose |
|-----------------|---------|
| `.github/copilot-instructions.md` | Injected into every GitHub Copilot Chat session in this project. Contains the skill index, decision tree, red flags, and terminology conventions. |
| `.sw-agiledevelopment/sw-*/SKILL.md` | Full skill content. Referenced by `copilot-instructions.md` when detailed checklists, templates, or subagent prompts are needed. |

## Usage After Installation

Once installed, the user can use GitHub Copilot Chat normally in VS Code. Copilot will automatically follow the agile development workflow defined in `copilot-instructions.md`.

If Copilot needs detailed guidance from a specific skill, it can reference the full file:

```
#file:.sw-agiledevelopment/sw-test-driven-dev/SKILL.md
```

Or you (the AI Agent) can read it directly to provide precise guidance:

```
Read the file .sw-agiledevelopment/sw-technical-spec/SKILL.md for the complete spec template.
```

## Notes

- Do **not** copy the `skills/` directory from the sw-agiledevelopment repo. It only contains symlinks and will not work in the user's project.
- The `.sw-agiledevelopment/` directory name is a convention. It keeps the skill files organized and hidden from the user's main project view.
- If the user already has a `.github/copilot-instructions.md`, ask before overwriting or append the sw-agiledevelopment content to the existing file.
