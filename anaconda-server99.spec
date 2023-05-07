Summary:	Server99 Anaconda Config Files
Name:     	anaconda-server99
Version:	0.1
Release:	4%{?dist}
License:	GPLv2+ and MIT
URL: 		https://github.com/Server99-industries/server99-meta

BuildArch: 	noarch
Requires: 	anaconda
Requires:	server99-logos

%description
Server99 Anaconda Config Files

%prep
%build
cat > Server99.conf <<EOF
# Anaconda configuration file for Server99.

[Profile]
# Define the profile.
profile_id = server99
base_profile = fedora-workstation

[Profile Detection]
# Match os-release values.
os_id = server99

[Post Installation]
# Remove graphical user interface packages to make the system CLI-only
chroot = /mnt/sysroot /bin/bash -c "dnf remove @gnome-desktop -y && dnf autoremove -y && systemctl set-default multi-user.target"

EOF

%install
mkdir -p %{buildroot}%{_sysconfdir}/anaconda/profile.d
install -m 655 Server99.conf %{buildroot}%{_sysconfdir}/anaconda/profile.d/Server99.conf

%files
%{_sysconfdir}/anaconda/profile.d/Server99.conf

%changelog
* Wed May 03 2023 Core-i99
- spec file created
