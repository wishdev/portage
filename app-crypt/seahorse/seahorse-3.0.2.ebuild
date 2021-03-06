# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/seahorse/seahorse-3.0.2.ebuild,v 1.1 2011/08/16 23:22:14 nirbheek Exp $

EAPI="3"
GCONF_DEBUG="yes"
GNOME2_LA_PUNT="yes"

inherit gnome2
if [[ ${PV} = 9999 ]]; then
	inherit gnome2-live
fi

DESCRIPTION="A GNOME application for managing encryption keys"
HOMEPAGE="http://www.gnome.org/projects/seahorse/index.html"

LICENSE="GPL-2"
SLOT="0"
IUSE="avahi debug doc +introspection ldap libnotify test"
if [[ ${PV} = 9999 ]]; then
	KEYWORDS=""
else
	KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
fi

# Pull in libnotify-0.7 because it's controlled via an automagic ifdef
COMMON_DEPEND="
	>=gnome-base/gconf-2:2
	>=dev-libs/glib-2.10:2
	>=x11-libs/gtk+-2.90.0:3[introspection?]
	>=dev-libs/dbus-glib-0.72
	>=gnome-base/gnome-keyring-2.91.2
	net-libs/libsoup:2.4
	x11-misc/shared-mime-info

	net-misc/openssh
	>=app-crypt/gpgme-1
	|| (
		=app-crypt/gnupg-2.0*
		=app-crypt/gnupg-1.4* )

	avahi? ( >=net-dns/avahi-0.6 )
	introspection? ( >=dev-libs/gobject-introspection-0.6.4 )
	ldap? ( net-nds/openldap )
	libnotify? ( >=x11-libs/libnotify-0.7.0 )
"
DEPEND="${COMMON_DEPEND}
	sys-devel/gettext
	>=app-text/gnome-doc-utils-0.3.2
	>=app-text/scrollkeeper-0.3
	>=dev-util/pkgconfig-0.20
	>=dev-util/intltool-0.35
	doc? ( >=dev-util/gtk-doc-1.9 )
"
# Need seahorse-plugins git snapshot
RDEPEND="${COMMON_DEPEND}
	!<app-crypt/seahorse-plugins-2.91.0_pre20110114
"

pkg_setup() {
	G2CONF="${G2CONF}
		--enable-pgp
		--enable-ssh
		--enable-pkcs11
		--disable-static
		--disable-scrollkeeper
		--disable-update-mime-database
		--enable-hkp
		--with-gtk=3.0
		$(use_enable avahi sharing)
		$(use_enable debug)
		$(use_enable introspection)
		$(use_enable ldap)
		$(use_enable libnotify)
		$(use_enable test tests)"
	DOCS="AUTHORS ChangeLog NEWS README TODO THANKS"
}

src_prepare() {
	# FIXME: Do not mess with CFLAGS with USE="debug"
	sed -e '/CFLAGS="$CFLAGS -g -O0/d' \
		-e 's/-Werror//' \
		-i configure.in configure || die "sed 1 failed"

	# FIXME: Disable test not ported to gtk:3
	sed -e 's/^SUBDIRS = .*/SUBDIRS = /' \
		-i libcryptui/Makefile.am libcryptui/Makefile.in || die "sed 2 failed"

	gnome2_src_prepare
}
