#!/usr/bin/env bash
set -e

mkdir -p ~/.m2
cd ~/.m2

# Backing up settings data
backup_date=$(date +%s)
if [ -f settings-security.xml ]; then
	echo "Backing up settings-security.xml -> settings-security.xml.${backup_date}.backup"
	mv settings-security.xml "settings-security.xml.${backup_date}.backup"
fi
if [ -f settings.xml ]; then
	echo "Backing up settings.xml -> settings.xml.${backup_date}.backup"
	mv settings.xml "settings.xml.${backup_date}.backup"
fi

# Getting input from user. We need server id, username, and password
unset server_id
unset username
unset password
# Reference for ID: https://maven.apache.org/settings.html
echo -n "Enter your server id, this must match the mirror/repository that it tries to connect to: "
read -r server_id
echo -n "Enter your LDAP username: "
read -r username
echo -n "Enter your LDAP password (this will be hidden): "
read -r -s password
echo ""

# Generating clean settings-security.xml file
echo "Generating random one time hash..."
random_hash=$(cat /dev/urandom | env LC_CTYPE=C tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)
emp_hash="$(mvn -emp "${random_hash}")"
cat > settings-security.xml << END_OF_SETTINGS_SECURITY_XML
<settingsSecurity>
  <master>${emp_hash}</master>
</settingsSecurity>
END_OF_SETTINGS_SECURITY_XML

# Generating clean settings.xml file from given user input
ldap_hash="$(mvn -ep "${password}")"
cat > settings.xml << END_OF_SETTINGS_XML
<?xml version="1.0" encoding="UTF-8"?>
<settings xmlns="http://maven.apache.org/SETTINGS/1.1.0" xlmns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://maven.apache.org/SETTINGS/1.1.0http://maven.apache.org/xsd/settings-1.1.0.xsd">
  <servers>
    <server>
	  <id>${server_id}</id>
	  <username>${username}</username>
	  <password>${ldap_hash}</password>
	</server>
  </servers>
</settings>
END_OF_SETTINGS_XML

echo "This has been completed successfully! (Catting your settings.xml file for a human sanity check)"
cat settings.xml