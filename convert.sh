#!/bin/bash
cd openapi-spec
for file in *.json; do
	# Replace host in env and cfg api
	sed -e 's/https:\/\/.*\/api\//\https:\/\/{{DT_HOST}}\/api\//g' -i $file

	# Create postman collection
	../node_modules/.bin/openapi2postmanv2 -s $file -o ../specs/$file

	# Replace Authentication
	sed 's/{{apiKey}}/Api-Token {{DT_TOKEN}}/g' -i ../specs/$file
	sed 's/<API Key>/Api-Token {{DT_TOKEN}}/g' -i ../specs/$file

	# Replace Collection Names
	echo $file
	case $file in
	"cluster-v1.json")
		sed 's/"name":"Dynatrace Cluster API",/"name": "Dynatrace Cluster API v1",/' -i ../specs/$file
		;;
	"cluster-v2.json" )
		sed 's/"name":"Dynatrace Cluster API",/"name": "Dynatrace Cluster API v2",/' -i ../specs/$file
		;;
	"environment-v1.json" )
		sed 's/"name":"Dynatrace Environment API",/"name": "Dynatrace Environment API v1",/' -i ../specs/$file
		;;
	"environment-v2.json" )
		sed 's/"name":"Dynatrace Environment API",/"name": "Dynatrace Environment API v2",/' -i ../specs/$file
		;;
	esac
	
done
