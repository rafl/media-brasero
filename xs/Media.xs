#include "perl_brasero.h"

MODULE = Media::Brasero  PACKAGE = Media::Brasero  PREFIX = brasero_media_

PROTOTYPES: DISABLE

void
brasero_media_library_start (class)
	C_ARGS:

void
brasero_media_library_stop (class)
	C_ARGS:

GOptionGroup *
brasero_media_get_option_group (class)
	C_ARGS:

BOOT:
#include "register.xsh"
#include "boot.xsh"
