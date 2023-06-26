#! /bin/bash

# Demo based on documentation: https://docs.sysdig.com/en/docs/developer-tools/managing-access-keys/

SECURE_API_TOKEN="*********-********-*****-*******"
SYSDIG_URL="us2.app.sysdig.com"

# Retrieve all the Access Keys
curl -XGET -H "Authorization: Bearer $SECURE_API_TOKEN" https://$SYSDIG_URL/api/customers/accessKeys | jq

# Retrieve teams
curl -XGET -H "Authorization: Bearer $SECURE_API_TOKEN" https://$SYSDIG_URL/api/v2/teams/light | jq

AR_TEAM_ID=
UY_TEAM_ID=
BR_TEAM_ID=

AR_LIMIT=
UY_LIMIT=
BR_LIMIT=

AR_RESERVATION=
UY_RESERVATION=
BR_RESERVATION=


# Create an Access Key
curl -XPOST -H "Authorization: Bearer $SECURE_API_TOKEN" -H 'Content-Type: application/json;charset=utf-8' -d "{ \"customerAccessKey\": {
		\"limit\": \"$AR_LIMIT\",
		\"reservation\": \"$AR_RESERVATION\",
		\"teamId\": \"$AR_TEAM_ID\",
		\"metadata\": { \"COUNTRY\": \"Argentina\", \"bu\": \"finAnce\" }
	}
}" https://$SYSDIG_URL/api/customers/accessKeys | jq


curl -XPOST -H "Authorization: Bearer $SECURE_API_TOKEN" -H 'Content-Type: application/json;charset=utf-8' -d "{ \"customerAccessKey\": {
		\"limit\": \"$UY_LIMIT\",
		\"reservation\": \"$UY_RESERVATION\",
		\"teamId\": \"$UY_TEAM_ID\",
		\"metadata\": { \"COUNTRY\": \"Uruguay\", \"bu\": \"SALES FOrce\" }
	}
}" https://$SYSDIG_URL/api/customers/accessKeys | jq

curl -XPOST -H "Authorization: Bearer $SECURE_API_TOKEN" -H 'Content-Type: application/json;charset=utf-8' -d "{ \"customerAccessKey\": {
		\"limit\": \"$BR_LIMIT\",
		\"reservation\": \"$BR_RESERVATION\",
		\"teamId\": \"$BR_TEAM_ID\",
		\"metadata\": { \"COUNTRY\": \"Brasil\", \"bu\": \"ALL\" }
	}
}" https://$SYSDIG_URL/api/customers/accessKeys | jq

# Update Access Key

UY_LIMIT=
UY_RESERVATION=

AR_LIMIT=
AR_RESERVATION=

curl -XPUT -H "Authorization: Bearer $SECURE_API_TOKEN" -H 'Content-Type: application/json;charset=utf-8' -d "{ \"customerAccessKey\": {
		\"limit\": \"$UY_LIMIT\",
		\"reservation\": \"$UY_RESERVATION\",
		\"teamId\": \"$UY_TEAM_ID\",
		\"metadata\": { \"COUNTRY\": \"Uruguay\", \"bu\": \"Finance\" }
	}
}" https://$SYSDIG_URL/api/customers/accessKeys/$UY_ACCESS_KEY | jq


curl -XPUT -H "Authorization: Bearer $SECURE_API_TOKEN" -H 'Content-Type: application/json;charset=utf-8' -d "{ \"customerAccessKey\": {
		\"limit\": \"$AR_LIMIT\",
		\"reservation\": \"$AR_RESERVATION\",
		\"teamId\": \"$AR_TEAM_ID\",
		\"metadata\": { \"COUNTRY\": \"Argentina\", \"bu\": \"Finance\" }
	}
}" https://$SYSDIG_URL/api/customers/accessKeys/$AR_ACCESS_KEY | jq

# Disable an Access Key
curl -XPOST -H "Authorization: Bearer $SECURE_API_TOKEN" -H 'Content-Type: application/json;charset=utf-8' https://$SYSDIG_URL/api/customers/accessKeys/$UY_ACCESS_KEY/disable | jq

# Enable an Access Key
curl -XPOST -H "Authorization: Bearer $SECURE_API_TOKEN" -H 'Content-Type: application/json;charset=utf-8' https://$SYSDIG_URL/api/customers/accessKeys/$UY_ACCESS_KEY/enable | jq

# Search for the Access Keys Based on Metadata
curl -XGET -H "Authorization: Bearer $SECURE_API_TOKEN" -H 'Content-Type: application/json;charset=utf-8' https://$SYSDIG_URL/api/customers/accessKeys?COUNTRY=Uruguay | jq

curl -XGET -H "Authorization: Bearer $SECURE_API_TOKEN" -H 'Content-Type: application/json;charset=utf-8' https://$SYSDIG_URL/api/customers/accessKeys?bu=Finance | jq


# Retrieve the Access Keys Based on Team ID
curl -XGET -H "Authorization: Bearer $SECURE_API_TOKEN" -H 'Content-Type: application/json;charset=utf-8' https://$SYSDIG_URL/api/customers/accessKeys?teamId=$BR_TEAM_ID | jq

# Retrieve the Access Keys assigned to a team of the user whose API token is used | Must be Team Manager or Admin
curl -XGET -H "Authorization: Bearer $SECURE_API_TOKEN" -H 'Content-Type: application/json;charset=utf-8' https://$SYSDIG_URL/api/customers/accessKeys/forCurrentTeam | jq

# Delete an Access Key
curl -XDELETE -H "Authorization: Bearer $SECURE_API_TOKEN" -H 'Content-Type: application/json;charset=utf-8' https://$SYSDIG_URL/api/customers/accessKeys/$AR_ACCESS_KEY | jq
