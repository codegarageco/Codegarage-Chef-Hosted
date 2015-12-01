#!/bin/sh

SCRIPTS_DIR=$(dirname ${0:-})
ROOT_DIR="$SCRIPTS_DIR/.."

source $SCRIPTS_DIR/utils.sh

UPDATE_ALL=true
UPDATE_COOKBOOKS=false
UPDATE_DATA_BAGS=false
UPDATE_ENVIRONMENTS=false
UPDATE_ROLES=false

usage() { echo "Usage: $0 [-c (for cookbooks)] [-d (for data bags)] [-e (for environments)] [-r (for roles)]" 1>&2; exit 1; }

while getopts "cder" opt; do
  case $opt in
    c)
      UPDATE_COOKBOOKS=true
      UPDATE_ALL=false
      ;;
    d)
      UPDATE_DATA_BAGS=true
      UPDATE_ALL=false
      ;;
    e)
      UPDATE_ENVIRONMENTS=true
      UPDATE_ALL=false
      ;;
    r)
      UPDATE_ROLES=true
      UPDATE_ALL=false
      ;;
    \?)
      usage
      ;;
  esac
done

pushd $ROOT_DIR

#
# Upload all cookbooks
#
if [ "$UPDATE_COOKBOOKS" == "true" ] || [ "$UPDATE_ALL" == "true" ]; then
  p_info "Upload cookbooks"
  berks upload
  knife cookbook upload -a
fi

#
# Upload all roles
#
if [ "$UPDATE_ROLES" == "true" ] || [ "$UPDATE_ALL" == "true" ]; then
  p_info "Upload roles"
  knife role from file roles/*.json
fi

#
# Upload all environments
#
if [ "$UPDATE_ENVIRONMENTS" == "true" ] || [ "$UPDATE_ALL" == "true" ]; then
  p_info "Upload environments"
  environments=`ls ./environments`
  for environment in $environments
  do
    knife environment from file environments/$environment
  done
fi

#
# Upload all data bags
#
if [ "$UPDATE_DATA_BAGS" == "true" ] || [ "$UPDATE_ALL" == "true" ]; then
  p_info "Upload data bags"
  data_bags=`ls ./data_bags`
  for data_bag in $data_bags
  do
    knife data bag create $data_bag
    knife data bag from file $data_bag data_bags/$data_bag/*
  done
fi

popd
