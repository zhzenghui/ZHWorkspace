#!/bin/bash


WORKSPACEROOT="/Volumes/mac/Users/文件/gitbucket/ZHWorkspace"

SRCROOT="$WORKSPACEROOT/MySocially"
userPlistPath="$SRCROOT/MySocially/info.plist"


echo $SRCROOT
cd $SRCROOT


# #程序名称
AppName=$(/usr/libexec/PlistBuddy -c "print CFBundleName" ${userPlistPath})
AppBundleId=$(/usr/libexec/PlistBuddy -c "print CFBundleIdentifier" ${userPlistPath})
BundleDisplayName=$(/usr/libexec/PlistBuddy -c "print CFBundleDisplayName" ${userPlistPath})
BundleShortVersionString=$(/usr/libexec/PlistBuddy -c "print CFBundleShortVersionString" ${userPlistPath})
BundleVersion=$(/usr/libexec/PlistBuddy -c "print CFBundleVersion" ${userPlistPath})


echo $AppName
echo $AppBundleId
echo $BundleDisplayName
echo "bs version $BundleShortVersionString"
echo "version $BundleVersion"


scheme="MySocially"
build="$SRCROOT/build"
production="$SRCROOT/production"
APPPath="$build/$scheme.app"
IPAPath="$production/$scheme$BundleVersion.ipa"

echo "清理build"
cd ./build
rm -rf ./*
cd ..


# xcode-select --switch path/to/Xcode.app
CODE_SIGN_IDENTITY="iPhone Distribution: Beijing BITCAR Interactive Info&Tech co.,ltd."
PROVISIONING_PROFILE="cf99dee5-b80a-4bab-be13-29d048076c73"

echo "编译项目到build目录"
echo "开始编译"
cd build
xcodebuild clean  CONFIGURATION_BUILD_DIR="$build"
xcodebuild -configuration Release -workspace "$WORKSPACEROOT/ZHWorkspace.xcworkspace"  -scheme "$scheme" CONFIGURATION_BUILD_DIR="$build" CODE_SIGN_IDENTITY="$(CODE_SIGN_IDENTITY)" PROVISIONING_PROFILE="$(PROVISIONING_PROFILE)"
echo "生成成功"


cd production

echo "生成ipa包"

xcrun -sdk iphoneos packageapplication -v $APPPath -o $IPAPath

echo "生成ipa成功"


