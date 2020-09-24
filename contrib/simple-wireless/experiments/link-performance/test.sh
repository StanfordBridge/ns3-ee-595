#!/bin/bash



set -e

control_C()
{
    echo "exiting"
    exit $?
}

run()
{
    ./waf --run "link-performance --packetSize=$packetSize --frequency==`expr $frequency \* 1000000000` --distance==$distance"
}

trap control_C SIGINT

echo "Please choose a parameter as the variable"
select var in "distance" "packetSize" "frequency"
do
    case $var in
        distance ) echo "packetSize,frequency,d_min,d_max,d_stepSize"
            read packetSize frequency d_min d_max d_stepSize
            for distance in `seq $d_min $d_stepSize $d_max`
            do
               ./waf --run "link-performance --packetSize=$packetSize --frequency=`expr $frequency \* 1000000000` --distance=$distance"
            done
            break;;
        packetSize ) echo "frequency,distance,p_min,p_max,p_stepSize" 
            read frequency distance p_min p_max p_stepSize
            for packetSize in `seq $p_min $p_stepSize $p_max`
            do
               ./waf --run "link-performance --packetSize=$packetSize --frequency=`expr $frequency \* 1000000000` --distance=$distance"
            done   
            break ;;
        frequency ) echo "packetSize,distance,f_min,f_max,f_stepSize"
            read packetSize distance f_min f_max f_stepSize
            for frequency in `seq $f_min $f_stepSize $f_max`
            do
                ./waf --run "link-performance --packetSize=$packetSize --frequency=`expr $frequency \* 1000000000` --distance=$distance"
            done
         break ;;
    esac
done

