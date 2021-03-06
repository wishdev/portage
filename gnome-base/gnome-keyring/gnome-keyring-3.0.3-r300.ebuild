# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gnome-keyring/gnome-keyring-3.0.3-r300.ebuild,v 1.1 2011/08/14 15:13:25 nirbheek Exp $

EAPI="3"
GCONF_DEBUG="no"
GNOME2_LA_PUNT="yes"

inherit autotools eutils gnome2 multilib pam virtualx

DESCRIPTION="Password and keyring managing daemon"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2 LGPL-2"
SLOT="0"
IUSE="+caps debug doc pam test"
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~mips ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd
~amd64-linux ~sparc-solaris ~x86-linux ~x86-solaris"

# USE=valgrind is probably not a good idea for the tree
#
# XXX: ARGH: libgcr is slotted, but libgck is not.
# Hence, gtk2/3 versions are not parallel installable.
RDEPEND=">=dev-libs/glib-2.25:2
	>=x11-libs/gtk+-2.90.0:3
	gnome-base/gconf:2
	>=sys-apps/dbus-1.0
	>=dev-libs/libgcrypt-1.2.2
	>=dev-libs/libtasn1-1
	caps? ( sys-libs/libcap )
	pam? ( virtual/pam )
"
#	valgrind? ( dev-util/valgrind )
DEPEND="${RDEPEND}
	sys-devel/gettext
	>=dev-util/gtk-doc-am-1.9
	>=dev-util/intltool-0.35
	>=dev-util/pkgconfig-0.9
	doc? ( >=dev-util/gtk-doc-1.9 )"
PDEPEND="gnome-base/libgnome-keyring"
# eautoreconf needs:
#	>=dev-util/gtk-doc-am-1.9

pkg_setup() {
	DOCS="AUTHORS ChangeLog NEWS README"
	G2CONF="${G2CONF}
		$(use_enable debug)
		$(use_enable test tests)
		$(use_with caps libcap)
		$(use_enable pam)
		$(use_with pam pam-dir $(getpam_mod_dir))
		--with-root-certs=${EPREFIX}/etc/ssl/certs/
		--enable-ssh-agent
		--enable-gpg-agent
		--with-gtk=3.0"
#		$(use_enable valgrind)
}

src_prepare() {
	# Disable gcr tests due to weirdness with opensc
	# ** WARNING **: couldn't load PKCS#11 module: /usr/lib64/pkcs11/gnome-keyring-pkcs11.so: Couldn't initialize module: The device was removed or unplugged
	sed -e 's/^\(SUBDIRS = \.\)\(.*\)/\1/' \
		-i gcr/Makefile.* || die "sed failed"

	# https://bugzilla.gnome.org/show_bug.cgi?id=649936
	epatch "${FILESDIR}"/${PN}-3.0.2-automagic-libcap.patch
	eautoreconf
	gnome2_src_prepare
}

src_test() {
	# FIXME: /gkm/transaction/ tests fail
	unset DBUS_SESSION_BUS_ADDRESS
	Xemake check || die "emake check failed!"
}
