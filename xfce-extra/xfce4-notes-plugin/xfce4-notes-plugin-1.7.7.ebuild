# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-notes-plugin/xfce4-notes-plugin-1.7.7.ebuild,v 1.11 2011/05/19 20:48:10 ssuominen Exp $

EAPI=4
inherit xfconf

DESCRIPTION="Xfce4 panel sticky notes plugin"
HOMEPAGE="http://goodies.xfce.org/projects/panel-plugins/xfce4-notes-plugin"
SRC_URI="mirror://xfce/src/panel-plugins/${PN}/1.7/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sparc x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~ia64-linux ~x86-linux"
IUSE=""

RDEPEND=">=dev-libs/glib-2.16:2
	>=x11-libs/gtk+-2.18:2
	>=xfce-base/libxfcegui4-4.8
	>=xfce-base/libxfce4util-4.8
	>=xfce-base/xfce4-panel-4.8
	>=xfce-base/xfconf-4.8
	dev-libs/libunique:1"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-util/intltool"

pkg_setup() {
	XFCONF=( --disable-static )
	DOCS=( AUTHORS ChangeLog NEWS README )
}
