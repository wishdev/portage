# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/nvidia-cuda-toolkit/nvidia-cuda-toolkit-2.2.ebuild,v 1.2 2009/07/19 00:12:03 spock Exp $

inherit eutils

DESCRIPTION="NVIDIA CUDA Toolkit"
HOMEPAGE="http://developer.nvidia.com/cuda"

CUDA_V=${PV//./_}

BASE_URI="http://developer.download.nvidia.com/compute/cuda/${CUDA_V}/toolkit"
SRC_URI="amd64? ( ${BASE_URI}/cudatoolkit_${PV}_linux_64_suse11.1.run )
	x86? ( ${BASE_URI}/cudatoolkit_${PV}_linux_32_suse11.1.run )"

LICENSE="NVIDIA"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

DEPEND=""
RDEPEND=""
RESTRICT="strip"

S="${WORKDIR}"

src_unpack() {
	unpack_makeself
}

src_install() {
	local DEST=/opt/cuda
	export CONF_LIBDIR_OVERRIDE="lib"

	# HACK: temporary workaround until CONF_LIBDIR_OVERRIDE is respected.
	export LIBDIR_amd64="lib"

	into ${DEST}
	dobin bin/*
	dolib lib/*

	chmod a-x "${D}/${DEST}/bin/nvcc.profile"

	# doman does not respect DESTTREE
	insinto ${DEST}/man/man1
	doins man/man1/*
	insinto ${DEST}/man/man3
	doins man/man3/*
	prepman ${DEST}

	insinto ${DEST}/include
	doins include/*.h
	insinto ${DEST}/include/crt
	doins include/crt/*.h

	insinto ${DEST}/src
	doins src/*

	into ${DEST}/open64
	dobin open64/bin/*
	libopts -m0755
	dolib open64/lib/*

	if use doc ; then
		insinto ${DEST}/doc
		doins doc/*
	fi

	cat > "${T}/env" << EOF
PATH=${DEST}/bin
ROOTPATH=${DEST}/bin
LDPATH=${DEST}/lib
MANPATH=${DEST}/man
EOF
	newenvd "${T}/env" 99cuda
}

pkg_postinst() {
	elog "If you want to natively run the code generated by CUDA, you will need"
	elog ">=x11-drivers/nvidia-drivers-185.18.08."
	elog ""
	elog "This CUDA toolkit release does not support gcc-4.4.  Please make sure"
	elog "to switch to a lower GCC version before using nvcc."
	elog ""
	elog "Run '. /etc/profile' before using the CUDA toolkit. "
}
