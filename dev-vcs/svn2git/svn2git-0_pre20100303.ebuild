# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-vcs/svn2git/svn2git-0_pre20100303.ebuild,v 1.1 2010/03/05 02:44:53 sping Exp $

EAPI="2"

inherit qt4-r2
[ "$PV" == "9999" ] && inherit git

DESCRIPTION="Importer for one time conversion from svn to git."
HOMEPAGE="http://gitorious.org/svn2git/svn2git"
if [ "$PV" == "9999" ]; then
	EGIT_REPO_URI="git://gitorious.org/svn2git/svn2git.git"
	KEYWORDS=""
else
	SRC_URI="http://www.hartwork.org/public/${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE=""
# KEYWORDS way up

DEPEND="dev-util/subversion
	x11-libs/qt-core"
RDEPEND="${DEPEND}
	dev-util/git"

src_prepare() {
	sed -i 's|^\(APR_INCLUDE = /usr/include/apr-1\)\.0|\1|' "${S}"/src/src.pro
	qt4-r2_src_prepare
}

src_install() {
	insinto /usr/share/${PN}/samples
	doins samples/*.rules || die 'doins failed'
	dobin svn-all-fast-export || die 'dobin failed'
	dosym svn-all-fast-export /usr/bin/svn2git || die 'dosym failed'
}
