#!/bin/bash

VERSION="0.0.1"
ARG=$1

if [ "$ANDROID_HOME" == "" ]
then
  echo "ANDROID_HOME is not set"
  exit 1
fi

if [ "$1" == "--help" ] || [ "$1" == "" ]
then
  echo "android.sh $VERSION"
  echo ""
  echo " --help         - prints this help message"
  echo " --list-avds    - List all avaiable AVDs"
  echo " --avd avd-name - Starts the AVD with the avd-name"
  echo " --favd         - Starts the first AVD from the avd list"
  exit 0
fi

EMULATOR="$ANDROID_HOME/emulator/emulator"

if [ "$1" == "--list-avds" ]
then
  echo "Current avds"
  $EMULATOR -list-avds

  exit 0
fi

if [ "$1" == "--favd" ]
then
  FIRST_AVD=`$EMULATOR -list-avds | head -n 1`
  echo "Booting $FIRST_AVD"
  ($EMULATOR "@$FIRST_AVD" &)
fi

if [ "$1" == "--avd" ]
then
  echo "$1"
  if [ "$2" == "" ]
  then
    echo "No avd-name was specified"
    exit 1
  fi

  SEARCH_EMULATOR=`$EMULATOR -list-avds | grep "$2"`
  if [ "$SEARCH_EMULATOR" == "" ]
  then
    echo "avd-name \"$2\" does not exists"
    exit 1
  fi

  echo "Booting $2"
  ($EMULATOR "@$2" &)
  exit 0
fi

echo "Unknown command $1"
