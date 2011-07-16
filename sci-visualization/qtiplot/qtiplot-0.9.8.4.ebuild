# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-visualization/qtiplot/qtiplot-0.9.8.4.ebuild,v 1.2 2011/07/16 16:44:27 jlec Exp $

EAPI=3

PYTHON_DEPEND="python? 2"

inherit eutils qt4-r2 fdo-mime python

DESCRIPTION="Qt based clone of the Origin plotting package"
HOMEPAGE="http://soft.proindependent.com/qtiplot.html"
SRC_URI="mirror://berlios/${PN}/${P}.tar.bz2"

LICENSE="GPL-2 GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="bindist doc latex png python"

LANGS="cn cz de es fr ja ro ru sv"
for l in ${LANGS}; do
	lu=${l/cz/cs}
	lu=${lu/cn/zh_CN}
	IUSE="${IUSE} linguas_${lu}"
done

# qwtplot3d much modified from original upstream
# >=x11-libs/qwt-5.3 they are using trunk checkouts
CDEPEND="
	x11-libs/qt-opengl:4
	x11-libs/qt-qt3support:4
	|| ( >=x11-libs/qt-assistant-4.7.0:4[compat] <x11-libs/qt-assistant-4.7.0:4 )
	x11-libs/qt-svg:4
	>=x11-libs/gl2ps-1.3.5[png?]
	>=dev-cpp/muParser-1.32
	>=dev-libs/boost-1.35.0
	sci-libs/gsl
	sci-libs/tamu_anova
	latex? ( dev-tex/qtexengine )
	png? ( media-libs/libpng )"

DEPEND="${CDEPEND}
	dev-util/pkgconfig
	python? ( >=dev-python/sip-4.9 )
	doc? (
		>=app-text/docbook-sgml-utils-0.6.14-r1
		>=app-text/docbook-xml-dtd-4.4-r2:4.4 )"

RDEPEND="${CDEPEND}
	python? ( dev-python/PyQt4[X] )"

PATCHES=(
	"${FILESDIR}/${PN}-0.9.7.12-system-gl2ps.patch"
	"${FILESDIR}/${PN}-0.9.7.10-dont-install-qwt.patch"
	)

pkg_setup() {
	use python && python_set_active_version 2
}

src_prepare() {
	qt4-r2_src_prepare

	rm -rf 3rdparty/{liborigin,QTeXEngine,/qwtplot3d/3rdparty/gl2ps/,boost} || die
	sed \
		-e "s:dll:static:g" \
		-e "/INSTALLS/d" \
		-i 3rdparty/qwtplot3d/*.pro

	# Check build.conf for changes on bump.
	cat > build.conf <<-EOF
	# Automatically generated by Gentoo ebuild
	isEmpty( QTI_ROOT ) {
	  message( "each file including this config needs to set QTI_ROOT to the dir containing this file!" )
	}

	MUPARSER_LIBS = \$\$system(pkg-config --libs muparser)
	GSL_LIBS = \$\$system(pkg-config --libs gsl)
	QWT_INCLUDEPATH = \$\$QTI_ROOT/3rdparty/qwt/src
	QWT_LIBS = \$\$QTI_ROOT/3rdparty/qwt/lib/libqwt.a
	QWT3D_INCLUDEPATH = \$\$QTI_ROOT/3rdparty/qwtplot3d/include
	QWT3D_LIBS = \$\$QTI_ROOT/3rdparty/qwtplot3d/lib/libqwtplot3d.a
	SYS_LIBS = -lgl2ps

	PYTHON = python
	LUPDATE = lupdate
	LRELEASE = lrelease

	SCRIPTING_LANGS += muParser

	CONFIG          += release
	CONFIG          += CustomInstall
	DEFINES         += SCRIPTING_CONSOLE

	EOF

	use bindist && echo "DEFINES         += QTIPLOT_SUPPORT" >> build.conf
	use bindist || echo "DEFINES         += QTIPLOT_PRO" >> build.conf
	use python && echo "SCRIPTING_LANGS += Python" >> build.conf
	use latex && echo "TEX_ENGINE_LIBS = -lQTeXEngine" >> build.conf
	use png && echo "LIBPNG_LIBS = -lpng" >> build.conf
	echo "TAMUANOVA_LIBS = -ltamuanova" >> build.conf && \
	echo "TAMUANOVA_INCLUDEPATH = \"${EPREFIX}/usr/include/tamu_anova\"" >> build.conf

	sed -e "s:doc/${PN}/manual:doc/${PN}/html:" \
		-e "s:/usr/local/${PN}:$(python_get_sitedir)/qtiplot:" \
			-i qtiplot/qtiplot.pro || die

	sed -e '/INSTALLS.*documentation/d' \
		-e '/INSTALLS.*manual/d' \
			-i qtiplot/qtiplot.pro || die

	sed -e '/manual/d' -i qtiplot.pro || die

	sed -e "s:QTIPLOT_PRO:QTIPLOT_PROFESSIONAL:g" -i qtiplot/src/core/main.cpp || die

	# Drop langs only if LINGUAS is not empty
	if [[ -n ${LINGUAS} ]]; then
		for l in ${LANGS}; do
			lu=${l/cz/cs}
			lu=${lu/cn/zh_CN}
			use linguas_${lu} || \
				sed -e "s:translations/qtiplot_${l}.[tq][sm]::" \
						-i qtiplot/qtiplot.pro || die
		done
	fi
	chmod -x qtiplot/qti_wordlist.txt

	# sed out debian paths
	sed -e 's:\(/usr/share/sgml/\)docbook/stylesheet/dsssl/modular\(/html/docbook.dsl\):\1stylesheets/dsssl/docbook\2:' \
		-i manual/qtiplot.dsl || die
	sed -e 's:\(/usr/share/\)xml/docbook/stylesheet/nwalsh\(/html/chunk.xsl\):\1sgml/docbook/xsl-stylesheets\2:' \
		-i manual/qtiplot_html.xsl || die
}

src_configure() {
	use amd64 && export QMAKESPEC="linux-g++-64"
	eqmake4
}

src_compile() {
	emake || die "emake failed"
	lrelease qtiplot/qtiplot.pro || die
	if use doc; then
		cd manual
		emake web || die "html docbook building failed"
	fi
}

src_install() {
	qt4-r2_src_install
	newicon qtiplot_logo.png qtiplot.png
	make_desktop_entry qtiplot "QtiPlot Scientific Plotting" qtiplot
	if use doc; then
		insinto /usr/share/doc/${PN}/html
		doins -r manual/html/* || die "install manual failed"
	fi

	if [[ -n ${LINGUAS} ]]; then
		insinto /usr/share/${PN}/translations
		for l in ${LANGS}; do
			lu=${l/cz/cs}
			lu=${lu/cn/zh_CN}
			use linguas_${lu} && \
				doins qtiplot/translations/qtiplot_${l}.qm
		done
	fi
}

pkg_postinst() {
	if use python; then
		elog "You might want to emerge"
		elog "\t dev-python/pygsl"
		elog "\t dev-python/rpy"
		elog "\t sci-libs/scipy and"
		elog "\t dev-python/sympy"
		elog "to gain full python support."
	fi

	fdo-mime_desktop_database_update
	python_mod_optimize ${PN}
}

pkg_postrm() {
	fdo-mime_desktop_database_update
	python_mod_cleanup ${PN}
}
