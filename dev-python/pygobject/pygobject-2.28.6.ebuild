# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pygobject/pygobject-2.28.6.ebuild,v 1.8 2011/10/05 17:13:42 xarthisius Exp $

EAPI="3"
GCONF_DEBUG="no"
GNOME2_LA_PUNT="yes"
GNOME_TARBALL_SUFFIX="xz"
SUPPORT_PYTHON_ABIS="1"
# pygobject is partially incompatible with Python 3.
# PYTHON_DEPEND="2:2.6 3:3.1"
# RESTRICT_PYTHON_ABIS="2.4 2.5 3.0 *-jython"
PYTHON_DEPEND="2:2.6"
RESTRICT_PYTHON_ABIS="2.4 2.5 3.* *-jython"

# XXX: Is the alternatives stuff needed anymore?
inherit alternatives autotools gnome2 python virtualx

DESCRIPTION="GLib's GObject library bindings for Python"
HOMEPAGE="http://www.pygtk.org/"

LICENSE="LGPL-2.1"
SLOT="2"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 sh sparc x86 ~x86-fbsd ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~x64-solaris ~x86-solaris"
IUSE="doc +cairo examples +introspection libffi test"

COMMON_DEPEND=">=dev-libs/glib-2.24.0:2
	introspection? (
		>=dev-libs/gobject-introspection-0.10.2
		cairo? ( >=dev-python/pycairo-1.2.0 ) )
	libffi? ( virtual/libffi )"
DEPEND="${COMMON_DEPEND}
	doc? (
		dev-libs/libxslt
		>=app-text/docbook-xsl-stylesheets-1.70.1 )
	test? (
		media-fonts/font-cursor-misc
		media-fonts/font-misc-misc )
	>=dev-util/pkgconfig-0.12"
RDEPEND="${COMMON_DEPEND}
	!<dev-python/pygtk-2.13"

pkg_setup() {
	DOCS="AUTHORS ChangeLog* NEWS README"
	G2CONF="${G2CONF}
		--disable-dependency-tracking
		$(use_enable doc docs)
		$(use_enable cairo)
		$(use_enable introspection)
		$(use_with libffi ffi)"
}

src_prepare() {
	gnome2_src_prepare

	# Fix FHS compliance, see upstream bug #535524
	epatch "${FILESDIR}/${PN}-2.28.3-fix-codegen-location.patch"

	# Do not build tests if unneeded, bug #226345
	epatch "${FILESDIR}/${PN}-2.28.3-make_check.patch"

	# Support installation for multiple Python versions, upstream bug #648292
	epatch "${FILESDIR}/${PN}-2.28.3-support_multiple_python_versions.patch"

	# Disable tests that fail
	epatch "${FILESDIR}/${PN}-2.28.3-disable-failing-tests.patch"

	# disable pyc compiling
	ln -sfn $(type -P true) py-compile

	eautoreconf

	python_copy_sources
}

src_configure() {
	python_execute_function -s gnome2_src_configure
}

src_compile() {
	python_execute_function -d -s
}

# FIXME: With python multiple ABI support, tests return 1 even when they pass
src_test() {
	unset DBUS_SESSION_BUS_ADDRESS

	testing() {
		XDG_CACHE_HOME="${T}/$(PYTHON --ABI)"
		Xemake check PYTHON=$(PYTHON -a)
	}
	python_execute_function -s testing
}

src_install() {
	[[ -z ${ED} ]] && local ED="${D}"
	installation() {
		gnome2_src_install
		mv "${ED}$(python_get_sitedir)/pygtk.py" "${ED}$(python_get_sitedir)/pygtk.py-2.0"
		mv "${ED}$(python_get_sitedir)/pygtk.pth" "${ED}$(python_get_sitedir)/pygtk.pth-2.0"
	}
	python_execute_function -s installation

	python_clean_installation_image

	sed "s:/usr/bin/python:/usr/bin/python2:" \
		-i "${ED}"/usr/bin/pygobject-codegen-2.0 \
		|| die "Fix usage of python interpreter"

	if use examples; then
		insinto /usr/share/doc/${P}
		doins -r examples || die "doins failed"
	fi
}

pkg_postinst() {
	create_symlinks() {
		alternatives_auto_makesym "$(python_get_sitedir)/pygtk.py" pygtk.py-[0-9].[0-9]
		alternatives_auto_makesym "$(python_get_sitedir)/pygtk.pth" pygtk.pth-[0-9].[0-9]
	}
	python_execute_function create_symlinks

	python_mod_optimize $(use introspection && echo gi) glib gobject gtk-2.0 pygtk.py
}

pkg_postrm() {
	python_mod_cleanup $(use introspection && echo gi) glib gobject gtk-2.0 pygtk.py

	create_symlinks() {
		alternatives_auto_makesym "$(python_get_sitedir)/pygtk.py" pygtk.py-[0-9].[0-9]
		alternatives_auto_makesym "$(python_get_sitedir)/pygtk.pth" pygtk.pth-[0-9].[0-9]
	}
	python_execute_function create_symlinks
}
