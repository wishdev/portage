# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/glade/glade-3.8.0.ebuild,v 1.7 2011/10/06 18:40:13 ssuominen Exp $

EAPI="2"
GNOME_ORG_MODULE="glade3"
GNOME2_LA_PUNT="yes"

inherit eutils gnome2

DESCRIPTION="GNOME GUI Builder"
HOMEPAGE="http://glade.gnome.org/"

LICENSE="GPL-2"
SLOT="3"
KEYWORDS="alpha amd64 arm ia64 ppc ppc64 sh sparc x86 ~x86-fbsd"
IUSE="doc gnome python"

RDEPEND=">=dev-libs/glib-2.8:2
	>=x11-libs/gtk+-2.20:2
	>=dev-libs/libxml2-2.4:2
	gnome?	(
		>=gnome-base/libgnomeui-2
		>=gnome-base/libbonoboui-2 )
	python? ( >=dev-python/pygtk-2.10:2 )
"
DEPEND="${RDEPEND}
	>=dev-util/intltool-0.35
	>=dev-util/pkgconfig-0.19
	sys-devel/gettext
	app-text/scrollkeeper
	>=app-text/gnome-doc-utils-0.9
	app-text/docbook-xml-dtd:4.1.2
	doc? ( >=dev-util/gtk-doc-1.9 )
"

pkg_setup() {
	DOCS="AUTHORS ChangeLog NEWS README TODO"
	G2CONF="${G2CONF}
		--enable-libtool-lock
		--disable-scrollkeeper
		$(use_enable gnome)
		$(use_enable python)"
}

src_install() {
	gnome2_src_install
	find "${ED}"/usr/$(get_libdir)/glade3/modules -name "*.la" -delete
}

pkg_preinst() {
	gnome2_pkg_preinst
	preserve_old_lib /usr/$(get_libdir)/libgladeui-1.so.9
}

pkg_postinst() {
	gnome2_pkg_postinst
	preserve_old_lib_notify /usr/$(get_libdir)/libgladeui-1.so.9
}
