# A small script to update the translation-template, after
# code changes or new Strings.
# Found at http://stackoverflow.com/q/7496156/717341

echo '' > messages.pot # xgettext needs that file, and we need it empty
xgettext -k_ -kN_ -o messages.pot ../*.js
msgmerge -N default.pot messages.pot > new.pot
rm messages.pot default.pot
mv new.pot default.pot
