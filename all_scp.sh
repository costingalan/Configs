#!/bin/bash
#
##   sh batch_scp.sh "machine1 machine2" 'local_file' 'remote_directory'
#

set -euox pipefail

## global options
TIMEOUT=3
OUTLOG=/tmp/remote-out-$$.log

## command line options
MACHINES=$1;shift
LOCAL=$1;shift
REMOTE=$1;shift

## distribute commands to machines
for machine in $MACHINES
    do
        echo $machine >>$OUTLOG.$machine
            scp -q -oStrictHostKeyChecking=no -oBatchMode=yes -oCompression=yes \
                -oConnectTimeout=$TIMEOUT $LOCAL root@$machine:$REMOTE \
                >>$OUTLOG.$machine 2>>$OUTLOG.$machine &
    done

# wait for all processes to finish
wait

## print logs and delete tmp files
cat $OUTLOG.*
rm -f $OUTLOG.*
