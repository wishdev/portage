# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/evolution-exchange/evolution-exchange-2.32.3.ebuild,v 1.3 2011/10/16 17:58:25 xarthisius Exp $

EAPI="4"
GCONF_DEBUG="yes"
GNOME2_LA_PUNT="yes"
GNOME_TARBALL_SUFFIX="bz2"

inherit gnome2

DESCRIPTION="Evolution module for connecting to Microsoft Exchange"
HOMEPAGE="http://projects.gnome.org/evolution/"
LICENSE="GPL-2"

SLOT="2.0"
KEYWORDS="~alpha amd64 ~ia64 ppc ppc64 ~sparc ~x86"
IUSE="debug doc static"

RDEPEND="
	>=mail-client/evolution-2.32.2:2.0
	>=gnome-extra/evolution-data-server-2.32.2[ldap,kerberos]
	>=dev-libs/glib-2.16:2
	>=x11-libs/gtk+-2.20:2
	>=gnome-base/gconf-2:2
	dev-libs/libxml2:2
	net-libs/libsoup:2.4
	>=net-nds/openldap-2.1.30-r2
	virtual/krb5"

DEPEND="${RDEPEND}
	>=dev-util/intltool-0.40
	dev-util/pkgconfig
	doc? ( >=dev-util/gtk-doc-1.9 )"

pkg_setup() {
	G2CONF="${G2CONF}
		--with-krb5=/usr
		--with-openldap
		--disable-static
		--disable-maintainer-mode
		--disable-gtk3
		$(use_enable debug e2k-debug)
		$(use_with static static-ldap)"
	DOCS="AUTHORS ChangeLog NEWS README"
}

src_prepare() {
	gnome2_src_prepare

	# FIXME: Fix compilation flags crazyness
	sed 's/^\(AM_CPPFLAGS="\)$WARNING_FLAGS/\1/' \
		-i configure.ac configure || die "sed 1 failed"
}
