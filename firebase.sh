#!/bin/sh

if [ $# -ne 4 ]; then
 echo "Need 4 arguments: firebaseProjectID, configurationName, iOSBundleId, androidPackageName"
 exit 1
fi

project=$1
configuration=$2
iosBundleId=$3
androidPackageName=$4

for prefix in "Debug" "Release" "Profile"; do
 echo 'yes' | flutterfire configure \
   --project="$project" \
   --out=lib/app/firebase/"$configuration"/firebase_options.dart \
   --android-out=/android/app/src/"$configuration"/google-services.json \
   --ios-bundle-id="$iosBundleId" \
   --android-package-name="$androidPackageName" \
   --ios-out=/ios/Firebase/"$configuration"/GoogleService-Info.plist \
   --ios-build-config="$prefix"-"$configuration" \
   --yes
done