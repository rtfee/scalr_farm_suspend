##THIS WILL IMPACT ALL SERVERS IN A SPECIFIC ENVIRONMENT##
##Install JQ for JSON parsing##
yum install -y jq

##Install Scalr CLI##
pip install scalr-ctl

##Get Farm Lists##
/usr/local/bin/scalr-ctl --config /tmp/default.yaml farms list --json > farm_list_output.json

##Parse Farm IDs##
jq '.data[].id' farm_list_output.json > parsed_farms.txt

##Suspend Farms##
while read -r LINE; do
    /usr/local/bin/scalr-ctl --config /tmp/default.yaml farms suspend --farmId "$LINE" >> farm_suspend_output
done < parsed_farms.txt
