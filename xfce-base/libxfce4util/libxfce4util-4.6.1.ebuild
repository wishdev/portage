# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-base/libxfce4util/libxfce4util-4.6.1.ebuild,v 1.15 2010/07/21 13:54:41 ssuominen Exp $

EAPI=2
inherit xfconf

DESCRIPTION="Basic utility library for Xfce4"
HOMEPAGE="http://www.xfce.org/projects/libraries"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sh sparc x86 ~x86-fbsd ~x86-freebsd ~x86-interix ~amd64-linux ~x86-linux ~x64-solaris ~x86-solaris"
IUSE="debug"

RDEPEND=">=dev-libs/glib-2.12:2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	sys-devel/gettext
	dev-util/intltool"

pkg_setup() {
	XFCONF="--disable-dependency-tracking
		--disable-static
		$(use_enable debug)"
	DOCS="AUTHORS ChangeLog NEWS README THANKS TODO"
}
