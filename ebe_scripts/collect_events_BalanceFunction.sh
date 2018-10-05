#!/usr/bin/env bash

usage="./collect_events.sh fromFolder toFolder"

fromFolder=$1
toFolder=$2

if [ -z "$fromFolder" ]
then
    echo $usage
    exit 1
fi
if [ -z "$toFolder" ]
then
    echo $usage
    exit 1
fi

echo "collecting events from " $fromFolder " to " $toFolder

folderName=`echo $fromFolder | sed 's/arena_//'`
mkdir $toFolder/$folderName

eventNum=0
for ijob in `ls --color=none $fromFolder`;
do 
    eventsPath=$fromFolder/$ijob/BalanceFunction_results
    for iev in `ls --color=none $eventsPath`
    do 
        if [ -a $eventsPath/$iev/Balance_function_9998_-9998_Delta_y.dat ]
        then
            mv $eventsPath/$iev $toFolder/$folderName
        fi
        ((eventNum++))
    done
done

echo "Collected events number: " $eventNum
