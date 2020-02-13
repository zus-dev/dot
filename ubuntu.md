## Enable Fractional Scaling in Ubuntu 19.10 Eoan
```
gsettings set org.gnome.mutter experimental-features "['x11-randr-fractional-scaling']"
gsettings set org.gnome.mutter experimental-features "['scale-monitor-framebuffer']"
```
To undo the change, run command:
```
gsettings reset org.gnome.mutter experimental-features
```
