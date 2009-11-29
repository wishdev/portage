# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/tora/tora-2.1.1.ebuild,v 1.1 2009/11/22 13:25:34 dertobi123 Exp $

EAPI=2

inherit cmake-utils

DESCRIPTION="TOra - Toolkit For Oracle"
HOMEPAGE="http://tora.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
IUSE="debug mysql oracle oci8-instant-client postgres"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~sparc ~x86"

RDEPEND="${DEPEND}"
DEPEND="
	>=x11-libs/qscintilla-2.1[qt4]
	x11-libs/qt-gui:4
	x11-libs/qt-sql:4[mysql?,postgres?]
	x11-libs/qt-xmlpatterns:4
	oci8-instant-client? (
		dev-db/oracle-instantclient-basic
		dev-db/oracle-instantclient-sqlplus
	)
	postgres? ( virtual/postgresql-server )
"

pkg_setup() {
	if ( use oracle || use oci8-instant-client ) && [ -z "$ORACLE_HOME" ] ; then
		eerror "ORACLE_HOME variable is not set."
		eerror
		eerror "You must install Oracle >= 8i client for Linux in"
		eerror "order to compile TOra with Oracle support."
		eerror
		eerror "Otherwise specify -oracle in your USE variable."
		eerror
		eerror "You can download the Oracle software from"
		eerror "http://otn.oracle.com/software/content.html"
		die
	fi
}

src_prepare() {
	sed -i \
		-e "/COPYING/ d" \
		CMakeLists.txt || die "Removal of COPYING file failed"
}

src_configure() {
	if use oracle || use oci8-instant-client ; then
		mycmakeargs+=" -DENABLE_ORACLE=ON"
	else
		mycmakeargs+=" -DENABLE_ORACLE=OFF"
	fi
	mycmakeargs+="
		-DWANT_RPM=OFF
		-DWANT_BUNDLE=OFF
		-DWANT_BUNDLE_STANDALONE=OFF
		-DWANT_INTERNAL_QSCINTILLA=OFF
		$(cmake-utils_use_enable postgres PGSQL)
		$(cmake-utils_use_want debug)
	"
	# path variables
	mycmakeargs+="
		-DTORA_DOC_DIR=share/doc/${PF}
	"
	cmake-utils_src_configure
}