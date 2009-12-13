# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/star/star-1.5.1.ebuild,v 1.1 2009/12/10 13:25:52 pva Exp $

EAPI="2"

inherit eutils toolchain-funcs

DESCRIPTION="An enhanced (world's fastest) tar, as well as enhanced mt/rmt"
HOMEPAGE="http://cdrecord.berlios.de/old/private/star.html"
SRC_URI="ftp://ftp.berlios.de/pub/${PN}/${P}.tar.bz2"

LICENSE="GPL-2 LGPL-2.1 CDDL-Schily"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

S=${WORKDIR}/${P/_alpha[0-9][0-9]}

src_prepare() {
	sed -i \
		-e 's:/opt/schily:/usr:g' \
		-e 's:bin:root:g' \
		-e 's:/usr/src/linux/include:/usr/include:' \
			DEFAULTS/Defaults.linux || die
}

src_configure() { :; } #avoid ./configure run

src_compile() {
	make CC="$(tc-getCC)" COPTX="${CFLAGS}" CPPOPTX="${CPPFLAGS}" LDOPTX="${LDFLAGS}" || die
}

src_install() {
	# Joerg Schilling suggested to integrate star into the main OS using call:
	# make INS_BASE=/usr DESTDIR="${D}" install

	dobin star/OBJ/*-*-cc/star || die "dobin star failed"
	dobin tartest/OBJ/*-*-cc/tartest || die "dobin tartest failed"
	dobin star_sym/OBJ/*-*-cc/star_sym || die "dobin star_sym failed"
	dobin mt/OBJ/*-*-cc/smt || die "dobin smt failed"

	newsbin rmt/OBJ/*-*-cc/rmt rmt.star
	newman rmt/rmt.1 rmt.star.1

	# Note that we should never install gnutar, tar or rmt in this package.
	# tar and rmt are provided by app-arch/tar. gnutar is not compatible with
	# GNU tar and breakes compilation, or init scripts. bug #33119
	dosym /usr/bin/{star,ustar}
	dosym /usr/bin/{star,spax}
	dosym /usr/bin/{star,scpio}
	dosym /usr/bin/{star,suntar}

	#  match is needed to understand the pattern matcher, if you wondered why ;)
	mv star/{star.4,star.5}
	doman man/man1/match.1 tartest/tartest.1 \
		star/{star.5,star.1,spax.1,scpio.1,suntar.1}

	insinto /etc/default
	newins star/star.dfl star
	newins rmt/rmt.dfl rmt

	dodoc star/{README.ACL,README.crash,README.largefiles,README.otherbugs} \
		star/{README.pattern,README.pax,README.posix-2001,README,STARvsGNUTAR} \
			rmt/default-rmt.sample TODO AN-* Changelog CONTRIBUTING
}