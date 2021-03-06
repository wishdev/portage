# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/vde/vde-2.3.1.ebuild,v 1.1 2010/08/26 01:28:02 dang Exp $

EAPI=2

inherit eutils

MY_P="${PN}2-${PV}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="vde2 is a virtual distributed ethernet emulator for emulators like qemu, bochs, and uml."
SRC_URI="mirror://sourceforge/vde/${MY_P}.tar.bz2"
HOMEPAGE="http://vde.sourceforge.net/"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"

IUSE="pcap ssl"

RDEPEND="pcap? ( net-libs/libpcap )
	ssl? ( dev-libs/openssl )"
DEPEND="${RDEPEND}"

src_configure() {
	econf \
		$(use_enable pcap) \
		$(use_enable ssl cryptcab)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	newinitd "${FILESDIR}"/vde.init vde || die
	newconfd "${FILESDIR}"/vde.conf vde || die

	dodoc README Changelog || die
}

pkg_postinst() {
	# default group already used in kqemu
	enewgroup qemu
	einfo "To start vde automatically add it to the default runlevel:"
	einfo "# rc-update add vde default"
	einfo "You need to setup tap0 in /etc/conf.d/net"
	einfo "To use it as an user be sure to set a group in /etc/conf.d/vde"
	einfo "Users of the group can then run: $ vdeq qemu -sock /var/run/vde.ctl ..other opts"
}
