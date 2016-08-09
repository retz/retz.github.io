#!/bin/sh

TAG=$1

set -e

if [ -z $TAG ]; then
    echo "set an argument as a tag"
    exit
fi

echo "Updating website to ${TAG}"

if [ ! -d "retz" ]; then
    git clone git://github.com/retz/retz --branch ${TAG}
else
    git -C retz checkout ${TAG}
fi

git -C retz status
git -C retz branch

echo "Building Javadoc"
cd retz && make javadoc && cd ..

echo "Clearing Javadoc"
git rm -rf javadoc

echo "Adding new Javadoc"
cp -r retz/build/docs/javadoc .
git add javadoc

git commit -m "Update javadoc to Retz ${TAG}" -S

echo "Run 'git push' and publish the document."

