# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/pssh/pssh-2.2.2.ebuild,v 1.2 2011/04/26 17:06:45 xarthisius Exp $

EAPI="3"
PYTHON_DEPEND="*:2.4"
inherit distutils

DESCRIPTION="This package provides parallel versions of the openssh tools."
HOMEPAGE="http://code.google.com/p/parallel-ssh/"
SRC_URI="http://parallel-ssh.googlecode.com/files/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~x86-interix ~amd64-linux ~x86-linux"
IUSE=""

RDEPEND="net-misc/openssh
	!net-misc/putty"
DEPEND="${RDEPEND}
	dev-python/setuptools"

# Requires ssh access to run.
RESTRICT="test"

PYTHON_MODNAME=psshlib

src_prepare() {
	sed -i -e "s|man/man1'|share/&|g" setup.py || die
}
