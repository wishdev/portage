# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/ntfs3g/ntfs3g-2009.4.4.ebuild,v 1.3 2009/08/21 20:49:53 chutzpah Exp $

EAPI=2

MY_PN="${PN/3g/-3g}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Open source read-write NTFS driver that runs under FUSE"
HOMEPAGE="http://www.ntfs-3g.org"
SRC_URI="http://www.ntfs-3g.org/${MY_P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="debug hal suid +external-fuse"

RDEPEND=">=sys-fs/fuse-2.6.0
	hal? ( sys-apps/hal )"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${MY_P}"

src_configure() {
	econf \
		--docdir="/usr/share/doc/${PF}" \
		--enable-ldscript \
		--disable-ldconfig \
		--with-fuse=$(use external-fuse && echo external || echo internal) \
		$(use_enable debug)
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"

	prepalldocs || die "prepalldocs failed"
	dodoc AUTHORS ChangeLog CREDITS

	use suid && fperms u+s "/bin/${MY_PN}"

	if use hal; then
		insinto /etc/hal/fdi/policy/
		newins "${FILESDIR}/10-ntfs3g.fdi.2009" "10-ntfs3g.fdi"
	fi
}

pkg_postinst() {
	if use suid; then
		ewarn
		ewarn "You have chosen to install ${PN} with the binary setuid root. This"
		ewarn "means that if there any undetected vulnerabilities in the binary,"
		ewarn "then local users may be able to gain root access on your machine."
		ewarn
	fi
}