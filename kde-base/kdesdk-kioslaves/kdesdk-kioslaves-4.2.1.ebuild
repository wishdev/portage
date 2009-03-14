# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdesdk-kioslaves/kdesdk-kioslaves-4.2.1.ebuild,v 1.1 2009/03/04 21:12:09 alexxy Exp $

EAPI="2"

KMNAME="kdesdk"
KMMODULE="kioslave"
inherit kde4-meta

DESCRIPTION="kioslaves from kdesdk package: the subversion kioslave"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="debug"

DEPEND="dev-libs/apr
	dev-util/subversion"
RDEPEND="${RDEPEND}"

src_configure() {
	mycmakeargs="${mycmakeargs} -DAPRCONFIG_EXECUTABLE=/usr/bin/apr-1-config"
	kde4-meta_src_configure
}