# Button Configuration Reference for COSMIC Desktop

Complete guide to configuring special buttons (screenshot, pause, lock, volume, brightness, etc.) in COSMIC Desktop.

**Last Updated**: April 10, 2026  
**System**: COSMIC Desktop on CachyOS

---

## 📍 Configuration File Location

```bash
~/.config/cosmic/com.system76.CosmicSettings.Shortcuts/v1/custom
```

This file uses RON (Rusty Object Notation) format.

---

##  Basic Syntax

```ron
{
    (
        modifiers: [Super, Shift, Ctrl, Alt],  // Modifier keys (can be empty [])
        key: "KeyName",                         // Key to bind
        description: Some("description"),       // Description (optional)
    ): Spawn("command-to-run"),                // Command to execute
}
```

### Important Notes

- Each entry must end with a comma (except the last one)
- Strings must be in double quotes
- Commands are executed in a shell
- Use `Some("text")` for descriptions or `None` to omit

---

##  Common Special Key Names

### Media Keys

| Key Name | Physical Key | Common Use |
|----------|-------------|------------|
| `Pause` | Pause/Break | Media play/pause |
| `AudioPlay` | Play button | Play media |
| `AudioPause` | Pause button | Pause media |
| `AudioNext` | Next track | Skip to next |
| `AudioPrev` | Previous track | Skip to previous |
| `AudioStop` | Stop button | Stop playback |
| `AudioRaiseVolume` | Volume up | Increase volume |
| `AudioLowerVolume` | Volume down | Decrease volume |
| `AudioMute` | Mute button | Toggle mute |

### System Keys

| Key Name | Physical Key | Common Use |
|----------|-------------|------------|
| `Print` | Print Screen | Screenshot |
| `End` | End | Lock screen |
| `Home` | Home | Home action |
| `Insert` | Insert | Insert mode |
| `Delete` | Delete | Delete |
| `Escape` | Escape | Cancel/Exit |

### Brightness Keys

| Key Name | Physical Key | Common Use |
|----------|-------------|------------|
| `MonBrightnessUp` | Brightness up | Increase brightness |
| `MonBrightnessDown` | Brightness down | Decrease brightness |

### Function Keys

| Key Name | Physical Key |
|----------|-------------|
| `F1` through `F12` | F1-F12 |

### Navigation Keys

| Key Name | Physical Key |
|----------|-------------|
| `Up`, `Down`, `Left`, `Right` | Arrow keys |
| `Page_Up`, `Page_Down` | Page Up/Down |

---

##  Complete Button Configurations

### Screenshot Buttons

#### Using Flameshot (Recommended for Wayland)

```ron
(
    modifiers: [],
    key: "Print",
    description: Some("screenshot"),
): Spawn("sh -c 'QT_QPA_PLATFORM=wayland flameshot gui'"),
```

#### Using grim + slurp + swappy

```ron
(
    modifiers: [],
    key: "Print",
    description: Some("screenshot area"),
): Spawn("sh -c 'grim -g \"$(slurp)\" - | swappy -f -'"),
```

#### Using Custom Script

```ron
(
    modifiers: [],
    key: "Print",
    description: Some("screenshot"),
): Spawn("~/.local/bin/screenshot"),
```

#### Screenshot Variations

```ron
// Full screen screenshot
(
    modifiers: [Shift],
    key: "Print",
    description: Some("screenshot fullscreen"),
): Spawn("grim ~/Pictures/screenshot-$(date +%Y%m%d-%H%M%S).png"),

// Window screenshot
(
    modifiers: [Alt],
    key: "Print",
    description: Some("screenshot window"),
): Spawn("sh -c 'grim -g \"$(swaymsg -t get_tree | jq -r '.. | select(.focused?) | .rect | \"\\(.x),\\(.y) \\(.width)x\\(.height)\"')\" ~/Pictures/screenshot-$(date +%Y%m%d-%H%M%S).png'"),

// Screenshot to clipboard
(
    modifiers: [Ctrl],
    key: "Print",
    description: Some("screenshot to clipboard"),
): Spawn("sh -c 'grim -g \"$(slurp)\" - | wl-copy'"),
```

---

### Media Control Buttons

#### Play/Pause

```ron
(
    modifiers: [],
    key: "Pause",
    description: Some("play/pause media"),
): Spawn("playerctl play-pause"),

// Alternative with Super key
(
    modifiers: [Super],
    key: "p",
    description: Some("play/pause backup"),
): Spawn("playerctl play-pause"),
```

#### Next/Previous Track

```ron
(
    modifiers: [],
    key: "AudioNext",
    description: Some("next track"),
): Spawn("playerctl next"),

(
    modifiers: [],
    key: "AudioPrev",
    description: Some("previous track"),
): Spawn("playerctl previous"),
```

#### Stop

```ron
(
    modifiers: [],
    key: "AudioStop",
    description: Some("stop media"),
): Spawn("playerctl stop"),
```

#### Media Keys with Keyboard Shortcuts

```ron
// For keyboards without media keys
(
    modifiers: [Super, Shift],
    key: "Right",
    description: Some("next track"),
): Spawn("playerctl next"),

(
    modifiers: [Super, Shift],
    key: "Left",
    description: Some("previous track"),
): Spawn("playerctl previous"),

(
    modifiers: [Super, Shift],
    key: "Down",
    description: Some("play/pause"),
): Spawn("playerctl play-pause"),
```

---

### Volume Control Buttons

#### Basic Volume Controls

```ron
(
    modifiers: [],
    key: "AudioRaiseVolume",
    description: Some("volume up"),
): Spawn("pactl set-sink-volume @DEFAULT_SINK@ +5%"),

(
    modifiers: [],
    key: "AudioLowerVolume",
    description: Some("volume down"),
): Spawn("pactl set-sink-volume @DEFAULT_SINK@ -5%"),

(
    modifiers: [],
    key: "AudioMute",
    description: Some("mute toggle"),
): Spawn("pactl set-sink-mute @DEFAULT_SINK@ toggle"),
```

#### Volume with Notifications

```ron
(
    modifiers: [],
    key: "AudioRaiseVolume",
    description: Some("volume up"),
): Spawn("sh -c 'pactl set-sink-volume @DEFAULT_SINK@ +5% && notify-send \"Volume: $(pactl get-sink-volume @DEFAULT_SINK@ | grep -Po '\\d+(?=%)' | head -1)%\"'"),

(
    modifiers: [],
    key: "AudioLowerVolume",
    description: Some("volume down"),
): Spawn("sh -c 'pactl set-sink-volume @DEFAULT_SINK@ -5% && notify-send \"Volume: $(pactl get-sink-volume @DEFAULT_SINK@ | grep -Po '\\d+(?=%)' | head -1)%\"'"),
```

#### Microphone Mute

```ron
(
    modifiers: [],
    key: "AudioMicMute",
    description: Some("mic mute toggle"),
): Spawn("pactl set-source-mute @DEFAULT_SOURCE@ toggle"),
```

---

### Brightness Control Buttons

#### Basic Brightness Controls

```ron
(
    modifiers: [],
    key: "MonBrightnessUp",
    description: Some("brightness up"),
): Spawn("brightnessctl set +5%"),

(
    modifiers: [],
    key: "MonBrightnessDown",
    description: Some("brightness down"),
): Spawn("brightnessctl set 5%-"),
```

#### Brightness with Notifications

```ron
(
    modifiers: [],
    key: "MonBrightnessUp",
    description: Some("brightness up"),
): Spawn("sh -c 'brightnessctl set +5% && notify-send \"Brightness: $(brightnessctl get)\"'"),

(
    modifiers: [],
    key: "MonBrightnessDown",
    description: Some("brightness down"),
): Spawn("sh -c 'brightnessctl set 5%- && notify-send \"Brightness: $(brightnessctl get)\"'"),
```

#### Keyboard Backlight

```ron
(
    modifiers: [],
    key: "KbdBrightnessUp",
    description: Some("keyboard backlight up"),
): Spawn("brightnessctl --device='*::kbd_backlight' set +10%"),

(
    modifiers: [],
    key: "KbdBrightnessDown",
    description: Some("keyboard backlight down"),
): Spawn("brightnessctl --device='*::kbd_backlight' set 10%-"),
```

---

### Lock Screen Buttons

#### Using loginctl (Recommended)

```ron
(
    modifiers: [],
    key: "End",
    description: Some("lock screen"),
): Spawn("loginctl lock-sessions"),
```

#### Using swaylock

```ron
(
    modifiers: [Super],
    key: "l",
    description: Some("lock screen"),
): Spawn("swaylock -f -c 000000"),
```

#### Using COSMIC Greeter

```ron
(
    modifiers: [Super],
    key: "l",
    description: Some("lock screen"),
): Spawn("cosmic-greeter --lock"),
```

---

### Power Management Buttons

#### Logout

```ron
(
    modifiers: [Super],
    key: "Escape",
    description: Some("logout"),
): Spawn("pkill -9 cosmic-session"),
```

#### Shutdown

```ron
(
    modifiers: [Super],
    key: "Delete",
    description: Some("shutdown"),
): Spawn("systemctl poweroff"),
```

#### Reboot

```ron
(
    modifiers: [Super, Shift],
    key: "Delete",
    description: Some("reboot"),
): Spawn("systemctl reboot"),
```

#### Suspend

```ron
(
    modifiers: [Super],
    key: "s",
    description: Some("suspend"),
): Spawn("systemctl suspend"),
```

#### Hibernate

```ron
(
    modifiers: [Super, Shift],
    key: "s",
    description: Some("hibernate"),
): Spawn("systemctl hibernate"),
```

---

### Application Launch Buttons

#### Terminal

```ron
(
    modifiers: [Super],
    key: "t",
    description: Some("terminal"),
): Spawn("cosmic-term"),

// Alternative: Return key
(
    modifiers: [Super],
    key: "Return",
    description: Some("terminal"),
): Spawn("cosmic-term"),
```

#### Browser

```ron
(
    modifiers: [Super],
    key: "b",
    description: Some("browser"),
): Spawn("flatpak run com.brave.Browser"),
```

#### File Manager

```ron
(
    modifiers: [Super],
    key: "f",
    description: Some("file manager"),
): Spawn("dolphin"),

// Alternative: e for explorer
(
    modifiers: [Super],
    key: "e",
    description: Some("file manager"),
): Spawn("dolphin"),
```

#### Text Editor

```ron
(
    modifiers: [Super],
    key: "n",
    description: Some("text editor"),
): Spawn("cosmic-edit"),
```

#### Launcher

```ron
(
    modifiers: [Super],
    key: "Space",
    description: Some("launcher"),
): Spawn("cosmic-launcher"),

// Alternative: d for dmenu-style
(
    modifiers: [Super],
    key: "d",
    description: Some("launcher"),
): Spawn("cosmic-launcher"),
```

---

### Clipboard Manager

```ron
(
    modifiers: [Super],
    key: "c",
    description: Some("clipboard manager"),
): Spawn("copyq toggle"),

// Alternative: v for paste
(
    modifiers: [Super],
    key: "v",
    description: Some("clipboard manager"),
): Spawn("copyq toggle"),
```

---

### System Monitor

```ron
(
    modifiers: [Super],
    key: "slash",
    description: Some("system monitor"),
): Spawn("cosmic-term -e btop"),

// Alternative: Escape key
(
    modifiers: [Ctrl, Shift],
    key: "Escape",
    description: Some("system monitor"),
): Spawn("cosmic-term -e btop"),
```

---

##  Advanced Configurations

### Calculator

```ron
(
    modifiers: [],
    key: "Calculator",
    description: Some("calculator"),
): Spawn("gnome-calculator"),

// Alternative keyboard shortcut
(
    modifiers: [Super],
    key: "equal",
    description: Some("calculator"),
): Spawn("gnome-calculator"),
```

### Email Client

```ron
(
    modifiers: [],
    key: "Mail",
    description: Some("email"),
): Spawn("thunderbird"),
```

### Music Player

```ron
(
    modifiers: [Super],
    key: "m",
    description: Some("music player"),
): Spawn("spotify"),
```

### Color Picker

```ron
(
    modifiers: [Super, Shift],
    key: "c",
    description: Some("color picker"),
): Spawn("grim -g \"$(slurp -p)\" -t ppm - | convert - -format '%[pixel:p{0,0}]' txt:- | tail -n1 | cut -d' ' -f4 | wl-copy"),
```

### Emoji Picker

```ron
(
    modifiers: [Super],
    key: "period",
    description: Some("emoji picker"),
): Spawn("cosmic-launcher --emoji"),
```

### Screen Recording

```ron
(
    modifiers: [Super, Shift],
    key: "r",
    description: Some("screen recording"),
): Spawn("wf-recorder -g \"$(slurp)\" -f ~/Videos/recording-$(date +%Y%m%d-%H%M%S).mp4"),
```

---

##  Complete Example Configuration

Here's a full working configuration with all common buttons:

```ron
{
    // Screenshot
    (modifiers: [], key: "Print", description: Some("screenshot")): 
        Spawn("sh -c 'QT_QPA_PLATFORM=wayland flameshot gui'"),
    
    // Lock screen
    (modifiers: [], key: "End", description: Some("lock screen")): 
        Spawn("loginctl lock-sessions"),
    
    // Media controls
    (modifiers: [], key: "Pause", description: Some("play/pause")): 
        Spawn("playerctl play-pause"),
    (modifiers: [], key: "AudioNext", description: Some("next track")): 
        Spawn("playerctl next"),
    (modifiers: [], key: "AudioPrev", description: Some("previous track")): 
        Spawn("playerctl previous"),
    (modifiers: [], key: "AudioStop", description: Some("stop")): 
        Spawn("playerctl stop"),
    
    // Volume controls
    (modifiers: [], key: "AudioRaiseVolume", description: Some("volume up")): 
        Spawn("pactl set-sink-volume @DEFAULT_SINK@ +5%"),
    (modifiers: [], key: "AudioLowerVolume", description: Some("volume down")): 
        Spawn("pactl set-sink-volume @DEFAULT_SINK@ -5%"),
    (modifiers: [], key: "AudioMute", description: Some("mute toggle")): 
        Spawn("pactl set-sink-mute @DEFAULT_SINK@ toggle"),
    (modifiers: [], key: "AudioMicMute", description: Some("mic mute")): 
        Spawn("pactl set-source-mute @DEFAULT_SOURCE@ toggle"),
    
    // Brightness controls
    (modifiers: [], key: "MonBrightnessUp", description: Some("brightness up")): 
        Spawn("brightnessctl set +5%"),
    (modifiers: [], key: "MonBrightnessDown", description: Some("brightness down")): 
        Spawn("brightnessctl set 5%-"),
    
    // Applications
    (modifiers: [Super], key: "t", description: Some("terminal")): 
        Spawn("cosmic-term"),
    (modifiers: [Super], key: "b", description: Some("browser")): 
        Spawn("flatpak run com.brave.Browser"),
    (modifiers: [Super], key: "f", description: Some("file manager")): 
        Spawn("dolphin"),
    (modifiers: [Super], key: "n", description: Some("text editor")): 
        Spawn("cosmic-edit"),
    (modifiers: [Super], key: "k", description: Some("vscode")): 
        Spawn("code"),
    (modifiers: [Super], key: "Space", description: Some("launcher")): 
        Spawn("cosmic-launcher"),
    (modifiers: [Super], key: "c", description: Some("clipboard")): 
        Spawn("copyq toggle"),
    
    // System actions
    (modifiers: [Super], key: "Escape", description: Some("logout")): 
        Spawn("pkill -9 cosmic-session"),
    (modifiers: [Super], key: "Delete", description: Some("shutdown")): 
        Spawn("systemctl poweroff"),
    (modifiers: [Super, Shift], key: "Delete", description: Some("reboot")): 
        Spawn("systemctl reboot"),
    (modifiers: [Super], key: "s", description: Some("suspend")): 
        Spawn("systemctl suspend"),
    
    // System monitor
    (modifiers: [Super], key: "slash", description: Some("system monitor")): 
        Spawn("cosmic-term -e btop"),
}
```

---

##  How to Apply Changes

### Method 1: Edit Config File

```bash
# 1. Backup current config
cp ~/.config/cosmic/com.system76.CosmicSettings.Shortcuts/v1/custom{,.backup}

# 2. Edit the config
nano ~/.config/cosmic/com.system76.CosmicSettings.Shortcuts/v1/custom

# 3. Restart settings daemon
killall cosmic-settings-daemon && cosmic-settings-daemon &

# 4. Test your keybindings
```

### Method 2: Use COSMIC Settings GUI

```bash
# 1. Open COSMIC Settings
cosmic-settings

# 2. Navigate to: Keyboard → Shortcuts → Custom Shortcuts

# 3. Click "Add Custom Shortcut"

# 4. Fill in details and press the key combination

# 5. Click "Add"
```

---

##  Finding Key Names

### Using wev (Wayland Event Viewer)

```bash
# Install wev
sudo pacman -S wev

# Run wev
wev

# Press the key you want to find
# Look for the "sym" value in the output
```

Example output:
```
[14:     wl_keyboard] key: serial: 1234; time: 12345; key: 99; state: 1 (pressed)
                      sym: Print       ← This is the key name!
                      utf8: ""
```

### Common Key Name Patterns

- **Letters**: `a`, `b`, `c`, etc.
- **Numbers**: `1`, `2`, `3`, etc.
- **Function keys**: `F1`, `F2`, `F3`, etc.
- **Special characters**: `minus`, `equal`, `bracketleft`, `bracketright`, `semicolon`, `apostrophe`, `comma`, `period`, `slash`, `backslash`
- **Modifiers**: `Super_L`, `Control_L`, `Alt_L`, `Shift_L`

---

##  Testing Your Configuration

### Test Individual Commands

Before adding to config, test commands in terminal:

```bash
# Test screenshot
QT_QPA_PLATFORM=wayland flameshot gui

# Test media control
playerctl play-pause

# Test volume
pactl set-sink-volume @DEFAULT_SINK@ +5%

# Test brightness
brightnessctl set +5%

# Test lock
loginctl lock-sessions
```

### Verify Keybinding Works

```bash
# 1. Apply config
killall cosmic-settings-daemon && cosmic-settings-daemon &

# 2. Press the keybinding

# 3. Check for errors
journalctl --user -f | grep cosmic
```

---

##  Troubleshooting

### Keybinding Not Working

**Check syntax errors:**
```bash
# Look for missing commas, brackets, or quotes
nano ~/.config/cosmic/com.system76.CosmicSettings.Shortcuts/v1/custom
```

**Restart compositor:**
```bash
cosmic-comp --replace &
```

**Check logs:**
```bash
journalctl --user -f | grep cosmic
```

### Command Not Found

**Verify command exists:**
```bash
which playerctl
which brightnessctl
which flameshot
```

**Install missing packages:**
```bash
sudo pacman -S playerctl brightnessctl flameshot
```

### Key Name Not Recognized

**Use wev to find correct name:**
```bash
wev
# Press the key and look for "sym" value
```

### Conflicting Keybindings

**Check for duplicates:**
```bash
grep -n "key: \"Print\"" ~/.config/cosmic/com.system76.CosmicSettings.Shortcuts/v1/custom
```

**Remove or change conflicting bindings**

---

##  Required Packages

Install these packages for full functionality:

```bash
# Media control
sudo pacman -S playerctl

# Volume control (usually pre-installed)
sudo pacman -S pulseaudio-utils

# Brightness control
sudo pacman -S brightnessctl

# Screenshot tools
sudo pacman -S flameshot grim slurp swappy

# Clipboard tools
sudo pacman -S wl-clipboard

# Notifications
sudo pacman -S libnotify

# System monitor
sudo pacman -S btop

# Key name finder
sudo pacman -S wev
```

---

##  Tips & Best Practices

1. **Always backup** before editing config files
2. **Test commands** in terminal before adding to config
3. **Use descriptive names** in the description field
4. **Keep it organized** - group related keybindings together
5. **Avoid conflicts** - check existing keybindings first
6. **Use modifiers** for common keys to avoid conflicts
7. **Document your changes** - add comments in your backup
8. **Test after changes** - verify keybindings work as expected

---

##  Additional Resources

- [COSMIC Desktop Documentation](https://github.com/pop-os/cosmic-epoch)
- [RON Format Specification](https://github.com/ron-rs/ron)
- [Wayland Key Names](https://wayland.freedesktop.org/libxkbcommon/doc/latest/xkbcommon-keysyms_8h.html)
- [playerctl Documentation](https://github.com/altdesktop/playerctl)
- [brightnessctl Documentation](https://github.com/Hummer12007/brightnessctl)

---

**Last Updated**: April 10, 2026  
**System**: COSMIC Desktop on CachyOS  
**Config Location**: `~/.config/cosmic/com.system76.CosmicSettings.Shortcuts/v1/custom`
