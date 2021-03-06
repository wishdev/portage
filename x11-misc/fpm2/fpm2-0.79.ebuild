# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/fpm2/fpm2-0.79.ebuild,v 1.2 2011/07/07 22:10:04 hwoarang Exp $

EAPI="4"

DESCRIPTION="A GUI password manager utility with password generator"
HOMEPAGE="http://als.regnet.cz/fpm2/"
SRC_URI="http://als.regnet.cz/${PN}/download/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="2"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-util/pkgconfig"

RDEPEND=">=x11-libs/gtk+-2.10.14
	dev-libs/libxml2"

DOCS="AUTHORS ChangeLog NEWS README TODO"

src_prepare() {
	# fix tests
	for x in ${PN}.glade data/${PN}.desktop.in; do
		echo "${x}" >> "${S}"/po/POTFILES.in
	done
}
