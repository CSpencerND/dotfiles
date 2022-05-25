#define DRACULA     0
#define CATPPUCCIN  0
#define CATPPUGREEN 1

#if CATPPUGREEN
#include "themes/catppugreen.h"
#elif CATPPUCCIN
#include "themes/catppuccin.h"
#else
#include "themes/dracula.h"
#endif // CATPPUGREEN
