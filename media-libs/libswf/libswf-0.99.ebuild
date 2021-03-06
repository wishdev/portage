# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libswf/libswf-0.99.ebuild,v 1.22 2009/09/23 15:18:12 ssuominen Exp $

inherit multilib

S=${WORKDIR}/dist
DESCRIPTION="A library for flash movies"
SRC_URI="http://reality.sgi.com/grafica/flash/dist.99.linux.tar.Z"
HOMEPAGE="ftp://ftp.sgi.com/sgi/graphics/grafica/flash/index.html"

SLOT="0"
LICENSE="as-is"
KEYWORDS="x86 -sparc -ppc -hppa -mips amd64"
IUSE=""

RDEPEND=""
DEPEND="app-arch/unzip"

pkg_setup() {
	has_multilib_profile && ABI="x86"
}

src_unpack () {
	unpack ${A}
	if [ -f dist.99.linux.tar ]; then
		tar -xf dist.99.linux.tar
	fi
	cd ${S}
	sed -e 's:\tswftest:\t./swftest:' -i Makefile || die "sed failed"
}

src_install () {

	dolib.a libswf.a
	dobin bin/*
	insinto /usr/include
	doins swf.h
	insinto /usr/share/swf/fonts
	doins fonts/*
	insinto /usr/share/swf/psfonts
	doins psfonts/*
	dohtml *.html
}
