# Dconf Backup and Restore

```bash
# Backup
dconf dump /org/gnome/terminal/legacy/profiles:/ > gnome-terminal-profiles.dconf
# Restore
dconf load /org/gnome/terminal/legacy/profiles:/ < gnome-terminal-profiles.dconf
```
