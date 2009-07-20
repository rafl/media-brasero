use strict;
use warnings;

package Module::Install::PRIVATE::Brasero;

use base qw/Module::Install::Base/;

our $VERSION = '0.01';

use Cwd;
use File::Spec;
use Gtk2::CodeGen;
use Glib::MakeHelper;
use ExtUtils::Depends;
use ExtUtils::PkgConfig;

sub brasero {
    my ($self) = @_;

    mkdir 'build', 0777;

    my %pkgconfig;
    eval {
        %pkgconfig = ExtUtils::PkgConfig->find('libbrasero-media');
    };

    if (my $err = $@) {
        print STDERR $err;
        return;
    }

    chomp(my $brasero_include = `pkg-config --variable includedir libbrasero-media`);
    my @brasero_headers = glob($brasero_include.'/brasero/*.h');

    system(q(glib-mkenums --fhead "#ifndef __PERL_BRASERO_GTYPES_H__\n" ).
                        q(--fhead "#define __PERL_BRASERO_GTYPES_H__ 1\n\n" ).
                        q(--fhead "#include <glib-object.h>\n\n" ).
                        q(--fhead "G_BEGIN_DECLS\n\n" ).
                        q(--eprod "#define PERL_BRASERO_TYPE_@ENUMSHORT@ perl_brasero_@enum_name@_get_type()\n" ).
                        q(--eprod "GType perl_brasero_@enum_name@_get_type (void) G_GNUC_CONST;\n" ).
                        q(--ftail "G_END_DECLS\n\n" ).
                        q(--ftail "#endif /* __PERL_BRASERO_GTYPES_H__ */\n" ).
                        "@brasero_headers > build/perl_brasero_gtypes.h");

    system(q(glib-mkenums --fhead "#include <brasero-drive.h>\n" ).
                        q(--fhead "#include \"perl_brasero.h\"\n\n" ).
                        q(--vhead "static const G@Type@Value _perl_brasero_@enum_name@_values[] = {" ).
                        q(--vtail " { 0, NULL, NULL }\n};\n\n" ).
                        q(--vtail "GType\nperl_brasero_@enum_name@_get_type (void) {\n" ).
                        q(--vtail " static GType t = 0;\n" ).
                        q(--vtail " if (!t)\n" ).
                        q(--vtail "     t = g_@type@_register_static(\"@EnumName@\", _perl_brasero_@enum_name@_values);\n" ).
                        q(--vtail " return t;\n}\n\n" ).
                        "@brasero_headers > build/perl_brasero_gtypes.c");

    Gtk2::CodeGen->parse_maps('brasero');
    Gtk2::CodeGen->write_boot(ignore => qr/^Media::Brasero$/);

    our @xs_files = <xs/*.xs>;

    our $brasero = ExtUtils::Depends->new('Media::Brasero', 'Gtk2');
    $brasero->set_inc($pkgconfig{cflags});
    $brasero->set_libs($pkgconfig{libs});
    $brasero->add_c('build/perl_brasero_gtypes.c');
    $brasero->add_xs(@xs_files);
    $brasero->add_pm('lib/Media/Brasero.pm' => '$(INST_LIBDIR)/Brasero.pm');
    $brasero->add_typemaps(File::Spec->catfile(cwd(), 'build', 'brasero.typemap'));

    $brasero->install(File::Spec->catfile('build', 'brasero-autogen.h'));
    $brasero->save_config(File::Spec->catfile('build', 'IFiles.pm'));

    $self->makemaker_args(
        $brasero->get_makefile_vars,
        MAN3PODS => {
            Glib::MakeHelper->do_pod_files(@xs_files),
        },
    );

    return 1;
}

package MY;

use Cwd;

sub postamble {
    return Glib::MakeHelper->postamble_clean
        . Glib::MakeHelper->postamble_docs_full(
            DEPENDS => $Module::Install::PRIVATE::Brasero::brasero,
            XS_FILES => \@Module::Install::PRIVATE::Brasero::xs_files,
            COPYRIGHT => 'Copyright (c) 2009  Florian Ragwitz',
        )
        . <<"EOM"
README: lib/Media/Brasero.pm
\tpod2text \$< > \$@
EOM
}

1;
