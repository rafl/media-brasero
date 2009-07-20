#include "perl_brasero.h"

MODULE = Media::Brasero::Medium  PACKAGE = Media::Brasero::Medium  PREFIX = brasero_medium_

PROTOTYPES: DISABLE

BraseroMedia
brasero_medium_get_status (medium)
		BraseroMedium *medium

guint64
brasero_medium_get_max_write_speed (medium)
		BraseroMedium *medium

void
brasero_medium_get_write_speeds (medium)
		BraseroMedium *medium
	PREINIT:
		guint64 *i, *speeds = NULL;
	PPCODE:
		speeds = brasero_medium_get_write_speeds (medium);
		for (i = speeds; *i; i++) {
			mXPUSHs (newSVGUInt64 (*i));
		}
		g_free (speeds);

void
brasero_medium_get_free_space (BraseroMedium *medium, OUTLIST gint64 size, OUTLIST gint64 blocks)

void
brasero_medium_get_capacity (BraseroMedium *medium, OUTLIST gint64 size, OUTLIST gint64 blocks)

void
brasero_medium_get_data_size (BraseroMedium *medium, OUTLIST gint64 size, OUTLIST gint64 blocks)

gint64
brasero_medium_get_next_writable_address (medium)
		BraseroMedium *medium

gboolean
brasero_medium_can_be_rewritten (medium)
		BraseroMedium *medium

gboolean
brasero_medium_can_be_written (medium)
		BraseroMedium *medium

const gchar *
brasero_medium_get_CD_TEXT_title (medium)
		BraseroMedium *medium

const gchar *
brasero_medium_get_type_string (medium)
		BraseroMedium *medium

gchar *
brasero_medium_get_tooltip (medium)
		BraseroMedium *medium

BraseroDrive *
brasero_medium_get_drive (medium)
		BraseroMedium *medium

guint
brasero_medium_get_track_num (medium)
		BraseroMedium *medium

void
brasero_medium_get_last_data_track_space (medium)
		BraseroMedium *medium
	PREINIT:
		gint64 size, sector;
	PPCODE:
		if (!brasero_medium_get_last_data_track_space (medium, &size, &sector)) {
			XSRETURN_EMPTY;
		}

		EXTEND (SP, 2);
		mPUSHs (newSVGUInt64 (size));
		mPUSHs (newSVGUInt64 (sector));

void
brasero_medium_get_last_data_track_address (medium)
		BraseroMedium *medium
	PREINIT:
		gint64 size, sector;
	PPCODE:
		if (!brasero_medium_get_last_data_track_address (medium, &size, &sector)) {
			XSRETURN_EMPTY;
		}

		EXTEND (SP, 2);
		mPUSHs (newSVGUInt64 (size));
		mPUSHs (newSVGUInt64 (sector));

void
brasero_medium_get_track_space (medium, num)
		BraseroMedium *medium
		guint num
	PREINIT:
		gint64 size, sector;
	PPCODE:
		if (!brasero_medium_get_track_space (medium, num, &size, &sector)) {
			XSRETURN_EMPTY;
		}

		EXTEND (SP, 2);
		mPUSHs (newSVGUInt64 (size));
		mPUSHs (newSVGUInt64 (sector));

void
brasero_medium_get_track_address (medium, num)
		BraseroMedium *medium
		guint num
	PREINIT:
		gint64 size, sector;
	PPCODE:
		if (!brasero_medium_get_track_address (medium, num, &size, &sector)) {
			XSRETURN_EMPTY;
		}

		EXTEND (SP, 2);
		mPUSHs (newSVGUInt64 (size));
		mPUSHs (newSVGUInt64 (sector));
