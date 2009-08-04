# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/ifp-gnome/ifp-gnome-0.7.ebuild,v 1.3 2009/08/03 12:54:46 ssuominen Exp $

inherit eutils

DESCRIPTION="Gnome front-end for file management on iRiver iFP MP3 players."
HOMEPAGE="http://ifp-gnome.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-python/pyifp-0.2.2
	>=dev-python/gnome-python-2.12"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-file-locations.patch
}

src_compile() { :; }

src_install() {
	insinto /usr/share/${PN}
	doins ${PN}.{glade,png}
	newbin ${PN}.py ${PN}
}
