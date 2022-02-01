#!/bin/bash

# variables
led="g815-led"

purple=bd33f9
magenta=ff39c6
cyan=8be9fd
yellow=ff9900

vim_key_color=$yellow
syntax_key_color=$magenta
num_key_color=$cyan

num_keys=(
	1 2 3 4 5 6 7 8
)
vim_keys=(
	h j k l capslock
)
syntax_keys=(
	tilde 9 0 minus equal
	open_bracket close_bracket backslash
	semicolon quote comma period slash
)

# commands
$led -a $purple

for key in ${vim_keys[@]}; do
	$led -k $key $vim_key_color
done

# for key in "${vim_keys[@]}"; do
# 	$led -fx breathing "$key" $vim_key_color 0a
# done

for key in ${syntax_keys[@]}; do
	$led -k $key $syntax_key_color
done

for key in ${num_keys[@]}; do
	$led -k $key $num_key_color
done

$led -g modifiers $cyan
$led -g numeric $cyan
$led -g arrows $yellow

$led -k win_left $yellow
$led -k win_right $yellow

g815-led -fx breathing logo $magenta 0a
