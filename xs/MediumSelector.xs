#include "perl_brasero.h"

MODULE = Media::Brasero::MediumSelector  PACKAGE = Media::Brasero::MediumSelector  PREFIX = brasero_medium_selector_

PROTOTYPES: DISABLE

GtkWidget *
brasero_medium_selection_new (class)
	C_ARGS:

BraseroMedium *
brasero_medium_selection_get_active (selector)
		BraseroMediumSelection *selector

gboolean
brasero_medium_selection_set_active (selector, medium)
		BraseroMediumSelection *selector
		BraseroMedium *medium

void
brasero_medium_selection_show_media_type (selector, type)
		BraseroMediumSelection *selector
		BraseroMediaType type
