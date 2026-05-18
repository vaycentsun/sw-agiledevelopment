# sw-agiledevelopment Installation Guide (for Android Studio AI Agent)

> **Target reader**: AI Agent assisting the user.  
> **Goal**: Install the sw-agiledevelopment skill framework into the user's current Android Studio project.

## Overview

The sw-agiledevelopment repository provides a set of software development skills (in `sw-*/SKILL.md` files) and an Android Studio system prompt file. To use these skills in the user's Android Studio project, you must copy two things from the sw-agiledevelopment source repository to the user's project root.

## Installation Steps

### Step 1: Copy `.androidstudio/sw-agiledevelopment.md`

If the user's project already has `.androidstudio/sw-agiledevelopment.md`, append the sw-agiledevelopment content to it without overwriting the existing file:

```bash
# Ensure the .androidstudio directory exists
mkdir -p /path/to/user-project/.androidstudio

# Append sw-agiledevelopment content to existing sw-agiledevelopment.md
cat /path/to/sw-agiledevelopment/.androidstudio/sw-agiledevelopment.md \
   >> /path/to/user-project/.androidstudio/sw-agiledevelopment.md
```

If the user's project does **not** have `.androidstudio/sw-agiledevelopment.md` yet, copy it normally:

```bash
mkdir -p /path/to/user-project/.androidstudio
cp /path/to/sw-agiledevelopment/.androidstudio/sw-agiledevelopment.md \
   /path/to/user-project/.androidstudio/sw-agiledevelopment.md
```

### Step 2: Copy Skill Directories

First, remove the existing `.sw-agiledevelopment/` directory in the user's project (if any) to ensure a clean copy. Then copy **all** `sw-*/` directories (the actual skill source directories) into the user's project under `.sw-agiledevelopment/`.

**Important**: The `skills/` directory in the sw-agiledevelopment repo contains **symbolic links** pointing to `../sw-*`. You must copy the **source directories** (`sw-*/`), not the `skills/` symlink directory, to avoid broken links in the user's project.

```bash
# Remove existing skills directory if it exists
rm -rf /path/to/user-project/.sw-agiledevelopment

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
├── .androidstudio/
│   └── sw-agiledevelopment.md              ← Android Studio system prompt (indexed by AI Agent)
├── .sw-agiledevelopment/                    ← Skill source files (for detailed reference)
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
├── build.gradle
└── README.md
```

### Step 4: Add to `.gitignore`

Add `.sw-agiledevelopment/` to the user's `.gitignore` so the copied skill files are not committed to the user's project repository:

```bash
echo ".sw-agiledevelopment/" >> /path/to/user-project/.gitignore
```

## What Each File Does

| File / Directory | Purpose |
|-----------------|---------|
| `.androidstudio/sw-agiledevelopment.md` | Android Studio AI Agent system prompt. Loaded by the AI Agent when working on this project. Contains the skill index, decision tree, red flags, and terminology conventions. |
| `.sw-agiledevelopment/sw-*/SKILL.md` | Full skill content. Referenced by `sw-agiledevelopment.md` when detailed checklists, templates, or subagent prompts are needed. |

## Usage After Installation

Once installed, the Android Studio AI Agent will automatically follow the agile development workflow defined in `.androidstudio/sw-agiledevelopment.md` when assisting with this project.

If the AI Agent needs detailed guidance from a specific skill, it should read the full skill file:

```
Read the file .sw-agiledevelopment/sw-test-driven-dev/SKILL.md for the complete TDD checklist.
```

Or reference it directly in the conversation:

```
According to .sw-agiledevelopment/sw-technical-spec/SKILL.md, the technical spec must include...
```

## Notes

- Do **not** copy the `skills/` directory from the sw-agiledevelopment repo. It only contains symlinks and will not work in the user's project.
- The `.sw-agiledevelopment/` directory name is a convention. It keeps the skill files organized and hidden from the user's main project view.
- Android Studio's AI Agent uses `.androidstudio/` as the conventional location for project-specific AI configurations, similar to how `.github/` is used for GitHub Copilot.
