# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/gnome-devel-docs/gnome-devel-docs-2.32.0.ebuild,v 1.5 2011/03/22 19:05:47 ranger Exp $

EAPI="3"
GCONF_DEBUG="no"

inherit gnome2

DESCRIPTION="Documentation for developing for the GNOME desktop environment"
HOMEPAGE="http://www.gnome.org"

LICENSE="FDL-1.1"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

RDEPEND=""
DEPEND="dev-util/pkgconfig
	app-text/gnome-doc-utils
	~app-text/docbook-xml-dtd-4.2"

pkg_setup() {
	G2CONF="${G2CONF} --disable-scrollkeeper"
	DOCS="AUTHORS ChangeLog NEWS README"
}
