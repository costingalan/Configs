#!/bin/bash
#
##   sh batch_ssh.sh "machine1 machine2" 'uptime'
#

## global options
TIMEOUT=3
OUTLOG=/tmp/remote-out-$$.log

## command line options
MACHINES=$1;shift
COMMAND=$1;shift

## distribute commands to machines
for machine in $MACHINES
     do
         echo $machine >>$OUTLOG.$machine
             ssh -q -oStrictHostKeyChecking=no -oBatchMode=yes -oCompression=yes \
                 -oConnectTimeout=$TIMEOUT -l root $machine $COMMAND >>$OUTLOG.$machine \
                 2>>$OUTLOG.$machine &
     done

# wait for all processes to finish
wait

## print logs and delete tmp files
cat $OUTLOG.*
rm -f $OUTLOG.*
