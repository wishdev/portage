# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/seabios/seabios-0.6.3_pre20010817.ebuild,v 1.3 2011/09/19 17:27:23 cardoe Exp $

EAPI=4

#BACKPORTS=1
EGIT_COMMIT="8e301472e324b6d6496d8b4ffc66863e99d7a505"

if [[ ${PV} = *9999* || ! -z "${EGIT_COMMIT}" ]]; then
	EGIT_REPO_URI="git://git.seabios.org/seabios.git"
	GIT_ECLASS="git-2"
	SRC_URI=""
else
	SRC_URI="http://www.linuxtogo.org/~kevin/SeaBIOS/${P}.tar.gz
	${BACKPORTS:+http://dev.gentoo.org/~cardoe/distfiles/${P}-bp-${BACKPORTS}.tar.bz2}"
fi

inherit ${GIT_ECLASS}

if [[ ${PV} = *9999* ]]; then
	KEYWORDS=""
else
	KEYWORDS="~amd64 ~x86"
fi

DESCRIPTION="Open Source implementation of a 16-bit x86 BIOS"
HOMEPAGE="http://www.seabios.org"

LICENSE="LGPL-3 GPL-3"
SLOT="0"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_prepare() {
	if [[ -z "${EGIT_COMMIT}" ]]; then
		sed -e "s/VERSION=.*/VERSION=${PV}/" \
			-i ${S}/Makefile
	else
		sed -e "s/VERSION=.*/VERSION=${PV}_pre${EGIT_COMMIT}/" \
			-i ${S}/Makefile
	fi
}

src_configure() {
	:
}

src_compile() {
	emake out/bios.bin
#	emake out/vgabios.bin
}

src_install() {
	insinto /usr/share/seabios
	doins out/bios.bin
#	doins out/vgabios.bin
}
