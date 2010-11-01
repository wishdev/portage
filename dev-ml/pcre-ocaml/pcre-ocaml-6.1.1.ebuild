# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/pcre-ocaml/pcre-ocaml-6.1.1.ebuild,v 1.1 2010/11/01 14:12:08 aballier Exp $

EAPI="2"

inherit findlib eutils

DESCRIPTION="Perl Compatibility Regular Expressions for O'Caml"
HOMEPAGE="http://www.ocaml.info/home/ocaml_sources.html"
SRC_URI="http://www.ocaml.info/ocaml_sources/${P}.tar.gz"
LICENSE="LGPL-2.1"

RDEPEND=">=dev-lang/ocaml-3.10.2[ocamlopt?]
	>=dev-libs/libpcre-4.5"
DEPEND="${RDEPEND}"
SLOT="0"
IUSE="examples +ocamlopt"
KEYWORDS="~amd64 ~ppc ~x86 ~x86-fbsd"

src_prepare() {
	epatch "${FILESDIR}/${PN}-6.0.1-linkopts.patch"
}

src_compile() {
	cd "${S}/lib"
	emake byte-code-library || die "Failed to build byte code library"
	if use ocamlopt; then
		emake native-code-library || die "Failed to build native code library"
	fi
}

src_install () {
	export OCAMLFIND_INSTFLAGS="-optional"
	findlib_src_install

	# install documentation
	dodoc README.txt Changelog

	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r examples
	fi
}
