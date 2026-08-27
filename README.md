# Noctalia SDDM Sync 🔄

A lightweight, native bridge to automatically synchronize your [Noctalia](https://docs.noctalia.dev/) wallpaper with the [Silent SDDM](https://github.com/uiriansan/SilentSDDM) login screen theme.

## 💡 How it works
Normally, changing the SDDM wallpaper requires root (`sudo`) privileges because the theme files live in `/usr/share/`. This setup script creates a "dummy" wallpaper file owned by your local user. It then uses Noctalia's native hooks to silently overwrite this image every time you change your wallpaper, requiring zero passwords and causing zero overhead.

## 📦 Prerequisites
- Linux system using **SDDM** (Wayland/X11).
- **Noctalia v5** installed and configured.
- **Silent SDDM** theme installed in `/usr/share/sddm/themes/silent`.

## 🚀 Installation

### 1. Run the Setup Script
Clone this repository and run the installer. You will be prompted for your `sudo` password once to set up the base files.

```bash
git clone https://github.com/YOUR_USERNAME/noctalia-sddm-sync.git
cd noctalia-sddm-sync
chmod +x install.sh
./install.sh
```

### 2. Enable the Profile in Silent SDDM
Tell the Silent theme to use the newly created Noctalia configuration.

Open the theme's metadata file:
```bash
sudo nano /usr/share/sddm/themes/silent/metadata.desktop
```
Find the `ConfigFile=` line at the bottom, comment out the default, and add the noctalia profile:
```ini
# ConfigFile=configs/default.conf
ConfigFile=configs/noctalia.conf
```

### 3. Add the Noctalia Hook
Tell Noctalia to trigger the sync command whenever you pick a new wallpaper.

Open or create your Noctalia hooks configuration file:
```bash
nano ~/.config/noctalia/hooks.toml
```
Add the following lines:
```toml
[hooks]
wallpaper_changed = "cp \"$NOCTALIA_WALLPAPER_PATH\" /usr/share/sddm/themes/silent/backgrounds/current_noctalia.jpg"
```

**Restart Noctalia**, select a new wallpaper from the UI, and your SDDM login screen will automatically sync!

## 🧪 Testing
You can preview your SDDM login screen without logging out using the `sddm-greeter` test mode. *(Note: `MANGOHUD=0` is used to prevent crashes if you have MangoHud globally enabled).*

```bash
sddm-greeter-qt6 --test-mode --theme /usr/share/sddm/themes/silent
```

## 📄 License
This project is licensed under the MIT License.
