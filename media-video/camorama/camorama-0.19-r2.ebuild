# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/camorama/camorama-0.19-r2.ebuild,v 1.4 2011/10/04 14:07:44 nativemad Exp $

EAPI=2
inherit eutils gnome2

DESCRIPTION="A webcam application featuring various image filters"
HOMEPAGE="http://git.gnome.org/browse/camorama/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

RDEPEND=">=gnome-base/gconf-2
	>=gnome-base/libglade-2
	>=gnome-base/libgnome-2
	>=gnome-base/libgnomeui-2
	media-libs/libv4l
	x11-libs/gtk+:2"
DEPEND="${RDEPEND}
	dev-util/intltool
	dev-util/pkgconfig
	sys-devel/gettext"

pkg_setup() {
	G2CONF="${G2CONF} --disable-schemas-install"
	SCROLLKEEPER_UPDATE="0"
}

src_prepare() {
	epatch \
		"${FILESDIR}"/${P}-gconf.patch \
		"${FILESDIR}"/${P}-fixes.patch \
		"${FILESDIR}"/${P}-libv4l.patch \
		"${FILESDIR}"/${P}-no-more-videodev_h.patch

	gnome2_src_prepare
}
