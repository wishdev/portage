# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:

EAPI=4

MY_PN="KFaenza"
DESCRIPTION="Faenza-Cupertino icon theme for KDE"
HOMEPAGE="http://kde-look.org/content/show.php/KFaenza?content=143890"
#That is upstream location, not reupload. Don't fix/
SRC_URI="http://ompldr.org/vYXQ5Zg/${PN}-${PV}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

S="${WORKDIR}"/"${MY_PN}"
RESTRICT="binchecks strip"

src_prepare() {
	local res
	for res in 22 32 48 64 128 256; do
		cp "${S}"/places/${res}/start-here-gentoo.png \
			"${S}"/places/${res}/start-here.png || die
	done
	cp "${S}"/places/scalable/start-here-gentoo.svg \
		"${S}"/places/scalable/start-here.svg || die
}

src_install() {
	dodir /usr/share/icons
	cp -R "${S}/" "${D}"/usr/share/icons || die "Install failed!"
}
