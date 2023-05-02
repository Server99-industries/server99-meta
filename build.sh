VERSION=37
DATE=$(date +"%Y%m%d")

rm -rf fedora-kickstarts
rm anaconda.log
rm Server99-Live-$VERSION-$DATE.iso
rm Server99-Live-$VERSION-$DATE.iso.md5

git clone https://pagure.io/fedora-kickstarts.git --branch=f$VERSION
cp server99-$VERSION-workstation.ks fedora-kickstarts/server99-$VERSION-workstation.ks
cd fedora-kickstarts
ksflatten -v, --config server99-$VERSION-workstation.ks -o ../Server99-$VERSION-live-flat.ks --version f$VERSION
cd ..
mock -r server99-$VERSION-x86_64.cfg --init
mock --root server99-$VERSION-x86_64.cfg --install lorax-lmc-novirt nano sed
mock --root server99-$VERSION-x86_64.cfg --copyin Server99-$VERSION-live-flat.ks /
mock --root server99-$VERSION-x86_64.cfg --enable-network --isolation=simple --chroot "livemedia-creator --ks /Server99-$VERSION-live-flat.ks --logfile /var/tmp/lmc-logs/livemedia-out.log --no-virt --resultdir /var/tmp/lmc --project Server99 --make-iso --volid Server99-Live-$VERSION-$DATE.n.0 --iso-only --iso-name Server99-Live-$VERSION-$DATE.iso --releasever $VERSION --macboot"
mock --root server99-$VERSION-x86_64.cfg --copyout /var/tmp/lmc/Server99-Live-$VERSION-$DATE.iso .
mock --root server99-$VERSION-x86_64.cfg --copyout /var/tmp/lmc-logs/anaconda/anaconda.log .
mock --root server99-$VERSION-x86_64.cfg --clean

rm -rf fedora-kickstarts

md5sum Server99-Live-$VERSION-$DATE.iso > Server99-Live-$VERSION-$DATE.iso.md5 
mock -r server99-$VERSION-x86_64.cfg --scrub=all
rm Server99-$VERSION-live-flat.ks
