%include fedora-live-workstation.ks

repo --name="Server99" --baseurl=https://download.copr.fedorainfracloud.org/results/core-i99/Server99/fedora-37-$basearch
repo --name="OnlyOffice" --baseurl=http://download.onlyoffice.com/repo/centos/main/noarch/

%packages

# Server99 features/system stuff

server99-release


# Applications
drawing
file-roller
chromium
onlyoffice-desktopeditors

# Removed
-abrt-desktop
-desktop-backgrounds-gnome
-gnome-classic-session
-gnome-tour
-fedora-release-workstation
-fedora-workstation-backgrounds
-rhythmbox
-mediawriter
-gnome-boxes
-fedora-bookmarks
-cheese
-libreoffice*
-unoconv
-firefox
-gnome-extensions-app
-systemd-networkd

%end

%post
# Edit favorite apps on ISO

cat >> /etc/rc.d/init.d/livesys << EOF
rm /usr/share/glib-2.0/schemas/org.gnome.shell.gschema.override

cat >> /usr/share/glib-2.0/schemas/org.gnome.shell.gschema.override << FOE
[org.gnome.shell]
favorite-apps=['chromium-browser.desktop', 'chromium-freeworld.desktop', 'org.gnome.Nautilus.desktop','org.gnome.Calendar.desktop', 'org.gnome.Photos.desktop', 'org.gnome.Totem.desktop', 'anaconda.desktop']
FOE

glib-compile-schemas /usr/share/glib-2.0/schemas
EOF

%end