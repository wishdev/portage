# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/tellico/tellico-2.3.4.ebuild,v 1.1 2011/10/17 21:53:18 dilfridge Exp $

EAPI=4

KDE_LINGUAS="bg bs ca ca@valencia cs da de el en_GB eo es et eu fi fr ga gl hu ia it ja lt ms nb nds nl nn
pl pt pt_BR ro ru sk sv tr ug uk zh_CN zh_TW"
inherit kde4-base

DESCRIPTION="A collection manager for the KDE environment"
HOMEPAGE="http://tellico-project.org/"
SRC_URI="http://tellico-project.org/files/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="addressbook cddb debug +handbook musicbrainz pdf scanner semantic-desktop taglib v4l xmp yaz"

DEPEND="
	dev-libs/libxml2
	dev-libs/libxslt
	dev-libs/qjson
	$(add_kdebase_dep kdelibs 'semantic-desktop?')
	media-libs/qimageblitz
	x11-libs/qt-dbus:4
	addressbook? ( $(add_kdebase_dep kdepimlibs) )
	cddb? ( $(add_kdebase_dep libkcddb) )
	pdf? ( >=app-text/poppler-0.12.3-r3[qt4] )
	musicbrainz? ( >=media-libs/musicbrainz-2.1.5 )
	scanner? ( $(add_kdebase_dep libksane) )
	semantic-desktop? ( dev-libs/soprano[raptor,redland] )
	taglib? ( >=media-libs/taglib-1.5 )
	v4l? ( >=media-libs/libv4l-0.8.3 )
	xmp? ( >=media-libs/exempi-2 )
	yaz? ( >=dev-libs/yaz-2 )
"
RDEPEND="${DEPEND}"

DOCS=( AUTHORS ChangeLog README )

PATCHES=(
	"${FILESDIR}/${PN}-2.3.4-kdepimlibs.patch"
)

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_enable v4l WEBCAM)
		$(cmake-utils_use_with xmp Exempi)
		$(cmake-utils_use_with scanner KSane)
		$(cmake-utils_use_with cddb Kcddb)
		$(cmake-utils_use_with addressbook KdepimLibs)
		$(cmake-utils_use_with pdf PopplerQt4)
		$(cmake-utils_use_with taglib)
		$(cmake-utils_use_with yaz)
	)

	kde4-base_src_configure
}
