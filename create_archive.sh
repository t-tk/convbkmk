#!/bin/sh

PROJECT=convbkmk
TMP=/tmp
PWDF=`pwd`
LATEST_RELEASE_TAG=`git tag | sort -r | head -n 1`
RELEASE_TAG=`git tag --points-at HEAD | sort -r | head -n 1`

if [ -z "$RELEASE_TAG" ]; then
    RELEASE_TAG="**not tagged**; later than $LATEST_RELEASE_TAG?"
fi

ARCHIVE=$PROJECT-$RELEASE_TAG

echo " * Create $ARCHIVE.zip ($RELEASE_TAG)"
git archive --format=tar --prefix=$PROJECT/ HEAD | (cd $TMP && tar xf -)
rm $TMP/$PROJECT/.gitignore
rm $TMP/$PROJECT/create_archive.sh
rm -rf $TMP/$PROJECT/samples

cd $TMP && zip -r $PWDF/$ARCHIVE.zip $PROJECT
rm -rf $TMP/$PROJECT
echo
echo " * Done: $ARCHIVE.zip ($RELEASE_TAG)"
