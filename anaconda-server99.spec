Summary:	Server99 Anaconda Config Files
Name:     	anaconda-server99
Version:	0.2
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
base_profile = fedora-server

[Profile Detection]
# Match os-release values.
os_id = server99
firstboot_root_password = required
sshd_permit_root_login = yes
can_change_users = False

[Users]
# Ignore user creation during installation.
ignored_users = root

[Package]
# Exclude example-package from installation.
excludepkgs = @GNOME

%packages
-gnome-desktop


EOF

%install
mkdir -p %{buildroot}%{_sysconfdir}/anaconda/profile.d
install -m 655 Server99.conf %{buildroot}%{_sysconfdir}/anaconda/profile.d/Server99.conf

%files
%{_sysconfdir}/anaconda/profile.d/Server99.conf

%changelog
* Wed May 03 2023 Core-i99
- spec file created
