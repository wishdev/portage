# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/mozart-stdlib/mozart-stdlib-1.4.0-r1.ebuild,v 1.1 2010/11/20 00:57:18 keri Exp $

EAPI="2"

inherit eutils

MY_P="mozart-${PV}.20080704-std"

DESCRIPTION="The Mozart Standard Library"
HOMEPAGE="http://www.mozart-oz.org/"
SRC_URI="http://www.mozart-oz.org/download/mozart-ftp/store/1.4.0-2008-07-02-tar/mozart-1.4.0.20080704-std.tar.gz"
LICENSE="Mozart"

SLOT="0"
KEYWORDS="-amd64 ~ppc -ppc64 ~sparc ~x86"
IUSE=""

DEPEND="dev-lang/mozart"
RDEPEND="${DEPEND}"

S="${WORKDIR}"/${MY_P}

src_prepare() {
	epatch "${FILESDIR}"/${P}-ozload.patch
	epatch "${FILESDIR}"/${P}-docroot.patch
}

src_install() {
	emake \
		PREFIX="${D}"/usr/lib/mozart \
		DOCROOT="${D}"/usr/share/doc/${PF} \
		install || die "emake install failed"

	dosym /usr/lib/mozart/bin/ozmake /usr/bin/ozmake || die

	doman ozmake/ozmake.1 || die
	docinto mozart-ozmake
	dodoc ozmake/{DESIGN,NOTES,README} || die
}
