#!/bin/bash



if [ -f "/usr/local/opt/sdkman-cli/libexec/bin/sdkman-init.sh" ]; then
	echo "SdkMan is already installed - Updating"

	source "/usr/local/opt/sdkman-cli/libexec/bin/sdkman-init.sh"
	sdk selfupdate force
else 
	echo "SdkMan not found - Installing"
	curl -s "https://get.sdkman.io" | bash
fi

