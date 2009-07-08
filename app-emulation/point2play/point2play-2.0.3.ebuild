# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/point2play/point2play-2.0.3.ebuild,v 1.6 2009/07/07 23:09:17 flameeyes Exp $

inherit eutils

MY_P=${PN}-small-${PV}
DESCRIPTION="graphical frontend for WineX"
HOMEPAGE="http://www.transgaming.com/"
SRC_URI="${MY_P}.tgz"
#SRC_URI="!emerald? ( ${MY_P}.tgz ) emerald? ( ${MY_P}_emerald.tgz )"

LICENSE="point2play"
SLOT="0"
KEYWORDS="-* ~amd64 x86"
IUSE="" #emerald"
RESTRICT="fetch"

RDEPEND="x11-libs/libX11
	virtual/opengl
	>=dev-lang/python-2.3
	>=dev-python/pygtk-2.4
	amd64? ( >=app-emulation/emul-linux-x86-soundlibs-2.1 )"
	#>=x11-themes/gtk-engines-metal-2.2.0"

S=${WORKDIR}

pkg_nofetch() {
	elog "Please download the appropriate Point2Play archive:"
#	use emerald \
#		&& elog "   ${MY_P}_emerald.tgz" \
#		||
	elog "   ${MY_P}.tgz"
	elog "from ${HOMEPAGE} (requires a Transgaming subscription)"
	echo
	elog "The archive should then be placed into ${DISTDIR}"
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/1.3.2-fix-sound-test.patch
}

src_install() {
	mv usr "${D}"/ || die "mv usr"
	# remove duplicated desktop files
	rm -r "${D}"/usr/share/{gnome,appplications,applnk}
}
