#include "perl_brasero.h"

MODULE = Media::Brasero::MediumMonitor  PACKAGE = Media::Brasero::MediumMonitor  PREFIX = brasero_medium_monitor_

PROTOTYPES: DISABLE

BraseroMediumMonitor *
brasero_medium_monitor_get_default (class)
	C_ARGS:

void
brasero_medium_monitor_get_media (monitor, type)
		BraseroMediumMonitor *monitor
		BraseroMediaType type
	PREINIT:
		GSList *i, *media;
	PPCODE:
		if (!(media = brasero_medium_monitor_get_media (monitor, type))) {
			XSRETURN_EMPTY;
		}

		for (i = media; i->data; i = i->next) {
			mXPUSHs (newSVBraseroMedia ((BraseroMedia)i->data));
		}

		g_slist_free (media);

# brasero_medium_monitor_get_drives
# brasero_medium_monitor_get_drive
# brasero_medium_monitor_is_probing
