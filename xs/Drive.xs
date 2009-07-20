#include "perl_brasero.h"

MODULE = Media::Brasero::Drive  PACKAGE = Media::Brasero::Drive  PREFIX = brasero_drive_

PROTOTYPES: DISABLE

void
brasero_drive_reprobe (drive)
		BraseroDrive *drive

BraseroMedium *
brasero_drive_get_medium (drive)
		BraseroDrive *drive

#GDrive *
#brasero_drive_get_gdrive (drive)
#		BraseroDrive *drive

const gchar *
brasero_drive_get_udi (drive)
		BraseroDrive *drive

gboolean
brasero_drive_is_fake (drive)
		BraseroDrive *drive

gchar *
brasero_drive_get_display_name (drive)
		BraseroDrive *drive

const gchar *
brasero_drive_get_device (drive)
		BraseroDrive *drive

const gchar *
brasero_drive_get_block_device (drive)
		BraseroDrive *drive

gchar *
brasero_drive_get_bus_target_lun_string (drive)
		BraseroDrive *drive

BraseroDriveCaps
brasero_drive_get_caps (drive)
		BraseroDrive *drive

gboolean
brasero_drive_can_write (drive)
		BraseroDrive *drive

gboolean
brasero_drive_can_eject (drive)
		BraseroDrive *drive

gboolean
brasero_drive_eject (drive, wait)
		BraseroDrive *drive
		gboolean wait
	PREINIT:
		GError *err = NULL;
	C_ARGS:
		drive, wait, &err
	POSTCALL:
		if (!RETVAL) {
			gperl_croak_gerror (NULL, err);
		}

gboolean
brasero_drive_is_door_open (drive)
		BraseroDrive *drive

gboolean
brasero_drive_can_use_exclusively (drive)
		BraseroDrive *drive

gboolean
brasero_drive_lock (drive, reason)
		BraseroDrive *drive
		const gchar *reason
	PREINIT:
		gchar *fail_reason = NULL;
	C_ARGS:
		drive, reason, &fail_reason
	POSTCALL:
		if (!RETVAL) {
			croak ("%s", fail_reason);
		}

gboolean
brasero_drive_unlock (drive)
		BraseroDrive *drive
