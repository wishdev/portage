# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/golly/golly-2.2.ebuild,v 1.4 2011/09/27 22:36:43 xmw Exp $

EAPI=2
PYTHON_DEPEND=2
WX_GTK_VER=2.8

inherit eutils python wxwidgets

MY_P=${P}-src
DESCRIPTION="A simulator for Conway's Game of Life and other cellular automata"
HOMEPAGE="http://golly.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="<dev-lang/perl-5.14
	x11-libs/wxGTK:${WX_GTK_VER}[X]"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${MY_P}

pkg_setup() {
	python_set_active_version 2
}

src_configure() {
	econf \
		--with-perl-shlib="libperl.so" \
		--with-python-shlib="$(python_get_library)"
}

src_install() {
	emake docdir= DESTDIR="${D}" install || die
	dodoc README
}
