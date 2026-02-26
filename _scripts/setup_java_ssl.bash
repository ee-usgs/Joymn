#!/bin/bash

WHICH_JAVA=$(which java)



echo "This will install the DOI cert to the current java install, which is: $WHICH_JAVA"
echo "For this to work, you must be on the DOI network / VPN."

tmp_dir=$(mktemp -d -t setup_java_ssl_XXX)
echo "Using temp directory $tmp_dir"


curl -o "$tmp_dir/doi-cacert.cer" https://apps-int.usgs.gov/ssl/DOIRootCA2.cer

if [ $? -ne 0 ]; then
    echo "Unable to fetch the cert file.  curl error code $?"
    exit 1
fi


echo "Attempting to delete the cert aliased as 'DOI_Cert', which may error if it doesn't exist"
keytool -delete -alias DOI_Cert -cacerts -storepass changeit

echo "Attempting to add new certificate, which may cause a warning if it already exists under a different alias."
echo "If it does exist, remove via > keytool -delete -alias [TheAlias] -cacerts -storepass changeit"
keytool -importcert -file "$tmp_dir/doi-cacert.cer" -alias DOI_Cert -cacerts -storepass changeit -noprompt

if [ $? -ne 0 ]; then
    echo "Unable to add - If a permissions issues, this should be run with sudo.  Error code $?"
    exit 1
fi

echo "Removing temp directory..."
rm -r $tmp_dir