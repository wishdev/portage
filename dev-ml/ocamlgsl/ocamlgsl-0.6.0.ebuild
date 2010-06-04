# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/ocamlgsl/ocamlgsl-0.6.0.ebuild,v 1.1 2010/06/03 19:36:20 bicatali Exp $

EAPI="2"

inherit base findlib

DESCRIPTION="OCaml bindings for the GSL library"
HOMEPAGE="http://oandrieu.nerim.net/ocaml/gsl/"
SRC_URI="http://oandrieu.nerim.net/ocaml/gsl/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

DEPEND=">=dev-lang/ocaml-3.10
	sci-libs/gsl"
RDEPEND="${DEPEND}"

PATCHES=( "${FILESDIR}/${P}-ocaml311.patch" )

src_compile() {
	emake CFLAGS="${CFLAGS}" || die "emake failed"
}

src_install() {
	findlib_src_preinst
	emake install-findlib || die "emake install failed"

	dodoc README NEWS NOTES
	doinfo *.info* || die "info install failed"
	if use doc; then
		dohtml doc/* || die "html docs install failed"
	fi
}
