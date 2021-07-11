# Update an exisiting .po file with new strings from the default.pot file.

if [ -f $1 ]
then
    msgmerge --update --no-fuzzy-matching $1 default.pot
else
    echo "The file '$1' does not exist!"
    exit 1
fi
