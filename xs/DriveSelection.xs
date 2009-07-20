#include "perl_brasero.h"

MODULE = Media::Brasero::DriveSelection  PACKAGE = Media::Brasero::DriveSelection  PREFIX = brasero_drive_selection_

PROTOTYPES: DISABLE

GtkWidget *
brasero_drive_selection_new (class)
	C_ARGS:

BraseroDrive *
brasero_drive_selection_get_active (selector)
		BraseroDriveSelection *selector

gboolean
brasero_drive_selection_set_active (selector, drive)
		BraseroDriveSelection *selector
		BraseroDrive *drive

void
brasero_drive_selection_show_type (selector, type)
		BraseroDriveSelection *selector
		BraseroDriveType type
