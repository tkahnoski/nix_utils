#!/bin/sh

MAIL=/usr/sbin/sendmail
MAILTO=`cat ~/check_site.mailto`
#script checks if a site is available
if [ -z "$1" -o -z "$2" ];
then
  echo "usage: check_site.sh <host> <url>"
  echo "  i.e. to check www.thomaskahnoski.net/"
  echo "  sh check_site.sh www.thomaskahnoski.net '/'"
  echo "  sendmail may need some help..."
  exit 1
fi

TIME=`date +%Y-%m-%d_%H`
REMOTE_HOST=$1
REMOTE_URL="$1$2"
SUBJPRE="[site check] $TIME"
HEADER="---- $USER@$HOSTNAME: $SUBJPRE ----"
PING=`ping -c 4 $REMOTE_HOST 2>&1 && echo "0"`
echo $PING | grep -q ' 0$'

if [[ $? -ne 0 ]];
then
(
  MESSAGE="PING FAILED '$REMOTE_HOST'"
  echo "Subject: $SUBJPRE $MESSAGE"
  echo ""
  echo "$HEADER"
  echo "$MESSAGE"
  echo "Ping output"
  echo ""
  echo "$PING"
) | $MAIL $MAILTO
exit 1
fi

WGET=`wget -O - $REMOTE_URL 2>&1`
if [[ $? -ne 0 ]];
then
(
  MESSAGE="WGET FAILED '$REMOTE_URL'"
  echo "Subject: $SUBJPRE $MESSAGE"
  echo ""
  echo "$HEADER"
  echo "$MESSAGE"
  echo "Wget output"
  echo ""
  echo "$WGET"
) | $MAIL $MAILTO
exit 1
fi

MAGIC_STRING="access is either busy"
echo $WGET | grep -qv -e "$MAGIC_STRING"
if [[ $? -ne 0 ]];
then
(
  MESSAGE="FAILURE CONTENT '$REMOTE_URL'"
  echo "Subject: $SUBJPRE $MESSAGE"
  echo ""
  echo "$HEADER"
  echo "$MESSAGE"
  echo "Wget output matched '$MAGIC_STRING'"
  echo ""
  echo "$WGET"
) | $MAIL $MAILTO
exit 1
fi

exit 0
