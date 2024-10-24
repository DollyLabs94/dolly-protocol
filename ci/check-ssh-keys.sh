if grep -q rsa net/scripts/dolly-user-authorized_keys.sh; then
   echo "No rsa keys allowed, small key sizes are insecure."
   exit 1
fi
