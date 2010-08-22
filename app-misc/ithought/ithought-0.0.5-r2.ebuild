# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/ithought/ithought-0.0.5-r2.ebuild,v 1.1 2010/08/22 11:17:15 hwoarang Exp $

EAPI=2

MY_P=${P/0.0./a}

DESCRIPTION="An internet-aware personal thought manager"
HOMEPAGE="http://ithought.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND="=x11-libs/gtk+-1.2*
	dev-libs/libxml2"

S=${WORKDIR}/${MY_P}

src_prepare() {
	sed -i "/CC\|LD/{s/-shared/-shared \$LDFLAGS/}" ltconfig || die
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README TODO || die
}
