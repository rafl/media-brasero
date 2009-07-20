#include "perl_brasero.h"

MODULE = Media::Brasero::Volume  PACKAGE = Media::Brasero::Volume  PREFIX = brasero_volume_

PROTOTYPES: DISABLE

gchar *
brasero_volume_get_name (volume)
		BraseroVolume *volume

#GIcon *
#brasero_volume_get_icon (volume)
#		BraseroVolume *volume

#GVolume *
#brasero_volume_get_gvolume (volume)
#		BraseroVolume *volume

gboolean
brasero_volume_is_mounted (volume)
		BraseroVolume *volume

gchar *
brasero_volume_get_mount_point (volume)
		BraseroVolume *volume
	PREINIT:
		GError *err = NULL;
	C_ARGS:
		volume, &err
	POSTCALL:
		if (!RETVAL) {
			gperl_croak_gerror (NULL, err);
		}

gboolean
brasero_volume_umount (volume, wait)
		BraseroVolume *volume
		gboolean wait
	PREINIT:
		GError *err = NULL;
	C_ARGS:
		volume, wait, &err
	POSTCALL:
		if (!RETVAL) {
			gperl_croak_gerror (NULL, err);
		}

gboolean
brasero_volume_mount (volume, parent_window, wait)
		BraseroVolume *volume
		GtkWindow *parent_window
		gboolean wait
	PREINIT:
		GError *err = NULL;
	C_ARGS:
		volume, parent_window, wait, &err
	POSTCALL:
		if (!RETVAL) {
			gperl_croak_gerror (NULL, err);
		}

void
brasero_volume_cancel_current_operation (volume)
		BraseroVolume *volume
