#!/bin/bash                                                                                                                                                                                                                                                           
if [ $1 ]
then
    dir=$1
else
    dir='/var/node/app/test'
fi
if [ $2 ]
then
    redir=$2
else
    redir='/var/mocha_log'
fi
echo 'source of mocha unit test code:  '$dir 
echo 'log of mocha dir  ' $redir
date
cd $dir
function runtest(){
    file=$1
    file_full_path=$dir/$file
    echo $file_full_path
    option=' --compilers coffee:coffee-script'
    time=`date "+%y-%m-%d-%H-%M"`
    #detail log
    redirect=$redir/$file'.log'.$time
    echo $file ' ' $time >> $redirect
    /usr/local/bin/mocha $file_full_path $option >> $redirect 2>&1 
    pass=`cat $redirect | grep passing`
    fail=`cat $redirect | grep failing`
    if [ ! $fail ]
    then
        fail='0 failing'
    fi  

    echo $pass 
    echo $fail 
}

for f in `ls *.test.coffee ` 
do
    runtest $f  
done
exit 0

