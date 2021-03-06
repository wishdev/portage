# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/krita/krita-2.3.3.ebuild,v 1.4 2011/08/08 21:04:33 dilfridge Exp $

EAPI=3

KMNAME="koffice"
KMMODULE="${PN}"
OPENGL_REQUIRED="optional"
inherit kde4-meta

DESCRIPTION="KOffice image manipulation program."

KEYWORDS="amd64 x86"
IUSE="gmm +kdcraw openexr +pdf +tiff"

DEPEND="
	>=app-office/koffice-libs-${PV}:${SLOT}[openexr=]
	>=dev-cpp/eigen-2.0.3:2
	>=media-libs/qimageblitz-0.0.4
	>=media-gfx/exiv2-0.16
	sci-libs/fftw:3.0
	sys-devel/gcc[openmp]
	gmm? ( sci-mathematics/gmm )
	kdcraw? ( $(add_kdebase_dep libkdcraw) )
	opengl? ( media-libs/glew )
	pdf? ( >=app-text/poppler-0.12.3-r3[qt4] )
"
RDEPEND="${DEPEND}"

PATCHES=( "${FILESDIR}/${PN}-2.3.1-linkx11.patch" )

KMEXTRACTONLY="
	KoConfig.h.cmake
	libs/
"

KMLOADLIBS="koffice-libs"

src_configure() {
	mycmakeargs=(
		-DWITH_Eigen2=ON
		-DWITH_Exiv2=ON
		-DWITH_FFTW3=ON
		-DWITH_JPEG=ON
		$(cmake-utils_use_with openexr OpenEXR)
		$(cmake-utils_use_with gmm)
		$(cmake-utils_use_with tiff)
		$(cmake-utils_use_with kdcraw)
		$(cmake-utils_use_with pdf Poppler)
		$(cmake-utils_use_with opengl OpenGL)
		$(cmake-utils_use_with opengl GLEW)
	)

	kde4-meta_src_configure
}

src_install() {
	kde4-meta_src_install

	# this is already installed by koffice-data
	rm -f "${D}/usr/include/config-opengl.h"
	rm -f "${D}/usr/include/KoConfig.h"
}
