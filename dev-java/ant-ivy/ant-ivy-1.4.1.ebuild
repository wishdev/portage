# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/ant-ivy/ant-ivy-1.4.1.ebuild,v 1.2 2009/06/14 14:07:22 mr_bones_ Exp $

JAVA_PKG_IUSE="doc examples source test"
# registers as split-ant task
WANT_SPLIT_ANT="true"
# rewrites examples otherwise... bad
JAVA_PKG_BSFIX_ALL="no"

inherit java-pkg-2 java-ant-2 eutils

MY_PN="${PN##*-}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Ivy is a free java based dependency manager"
HOMEPAGE="http://ant.apache.org/ivy"
SRC_URI="http://www.jaya.free.fr/downloads/ivy/${PV}/${MY_P}-src.zip"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE=""

COMMON_DEP="
	dev-java/ant-core
	=dev-java/commons-cli-1*
	=dev-java/commons-httpclient-3*
	dev-java/commons-vfs
	=dev-java/jakarta-oro-2.0*
	dev-java/jsch"
DEPEND="
	>=virtual/jdk-1.4
	app-arch/unzip
	test? ( dev-java/ant-junit )
	${COMMON_DEP}"
RDEPEND=">=virtual/jre-1.4
	${COMMON_DEP}"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/1.4.1-javadoc.patch"

	# init-ivy expects existing ivy.jar, but we don't need actually it
	sed -i -e 's/depends="init-ivy, prepare"/depends="prepare"/' build.xml \
		|| die

	rm -v src/java/fr/jayasoft/ivy/repository/vfs/IvyWebdav* || die
	java-ant_rewrite-classpath
	mkdir lib
}

EANT_GENTOO_CLASSPATH="
	ant-core,commons-cli-1,commons-httpclient-3
	commons-vfs,jakarta-oro-2.0,jsch"

EANT_BUILD_TARGET="offline jar"

src_test() {
	# TODO: find out why a couple of these fail
	java-pkg_jar-from --into lib junit
	ANT_TASKS="ant-junit" eant offline test
}

src_install() {
	java-pkg_dojar build/artifact/${MY_PN}.jar

	use doc && java-pkg_dojavadoc doc/ivy/api
	use examples && java-pkg_doexamples src/example
	use source && java-pkg_dosrc src/java/*

	java-pkg_register-ant-task
}
