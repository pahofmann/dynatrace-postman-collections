#!/bin/bash
cd openapi-spec
for file in *.json
do
	# Replace host in env and cfg api
	sed -e 's/https:\/\/.*\/api\//\https:\/\/{{DT_HOST}}\/api\//g' -i $file

	# Create postman collection
	openapi2postmanv2 -s $file -o ../specs/$file

	# Replace Authentication
	sed 's/<API Key>/Api-Token {{DT_TOKEN}}/g' -i ../specs/$file
done