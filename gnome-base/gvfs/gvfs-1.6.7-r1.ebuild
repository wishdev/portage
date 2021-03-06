# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gvfs/gvfs-1.6.7-r1.ebuild,v 1.6 2011/10/17 16:46:51 ssuominen Exp $

EAPI="4"
GNOME2_LA_PUNT="yes"
GNOME_TARBALL_SUFFIX="bz2"
GCONF_DEBUG="no"

inherit autotools bash-completion gnome2 eutils

DESCRIPTION="GNOME Virtual Filesystem Layer"
HOMEPAGE="http://www.gnome.org"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~ia64 ~mips ppc ppc64 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE="archive avahi bluetooth cdda doc fuse gdu gnome gnome-keyring gphoto2 +http ios prefix samba +udev"

RDEPEND=">=dev-libs/glib-2.23.4:2
	>=sys-apps/dbus-1.0
	dev-libs/libxml2
	net-misc/openssh
	!prefix? ( >=sys-fs/udev-138 )
	archive? ( app-arch/libarchive )
	avahi? ( >=net-dns/avahi-0.6 )
	bluetooth? (
		>=app-mobilephone/obex-data-server-0.4.5
		dev-libs/dbus-glib
		net-wireless/bluez
		dev-libs/expat )
	fuse? ( >=sys-fs/fuse-2.8.0 )
	gdu? ( >=sys-apps/gnome-disk-utility-2.29 )
	gnome? ( >=gnome-base/gconf-2.0 )
	gnome-keyring? ( >=gnome-base/gnome-keyring-1.0 )
	gphoto2? ( >=media-libs/libgphoto2-2.4.7 )
	ios? ( app-pda/libimobiledevice )
	udev? (
		cdda? ( >=dev-libs/libcdio-0.78.2[-minimal] )
		|| ( >=sys-fs/udev-171[gudev] >=sys-fs/udev-145[extras] ) )
	http? ( >=net-libs/libsoup-gnome-2.26.0 )
	samba? ( >=net-fs/samba-3.4.6[smbclient] )"
DEPEND="${RDEPEND}
	>=dev-util/intltool-0.40
	>=dev-util/pkgconfig-0.19
	dev-util/gtk-doc-am
	doc? ( >=dev-util/gtk-doc-1 )"

pkg_setup() {
	if use cdda && ! use udev; then
		ewarn
		ewarn "You need to enable USE=\"udev\" for USE=\"cdda\" to be useful."
		ewarn
	fi

	G2CONF="${G2CONF}
		--disable-hal
		--disable-bash-completion
		--with-dbus-service-dir=/usr/share/dbus-1/services
		$(use_enable archive)
		$(use_enable avahi)
		$(use_enable bluetooth obexftp)
		$(use_enable cdda)
		$(use_enable fuse)
		$(use_enable gdu)
		$(use_enable gnome gconf)
		$(use_enable gphoto2)
		$(use_enable ios afc)
		$(use_enable udev gudev)
		$(use_enable http)
		$(use_enable gnome-keyring keyring)
		$(use_enable samba)
		$(use_enable !prefix udev)"

	DOCS="AUTHORS ChangeLog NEWS README TODO"
}

src_prepare() {
	gnome2_src_prepare

	# Conditional patching purely to avoid eautoreconf
	use gphoto2 && epatch "${FILESDIR}/${PN}-1.2.2-gphoto2-stricter-checks.patch"

	if use archive; then
		epatch "${FILESDIR}/${PN}-1.2.2-expose-archive-backend.patch"
		echo "mount-archive.desktop.in" >> po/POTFILES.in
		echo "mount-archive.desktop.in.in" >> po/POTFILES.in
	fi

	if use prefix; then
		sed -i -e 's/gvfsd-burn/ /' daemon/Makefile.am || die
		sed -i -e 's/burn.mount.in/ /' daemon/Makefile.am || die
		sed -i -e 's/burn.mount/ /' daemon/Makefile.am || die
	fi

	{ use gphoto2 || use archive || use prefix; } && eautoreconf

	# Disable API deprecation
	sed 's/-DG_DISABLE_DEPRECATED//' \
		-i */*/Makefile.am */*/Makefile.in */Makefile.am */Makefile.in \
		|| die "sed failed"

	# afc: Fix renaming files moving them to the root dir
	epatch "${FILESDIR}/${P}-fix-renaming.patch"
}

src_install() {
	gnome2_src_install
	use bash-completion && \
		dobashcompletion programs/gvfs-bash-completion.sh ${PN}
}

pkg_postinst() {
	gnome2_pkg_postinst
	use bash-completion && bash-completion_pkg_postinst

	ewarn "In order to use the new gvfs services, please reload dbus configuration"
	ewarn "You may need to log out and log back in for some changes to take effect"
}
