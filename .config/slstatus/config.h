/* See LICENSE file for copyright and license details. */

/* interval between updates (in ms) */
const unsigned int interval = 2000;

/* text to show if no value can be retrieved */
static const char unknown_str[] = "n/a";

/* maximum output string length */
#define MAXLEN 2048

#include "themes/catppuccin.h"
/*
 * NOTE: battery_icon
 * color needs to be changed directly in /components/battery_icon.c
 */
