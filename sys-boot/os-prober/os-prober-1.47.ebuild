# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-boot/os-prober/os-prober-1.47.ebuild,v 1.2 2011/05/26 19:01:37 abcd Exp $

EAPI=4

inherit eutils multilib toolchain-funcs

DESCRIPTION="Utility to detect other OSs on a set of drives"
HOMEPAGE="http://packages.debian.org/source/sid/os-prober"
SRC_URI="mirror://debian/pool/main/${PN::1}/${PN}/${PN}_${PV}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

S=${WORKDIR}/${PN}

src_prepare() {
	find "${S}" -type f -exec sed -i -e "s:/usr/lib/:/usr/libexec/:g" {} + || die "failed on find and sed lib->libexec"
	sed -i -e "s:/lib/ld\*\.so\*:/lib*/ld*.so*:g" os-probes/mounted/common/90linux-distro  || die "sed failed on 90linux-distro"

	# use default GNU rules
	rm Makefile
}

src_compile() {
	tc-export CC
	emake newns
}

src_install() {
	dobin os-prober linux-boot-prober

	exeinto /usr/libexec/os-prober
	doexe newns

	insinto /usr/share/os-prober
	doins common.sh

	keepdir /var/lib/os-prober

	local debarch=${ARCH%-*} dir

	case ${debarch} in
		amd64)		debarch=x86 ;;
		ppc|ppc64)	debarch=powerpc ;;
	esac

	for dir in os-probes{,/mounted,/init} linux-boot-probes{,/mounted}; do
		exeinto /usr/libexec/$dir
		doexe $dir/common/*
		if [[ -d $dir/$debarch ]]; then
			doexe $dir/$debarch/*
		fi
	done

	if use amd64 || use x86; then
		exeinto /usr/libexec/os-probes/mounted
		doexe os-probes/mounted/powerpc/20macosx
	fi

	dodoc README TODO debian/changelog
}

pkg_postinst() {
	elog "If you intend for os-prober to detect versions of Windows installed on"
	elog "NTFS-formatted partitions, your system must be capable of reading the"
	elog "NTFS filesystem. One way to do this is by installing sys-fs/ntfs3g"
}
