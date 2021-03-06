# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/uevt/uevt-2.3.ebuild,v 1.1 2011/09/08 10:25:55 ssuominen Exp $

EAPI=4

DESCRIPTION="A lightweight, desktop-independant daemon for disks mounting and power managing"
HOMEPAGE="http://elentir.sleipnir.fr/ http://git.sleipnir.fr/uevt/"
SRC_URI="http://ftp.sleipnir.fr/${PN}/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

COMMON_DEPEND=">=dev-libs/glib-2.26
	x11-libs/gtk+:2
	>=x11-libs/libnotify-0.7"
RDEPEND="${COMMON_DEPEND}
	sys-fs/udisks
	sys-power/upower"
DEPEND="${COMMON_DEPEND}
	>=dev-lang/vala-0.12:0.12
	dev-util/intltool
	dev-util/pkgconfig
	sys-devel/gettext"

pkg_setup() {
	export VALAC="$(type -P valac-0.12)"
	DOCS=( AUTHORS ChangeLog README )
}
