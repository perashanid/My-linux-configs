# Additional System Configurations

This document contains additional configurations made after the initial COSMIC setup.

---

##  Battery Health Management (TLP)

**Purpose**: Limit battery charging to 80% to extend battery lifespan when laptop is always plugged in.

### Installation

```bash
# Install TLP power management tool
sudo pacman -S tlp --noconfirm

# Enable TLP service
sudo systemctl enable --now tlp.service
```

### Configuration

```bash
# Set battery charge thresholds
# Start charging when battery drops below 60%
sudo sed -i 's/#START_CHARGE_THRESH_BAT0=75/START_CHARGE_THRESH_BAT0=60/' /etc/tlp.conf

# Stop charging when battery reaches 80%
sudo sed -i 's/#STOP_CHARGE_THRESH_BAT0=80/STOP_CHARGE_THRESH_BAT0=80/' /etc/tlp.conf

# Apply settings
sudo tlp start
```

### Manual Battery Limit (Alternative)

```bash
# Set battery charge limit to 80% immediately
echo 80 | sudo tee /sys/class/power_supply/BATT/charge_control_end_threshold

# Verify the setting
cat /sys/class/power_supply/BATT/charge_control_end_threshold
```

### GUI Tool (Optional)

```bash
# Install TLPUI for graphical interface
sudo pacman -S tlpui --noconfirm

# Launch TLPUI
tlpui
```

### What This Does

- **Stops charging at 80%**: Prevents battery degradation from staying at 100%
- **Starts charging at 60%**: Ensures you have usable battery capacity
- **Extends battery life**: From ~500 cycles to 1500+ cycles
- **Best for**: Laptops that stay plugged in most of the time

### Check Battery Status

```bash
# View detailed battery information
tlp-stat -b

# Check current charge threshold
cat /sys/class/power_supply/BATT/charge_control_end_threshold
```

---

##  qBittorrent Port Forwarding Fix

**Purpose**: Fix seeding not counting on tracker websites due to port forwarding issues on Linux.

### The Problem

- qBittorrent on Linux binds to specific network interfaces by default
- Prevents external peers from connecting
- Seeding doesn't count on tracker websites
- Works on Windows but not Linux

### The Fix

**Step 1: Stop qBittorrent**

```bash
killall qbittorrent
```

**Step 2: Enable UPnP in Config**

```bash
# Enable UPnP for automatic port forwarding
sed -i '/\[Preferences\]/a Connection\\UPnP=true\nConnection\\PortForwardingEnabled=true' ~/.config/qBittorrent/qBittorrent.conf
```

**Step 3: Clear Interface Binding**

```bash
# Remove specific interface binding
sed -i 's/Session\\Interface=.*/Session\\Interface=/' ~/.config/qBittorrent/qBittorrent.conf

# Set to listen on all interfaces (0.0.0.0)
sed -i 's/Session\\InterfaceAddress=.*/Session\\InterfaceAddress=0.0.0.0/' ~/.config/qBittorrent/qBittorrent.conf
```

**Step 4: Open Firewall Ports**

```bash
# Find the port qBittorrent is using (check in qBittorrent GUI: Tools → Options → Connection)
# Replace XXXXX with your actual port number

# Open TCP port
sudo ufw allow XXXXX/tcp

# Open UDP port
sudo ufw allow XXXXX/udp
```

**Example with port 61454:**

```bash
sudo ufw allow 61454/tcp
sudo ufw allow 61454/udp
```

**Step 5: Restart qBittorrent**

```bash
qbittorrent --no-splash &
```

### Verify the Fix

**Check if qBittorrent is listening:**

```bash
ss -tulpn | grep qbittorrent
```

**Check firewall rules:**

```bash
sudo ufw status numbered
```

**Test port online:**
- Visit: https://www.yougetsignal.com/tools/open-ports/
- Enter your qBittorrent port number
- Should show "open"

### What Each Command Does

1. **`killall qbittorrent`**
   - Stops qBittorrent so config changes can be made

2. **`sed -i '/\[Preferences\]/a Connection\\UPnP=true...'`**
   - Enables UPnP (Universal Plug and Play)
   - Allows router to automatically forward ports

3. **`sed -i 's/Session\\Interface=.*/Session\\Interface=/'`**
   - Clears specific interface binding
   - Allows qBittorrent to use any network interface

4. **`sed -i 's/Session\\InterfaceAddress=.*/Session\\InterfaceAddress=0.0.0.0/'`**
   - Sets listening address to 0.0.0.0 (all interfaces)
   - Allows external connections from any network

5. **`sudo ufw allow XXXXX/tcp` and `sudo ufw allow XXXXX/udp`**
   - Opens the port in Linux firewall
   - Allows incoming connections for both TCP and UDP protocols

### Manual GUI Configuration (Alternative)

If you prefer to configure via GUI:

1. Open qBittorrent
2. Tools → Options → Connection
3. Check "Use UPnP / NAT-PMP port forwarding from my router"
4. Tools → Options → Advanced
5. Set "Network interface" to "Any interface"
6. Set "Optional IP address to bind to" to "All addresses"
7. Click OK and restart qBittorrent

### Troubleshooting

**Seeding still not counting:**

1. Check if port is open:
   ```bash
   ss -tulpn | grep qbittorrent
   ```

2. Verify firewall allows the port:
   ```bash
   sudo ufw status | grep <port_number>
   ```

3. Test port online at https://www.yougetsignal.com/tools/open-ports/

4. If port is closed, manually forward it in your router:
   - Open router admin page (usually http://192.168.0.1 or http://192.168.1.1)
   - Find "Port Forwarding" or "Virtual Server"
   - Forward the qBittorrent port (TCP and UDP) to your laptop's local IP

**Find your local IP:**

```bash
ip addr show wlan0 | grep "inet " | awk '{print $2}' | cut -d/ -f1
```

---

##  Git Repository Organization

**Purpose**: Keep all git clones organized in one folder.

### Setup

```bash
# Create repos folder
mkdir -p ~/repos
```

### Usage

**Always clone into repos folder:**

```bash
# Navigate to repos folder first
cd ~/repos

# Then clone
git clone <repository_url>
```

**Or clone directly to repos:**

```bash
git clone <repository_url> ~/repos/
```

### Move Existing Repos

```bash
# Move existing repositories to repos folder
mv ~/qylock ~/repos/
mv ~/glyph-sddm ~/repos/
```

---

##  Summary of Changes

### Battery Management
-  TLP installed and configured
-  Battery charge limited to 60-80% range
-  TLPUI installed for GUI management
-  Optimal for laptops that stay plugged in

### qBittorrent Fixes
-  UPnP enabled for automatic port forwarding
-  Interface binding cleared (now listens on all interfaces)
-  Firewall ports opened (TCP and UDP)
-  Seeding now counts on tracker websites

### Organization
-  Created ~/repos/ folder for git repositories
-  All future git clones should go in ~/repos/

---

##  Quick Reference Commands

### Battery

```bash
# Check battery status
tlp-stat -b

# Check charge threshold
cat /sys/class/power_supply/BATT/charge_control_end_threshold

# Open TLP GUI
tlpui
```

### qBittorrent

```bash
# Check listening ports
ss -tulpn | grep qbittorrent

# Check firewall rules
sudo ufw status

# Restart qBittorrent
killall qbittorrent && qbittorrent --no-splash &
```

### Network

```bash
# Find your local IP
ip addr show wlan0 | grep "inet "

# Check open ports
sudo ufw status numbered

# Test port online
# Visit: https://www.yougetsignal.com/tools/open-ports/
```

---

**Last Updated**: April 10, 2026  
**System**: CachyOS with COSMIC Desktop
