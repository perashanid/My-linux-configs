# lazygit - Git Made Easy

**lazygit** is a terminal UI for git that makes version control simple and visual. No more typing long git commands!

---

##  Quick Start

### Launch lazygit

```bash
# Navigate to any git repository
cd ~/repos/your-project

# Launch lazygit
lazygit
```

### First Time Setup

lazygit works out of the box, but you can configure your git identity if you haven't:

```bash
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
```

---

## 📺 Interface Overview

When you open lazygit, you'll see 4 main panels:

```
┌─────────────────────────────────────────────────────────────────┐
│ Status Panel          │ Files Panel                             │
│ • Branch: main        │ M  modified-file.txt                    │
│ ↑ 2 commits ahead     │ A  new-file.txt                         │
│ ↓ 0 commits behind    │ D  deleted-file.txt                     │
├───────────────────────┼─────────────────────────────────────────┤
│ Branches Panel        │ Commits Panel                           │
│ * main                │ abc123 - Fixed bug (2 hours ago)        │
│   feature-branch      │ def456 - Added feature (1 day ago)      │
│   dev                 │ ghi789 - Initial commit (2 days ago)    │
└───────────────────────┴─────────────────────────────────────────┘
```

---

##  Essential Keybindings

### Navigation

| Key | Action |
|-----|--------|
| `1` | Status view |
| `2` | Files view |
| `3` | Branches view |
| `4` | Commits view |
| `5` | Stash view |
| `↑↓←→` | Navigate between items |
| `Tab` | Switch between panels |
| `?` | Show all keybindings |
| `q` | Quit lazygit |
| `Esc` | Cancel/Go back |

### File Operations (Panel 2)

| Key | Action |
|-----|--------|
| `Space` | Stage/unstage selected file |
| `a` | Stage all files |
| `A` | Unstage all files |
| `c` | Commit staged files |
| `C` | Commit using git commit editor |
| `d` | Discard changes (be careful!) |
| `e` | Edit file |
| `o` | Open file in default editor |
| `i` | Ignore file (add to .gitignore) |
| `Enter` | View file diff |

### Commit Operations (Panel 4)

| Key | Action |
|-----|--------|
| `Enter` | View commit details |
| `Space` | Checkout commit |
| `c` | Copy commit SHA |
| `C` | Copy commit message |
| `r` | Reword commit message |
| `d` | Delete commit (drop) |
| `e` | Edit commit |
| `p` | Pick commit (for rebase) |
| `s` | Squash commit |
| `f` | Fixup commit |
| `t` | Revert commit |

### Branch Operations (Panel 3)

| Key | Action |
|-----|--------|
| `Space` | Checkout branch |
| `n` | Create new branch |
| `o` | Create pull request |
| `M` | Merge branch into current |
| `r` | Rebase branch |
| `d` | Delete branch |
| `R` | Rename branch |
| `u` | Set upstream |
| `f` | Fast-forward branch |

### Remote Operations

| Key | Action |
|-----|--------|
| `P` | Push to remote |
| `p` | Pull from remote |
| `f` | Fetch from remote |
| `Shift+P` | Push with force |

### Stash Operations (Panel 5)

| Key | Action |
|-----|--------|
| `Space` | Apply stash |
| `g` | Pop stash |
| `d` | Drop stash |
| `n` | Create new stash |
| `r` | Rename stash |

---

##  Common Workflows

### 1. Basic Commit and Push

```
1. Make changes to your files
2. Open lazygit
3. Press '2' to go to Files panel
4. Press 'a' to stage all files (or Space on individual files)
5. Press 'c' to commit
6. Type commit message, save and close
7. Press 'P' to push
```

**Equivalent git commands:**
```bash
git add .
git commit -m "message"
git push
```

### 2. Create New Branch

```
1. Open lazygit
2. Press '3' to go to Branches panel
3. Press 'n' for new branch
4. Type branch name
5. Press Enter
```

**Equivalent git commands:**
```bash
git checkout -b new-branch-name
```

### 3. Switch Between Branches

```
1. Open lazygit
2. Press '3' to go to Branches panel
3. Use arrow keys to select branch
4. Press Space to checkout
```

**Equivalent git commands:**
```bash
git checkout branch-name
```

### 4. Merge Branch

```
1. Checkout the branch you want to merge INTO (e.g., main)
2. Press '3' to go to Branches panel
3. Select the branch you want to merge FROM
4. Press 'M' to merge
5. Confirm
```

**Equivalent git commands:**
```bash
git checkout main
git merge feature-branch
```

### 5. View Commit History

```
1. Open lazygit
2. Press '4' to go to Commits panel
3. Use arrow keys to browse commits
4. Press Enter to see commit details
```

**Equivalent git commands:**
```bash
git log
git show <commit-hash>
```

### 6. Undo Last Commit (Keep Changes)

```
1. Press '4' to go to Commits panel
2. Select the commit you want to undo
3. Press 'd' to drop commit
4. Confirm
5. Changes will be back in your working directory
```

**Equivalent git commands:**
```bash
git reset HEAD~1
```

### 7. Stash Changes

```
1. Press '5' to go to Stash panel
2. Press 'n' to create new stash
3. Type stash name (optional)
4. Press Enter
```

**To apply stash later:**
```
1. Press '5' to go to Stash panel
2. Select stash
3. Press Space to apply (or 'g' to pop)
```

**Equivalent git commands:**
```bash
git stash save "message"
git stash apply
```

### 8. Resolve Merge Conflicts

```
1. When merge conflict occurs, lazygit will show conflicted files
2. Press '2' to go to Files panel
3. Select conflicted file
4. Press 'e' to edit file
5. Resolve conflicts manually
6. Save and close
7. Press Space to stage resolved file
8. Press 'c' to commit merge
```

### 9. Interactive Rebase

```
1. Press '4' to go to Commits panel
2. Select the commit you want to rebase from
3. Press 'i' to start interactive rebase
4. Use 'p' (pick), 's' (squash), 'f' (fixup), 'd' (drop) on commits
5. Press Enter to confirm
```

### 10. Cherry-pick Commit

```
1. Press '4' to go to Commits panel
2. Select commit you want to cherry-pick
3. Press 'c' to copy commit
4. Checkout target branch (press '3', select branch, Space)
5. Press 'v' to paste (cherry-pick) commit
```

---

##  Customization

### Config File Location

```bash
~/.config/lazygit/config.yml
```

### Basic Configuration Example

```yaml
gui:
  theme:
    activeBorderColor:
      - green
      - bold
    inactiveBorderColor:
      - white
  showFileTree: true
  showRandomTip: true
  
git:
  paging:
    colorArg: always
    pager: delta --dark --paging=never
  
refresher:
  refreshInterval: 10
  
update:
  method: never
```

### Use Delta for Better Diffs (Optional)

```bash
# Install delta
sudo pacman -S git-delta

# Configure lazygit to use delta
mkdir -p ~/.config/lazygit
cat > ~/.config/lazygit/config.yml << 'EOF'
git:
  paging:
    colorArg: always
    pager: delta --dark --paging=never
EOF
```

---

##  Tips & Tricks

### 1. Quick Commit with Message

Instead of opening editor:
```
1. Stage files
2. Press 'c'
3. Type message directly in the prompt
4. Press Enter
```

### 2. Amend Last Commit

```
1. Stage new changes
2. Press '4' to go to Commits
3. Select last commit
4. Press 'A' to amend
```

### 3. View File at Specific Commit

```
1. Press '4' to go to Commits
2. Select commit
3. Press Enter to see files
4. Select file
5. Press Enter to view content
```

### 4. Search Commits

```
1. Press '4' to go to Commits
2. Press '/' to search
3. Type search term
4. Press Enter
```

### 5. Bulk Stage Files

```
1. Press '2' to go to Files
2. Press 'a' to stage all
3. Or use Space on individual files
```

### 6. Undo Staging

```
1. Press '2' to go to Files
2. Select staged file
3. Press Space to unstage
4. Or press 'A' to unstage all
```

### 7. Compare Branches

```
1. Press '3' to go to Branches
2. Select branch
3. Press Enter to see commits
4. Compare with current branch
```

### 8. Force Push (Careful!)

```
1. After rebase or amend
2. Press 'P' (capital P)
3. Confirm force push
```

### 9. Pull with Rebase

```
1. Press 'p' to pull
2. Select "rebase" option
3. Confirm
```

### 10. View Remote Branches

```
1. Press '3' to go to Branches
2. Press 'r' to toggle remote branches
3. See all remote branches
```

---

##  Troubleshooting

### lazygit Won't Start

```bash
# Check if you're in a git repository
git status

# If not, initialize git
git init
```

### Can't Push to Remote

```bash
# Set upstream branch first
git push -u origin main

# Or in lazygit:
# Press '3' → Select branch → Press 'u' → Set upstream
```

### Merge Conflicts

```
1. Don't panic!
2. Press '2' to see conflicted files
3. Press 'e' to edit each file
4. Look for <<<<<<, ======, >>>>>> markers
5. Keep the code you want
6. Remove conflict markers
7. Save file
8. Press Space to stage
9. Press 'c' to commit merge
```

### Accidentally Deleted Branch

```bash
# Find the commit SHA
git reflog

# Recreate branch
git checkout -b branch-name <commit-sha>
```

### Want to Undo Everything

```bash
# Reset to last commit (loses all changes!)
git reset --hard HEAD

# Or in lazygit:
# Press '4' → Select commit → Press 'd' → Confirm
```

---

##  Learning Resources

### Practice Repository

Create a test repo to practice:

```bash
mkdir ~/repos/git-practice
cd ~/repos/git-practice
git init
echo "Hello" > test.txt
git add test.txt
git commit -m "Initial commit"
lazygit
```

### Common Scenarios to Practice

1. Make changes → Stage → Commit → Push
2. Create branch → Make changes → Merge back
3. Make multiple commits → Squash them
4. Stash changes → Switch branch → Apply stash
5. View commit history → Cherry-pick commit

---

##  lazygit vs Git Commands

| Task | Git Command | lazygit |
|------|-------------|---------|
| Stage file | `git add file.txt` | `2` → `Space` |
| Stage all | `git add .` | `2` → `a` |
| Commit | `git commit -m "msg"` | `c` → type → save |
| Push | `git push` | `P` |
| Pull | `git pull` | `p` |
| New branch | `git checkout -b name` | `3` → `n` → type |
| Switch branch | `git checkout name` | `3` → select → `Space` |
| Merge | `git merge branch` | `3` → select → `M` |
| View log | `git log` | `4` |
| Stash | `git stash` | `5` → `n` |
| Diff | `git diff` | `2` → `Enter` |

---

##  Quick Reference Card

```
Navigation:  1-5 (panels)  ↑↓←→ (move)  Tab (switch)  ? (help)  q (quit)

Files (2):   Space (stage)  a (stage all)  c (commit)  d (discard)
Commits (4): Enter (view)   r (reword)     d (drop)    s (squash)
Branches (3): Space (checkout)  n (new)    M (merge)   d (delete)
Remote:      P (push)       p (pull)       f (fetch)
```

---

##  Advanced Features

### Custom Commands

Add custom git commands in config:

```yaml
customCommands:
  - key: 'C'
    command: 'git commit --amend --no-edit'
    context: 'files'
    description: 'Amend commit without editing message'
```

### Keybinding Customization

```yaml
keybinding:
  universal:
    quit: 'q'
    return: 'Esc'
  files:
    commitChanges: 'c'
    stageAll: 'a'
```

---

##  Summary

**lazygit makes git:**
-  Visual and intuitive
-  Faster (no typing long commands)
-  Easier to understand (see everything at once)
-  Less error-prone (confirm before dangerous operations)
-  More powerful (easy access to advanced features)

**Start using it:**
```bash
cd ~/repos/your-project
lazygit
```

Press `?` anytime to see all keybindings!

---

**Last Updated**: April 10, 2026  
**Version**: lazygit 0.61.0
