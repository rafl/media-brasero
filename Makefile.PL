use strict;
use warnings;
use lib 'ext';
use inc::Module::Install;

name 'Media-Brasero';
license 'lgpl';
all_from 'lib/Media/Brasero.pm';

brasero or exit;

requires 'Gtk2';

configure_requires 'Cwd';
configure_requires 'File::Spec';
configure_requires 'Gtk2::CodeGen';
configure_requires 'Glib::MakeHelper';
configure_requires 'ExtUtils::Depends';
configure_requires 'ExtUtils::PkgConfig';

no_index directory => qw/inc ext/;

WriteAll;
