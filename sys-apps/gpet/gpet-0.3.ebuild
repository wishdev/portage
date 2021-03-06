# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/gpet/gpet-0.3.ebuild,v 1.1 2011/09/05 14:19:45 naota Exp $

EAPI=4

DESCRIPTION="GTK+ based TOMOYO policy editor"
HOMEPAGE="http://en.sourceforge.jp/projects/gpet/"
SRC_URI="mirror://sourceforge.jp/gpet/52987/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="gnome-base/gconf
	sys-devel/gettext
	x11-libs/cairo
	x11-libs/gtk+
	x11-libs/pango"
DEPEND="${RDEPEND}
	dev-util/intltool
	dev-util/pkgconfig"
