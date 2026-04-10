# SDDM Theme Management Guide

Guide to changing SDDM login screen themes on COSMIC Desktop.

---

## What is SDDM?

SDDM (Simple Desktop Display Manager) is your login screen that appears when you:
- Boot your computer
- Log out completely
- Restart your system

**Note**: This is different from the lockscreen (when you press End key). The lockscreen is managed by COSMIC Settings.

---

## Quick Theme Change

### Step 1: Install New Theme

Run the qylock theme installer:

```bash
~/repos/qylock/sddm.sh
```

This will show you a menu of available themes. Select the number of the theme you want to install.

### Step 2: Check Installed Themes

```bash
ls /usr/share/sddm/themes/
```

This shows all themes currently installed on your system.

### Step 3: Set Active Theme

Edit the SDDM configuration:

```bash
sudo nano /etc/sddm.conf
```

Change the `Current=` line under `[Theme]` section to your desired theme name:

```ini
[Autologin]
[Theme]
Current=your-theme-name
```

Save and exit (Ctrl+O, Enter, Ctrl+X).

### Step 4: Apply Changes

Restart SDDM to see the new theme:

```bash
sudo systemctl restart sddm
```

**Warning**: This will log you out immediately. Save your work first!

---

## Available Themes

Common themes from qylock repository:

- `star-rail` - Honkai: Star Rail theme
- `genshin-impact` - Genshin Impact theme
- `dog-samurai` - Dog Samurai theme
- `ninja_gaiden` - Ninja Gaiden theme
- `sword` - Sword theme
- `glyph` - Glyph theme

CachyOS default themes:

- `breeze` - KDE Breeze theme
- `cachyos-simplyblack` - CachyOS simple black
- `cachyos-softgrey` - CachyOS soft grey
- `elarun` - Elarun theme
- `maldives` - Maldives theme
- `maya` - Maya theme

---

## Complete Workflow

### Installing qylock (First Time)

If you don't have qylock installed:

```bash
# Clone repository
git clone https://github.com/Darkkal44/qylock.git ~/repos/qylock

# Make script executable
chmod +x ~/repos/qylock/sddm.sh

# Run installer
~/repos/qylock/sddm.sh
```

### Changing Themes

```bash
# 1. Install new theme (if needed)
~/repos/qylock/sddm.sh

# 2. Check what's installed
ls /usr/share/sddm/themes/

# 3. Edit config
sudo nano /etc/sddm.conf

# 4. Change Current= line to your theme name

# 5. Apply changes
sudo systemctl restart sddm
```

---

## Example: Switching Themes

### From star-rail to ninja_gaiden

```bash
# Check if ninja_gaiden is installed
ls /usr/share/sddm/themes/ | grep ninja

# If not installed, run installer
~/repos/qylock/sddm.sh
# Select ninja_gaiden from menu

# Edit config
sudo nano /etc/sddm.conf
```

Change:
```ini
[Theme]
Current=star-rail
```

To:
```ini
[Theme]
Current=ninja_gaiden
```

Save and restart:
```bash
sudo systemctl restart sddm
```

---

## Backup and Restore

### Backup Current Config

```bash
sudo cp /etc/sddm.conf ~/cosmic-config/system/sddm.conf
```

### Restore from Backup

```bash
sudo cp ~/cosmic-config/system/sddm.conf /etc/sddm.conf
sudo systemctl restart sddm
```

---

## Troubleshooting

### Theme Not Changing

1. **Verify theme is installed:**
   ```bash
   ls /usr/share/sddm/themes/your-theme-name
   ```

2. **Check config syntax:**
   ```bash
   cat /etc/sddm.conf
   ```
   
   Should look like:
   ```ini
   [Autologin]
   [Theme]
   Current=theme-name
   ```

3. **Restart SDDM:**
   ```bash
   sudo systemctl restart sddm
   ```

### SDDM Won't Start

If SDDM fails to start after changing theme:

```bash
# Switch to TTY (Ctrl+Alt+F2)
# Login with your username and password

# Reset to default theme
sudo nano /etc/sddm.conf
# Change Current= to breeze or elarun

# Restart SDDM
sudo systemctl restart sddm

# Switch back to GUI (Ctrl+Alt+F1)
```

### Theme Looks Broken

Some themes may not work well with your resolution or setup. Try a different theme:

```bash
sudo nano /etc/sddm.conf
# Change to a known working theme like breeze
sudo systemctl restart sddm
```

### qylock Script Not Found

```bash
# Check if qylock exists
ls ~/repos/qylock/

# If not, clone it
git clone https://github.com/Darkkal44/qylock.git ~/repos/qylock
chmod +x ~/repos/qylock/sddm.sh
```

---

## Custom Theme Configuration

### Customize Existing Theme

Each theme has a `theme.conf` file you can edit:

```bash
# Navigate to theme directory
cd /usr/share/sddm/themes/star-rail

# View config
cat theme.conf

# Edit (requires sudo)
sudo nano theme.conf
```

Common settings:
- `background=` - Path to background image
- `ScreenWidth=` - Screen width
- `ScreenHeight=` - Screen height
- `Font=` - Font family
- `FontSize=` - Font size

### Change Background Only

```bash
# Find current background
cd /usr/share/sddm/themes/star-rail
ls *.jpg *.png

# Replace with your image
sudo cp /path/to/your/wallpaper.jpg background.jpg

# Restart SDDM
sudo systemctl restart sddm
```

---

## SDDM vs Lockscreen

### SDDM (Login Screen)
- Shows on boot, logout, restart
- Managed by `/etc/sddm.conf`
- Changed with this guide

### Lockscreen (COSMIC Lock)
- Shows when you press End key
- Managed by COSMIC Settings
- Change in: `cosmic-settings` → Desktop → Lock Screen

---

## Quick Reference

```bash
# Install theme
~/repos/qylock/sddm.sh

# List themes
ls /usr/share/sddm/themes/

# Edit config
sudo nano /etc/sddm.conf

# Apply changes
sudo systemctl restart sddm

# Backup config
sudo cp /etc/sddm.conf ~/cosmic-config/system/sddm.conf
```

---

## Current Setup

Your current configuration:
- **Theme**: star-rail (Honkai: Star Rail)
- **Config**: `/etc/sddm.conf`
- **Backup**: `~/cosmic-config/system/sddm.conf`
- **Theme installer**: `~/repos/qylock/sddm.sh`

---

For more themes, visit: https://github.com/Darkkal44/qylock
