use strict;
use warnings;

package Media::Brasero;

use Gtk2;
use base 'DynaLoader';

our $VERSION = '0.01';

sub dl_load_flags { 0x01 }

Media::Brasero->bootstrap($VERSION);

1;
