#define DRACULA     0
#define CATPPUCCIN  0
#define CATPPUGREEN 0
#define ROSEPINE    1

#if CATPPUGREEN
#include "themes/catppugreen.h"
#elif CATPPUCCIN
#include "themes/catppuccin.h"
#elif ROSEPINE
#include "themes/rose-pine.h"
#else
#include "themes/dracula.h"
#endif // CATPPUGREEN
