# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/network/network-2.2.1.4.ebuild,v 1.3 2010/01/26 20:56:35 kolmodin Exp $

CABAL_FEATURES="lib profile haddock"
inherit base haskell-cabal autotools

DESCRIPTION="Networking-related facilities"
HOMEPAGE="http://hackage.haskell.org/cgi-bin/hackage-scripts/package/network"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~sparc ~x86 ~x86-fbsd ~amd64-linux ~x86-linux ~x86-macos"
IUSE=""

RDEPEND=">=dev-lang/ghc-6.6.1
		dev-haskell/parsec"

DEPEND="${RDEPEND}
		>=dev-haskell/cabal-1.2"

PATCHES=("${FILESDIR}/network-2.2.0.0-eat-configure-opts.patch")

src_unpack() {
	base_src_unpack
	cd "${S}"
	eautoreconf
}
