#!/bin/bash

WHICH_JAVA=$(which java)



echo "This will install the DOI cert to the current java install, which is: $WHICH_JAVA"
echo "For this to work, you must be on the DOI network / VPN."

tmp_dir=$(mktemp -d -t setup_java_ssl_XXX)
echo "Using temp directory $tmp_dir"


curl -o "$tmp_dir/doi-cacert.cer" http://sslhelp.doi.net/docs/DOIRootCA2.cer

echo "Attempting to delete the cert aliased as 'DOI_Cert', which may error if it doesn't exist"
keytool -delete -alias DOI_Cert -cacerts -storepass changeit

echo "Attempting to add new certificate, which may cause a warning if it already exists under a different alias."
echo "If it does exist, remove via > keytool -delete -alias [TheAlias] -cacerts -storepass changeit"
keytool -importcert -file "$tmp_dir/doi-cacert.cer" -alias DOI_Cert -cacerts -storepass changeit -noprompt


echo "Removing temp directory..."
rm -r $tmp_dir