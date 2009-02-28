# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/imaxima/imaxima-1.0_rc2.ebuild,v 1.1 2009/02/23 21:33:38 ulm Exp $

inherit elisp

MY_P="${PN}-imath-${PV/_}"
DESCRIPTION="Imaxima enables graphical output in Maxima sessions with emacs"
HOMEPAGE="http://members3.jcom.home.ne.jp/imaxima/Site/Welcome.html"
SRC_URI="http://members3.jcom.home.ne.jp/imaxima/Site/Download_and_Install_files/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="examples"

DEPEND=""
RDEPEND="virtual/latex-base
	virtual/ghostscript
	|| ( dev-tex/mh dev-tex/breqn =dev-texlive/texlive-mathextra-2007* )
	<sci-mathematics/maxima-5.15.0"

SITEFILE="50${PN}-gentoo.el"
S="${WORKDIR}/${MY_P}"

src_compile() {
	econf --with-lispdir="${SITELISP}/${PN}" || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	elisp-site-file-install "${FILESDIR}/${SITEFILE}" || die
	dodoc ChangeLog NEWS README || die

	if use examples; then
		docinto imath-example
		dodoc imath-example/*.txt || die
		dohtml -r imath-example/. || die
	fi
}