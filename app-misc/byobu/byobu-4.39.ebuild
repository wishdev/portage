# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/byobu/byobu-4.39.ebuild,v 1.1 2011/10/08 05:56:32 radhermit Exp $

EAPI="3"
PYTHON_DEPEND="2"

inherit python

DESCRIPTION="A set of profiles for the GNU Screen console window manager (app-misc/screen)"
HOMEPAGE="https://launchpad.net/byobu"
SRC_URI="http://launchpad.net/${PN}/trunk/${PV}/+download/${P/-/_}.orig.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="|| ( app-misc/screen app-misc/tmux )
	dev-libs/newt"

src_prepare() {
	python_convert_shebangs -r 2 .
}

src_install() {
	emake DESTDIR="${D}" install || die

	# Create symlinks for backends
	dosym ${PN} /usr/bin/${PN}-screen || die
	dosym ${PN} /usr/bin/${PN}-tmux || die
}
