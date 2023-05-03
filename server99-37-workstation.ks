%include fedora-live-workstation.ks

repo --name="Server99" --baseurl=https://download.copr.fedorainfracloud.org/results/core-i99/Server99/fedora-37-$basearch

%packages
# Server99 features/system stuff
server99-release
server99-logos
anaconda-server99

# Removed
-fedora-release-workstation
-fedora-workstation-backgrounds
-fedora-bookmarks
-systemd-networkd
%end

%post
FOE
glib-compile-schemas /usr/share/glib-2.0/schemas
EOF

%end
