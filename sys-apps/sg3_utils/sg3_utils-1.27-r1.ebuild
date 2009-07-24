# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/sg3_utils/sg3_utils-1.27-r1.ebuild,v 1.1 2009/07/20 16:57:58 nirbheek Exp $

inherit eutils

DESCRIPTION="Apps for querying the sg SCSI interface"
HOMEPAGE="http://sg.danny.cz/sg/"
SRC_URI="http://sg.danny.cz/sg/p/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND="sys-devel/libtool"
RDEPEND="sys-apps/sdparm"
PDEPEND=">=sys-apps/rescan-scsi-bus-1.24"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PN}-1.26-stdint.patch
}

src_install() {
	emake install DESTDIR="${D}" || die "make install failed"
	dodoc ChangeLog AUTHORS COVERAGE CREDITS README*
	dodoc doc/README.doc examples/*.txt
	newdoc scripts/README README.scripts
	dosbin scripts/{scsi,sas}* || die

	# Better fix for bug 231089; some packages look for sgutils2
	local path lib
	path="/usr/$(get_libdir)"
	for lib in "${D}"/usr/$(get_libdir)/libsgutils2.*; do
		lib=${lib##*/}
		dosym "${path}/${lib}" "${path}/${lib/libsgutils2/libsgutils}"
	done
}