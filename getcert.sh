#!/bin/sh

cd $LE_CERTS_DIR

COMMAND = 'simp_le'
COMMAND = "$COMMAND --email $LE_EMAIL"
COMMAND = "$COMMAND -f account_key.json"
COMMAND = "$COMMAND -f fullchain.pem"
COMMAND = "$COMMAND -f key.pem"

for DOMAIN in $LE_DOMAINS
do
  COMMAND = "$COMMAND -d $DOMAIN"
done

COMMAND = "$COMMAND --default_root $LE_EMAIL"

echo
echo "Getting certificate with command:"
echo "$COMMAND"
echo

$COMMAND
