overwrite=false
building=false

for keyword in "$@" 
do   
    if [ "$keyword" = "-o" ]; then
        overwrite=true
    fi

    if [ "$keyword" = "-b" ]; then
        building=true
    fi
done

for keyword in "$@" 
do
    if [ "$keyword" != "-b" ] && [ "$keyword" != "-o" ]; then
        if [ "$overwrite" = true ] && [ "$building" = true ]; then
            cd support-files
            cp a2.h ../submissions/$keyword
            cp a2main.c ../submissions/$keyword

            cd ../submissions/$keyword/
            gcc a2.c a2main.c -o a2main 2> /dev/null
            if [ $? -ne 0 ]; then
                echo "$keyword build failed" >> ../../fail-build.log
            fi
            if [ -f ./a2main ]; then
                ./a2main 2> /dev/null
                if [ $? -ne 0 ]; then
                    echo "$keyword test failed" >> ../../fail-test.log
                fi
            fi
            cd ../..
        
        elif [ "$overwrite" = true ] && [ "$building" = false ]; then
            cd support-files
            cp a2.h ../submissions/$keyword
            cp a2main.c ../submissions/$keyword

            cd ../submissions/$keyword/
            gcc a2.c a2main.c -o a2main 2> /dev/null
            if [ ! -f ./a2main ]; then
                gcc a2.c a2main.c -o a2main 2> /dev/null
                if [ $? -ne 0 ]; then
                    echo "$keyword build failed" >> ../../fail-build.log
                fi
            elif [ -f ./a2main ]; then
                if [ ./a2main.c -nt ./a2main ]\
                || [ ./a2.c -nt ./a2main ]\
                || [ ./a2.h -nt ./a2main ]; then
                    gcc a2.c a2main.c -o a2main 2> /dev/null
                    if [ $? -ne 0 ]; then
                        echo "$keyword build failed" >> ../../fail-build.log
                    fi
                fi
            fi
            if [ -f ./a2main ]; then
                ./a2main 2> /dev/null
                if [ $? -ne 0 ]; then
                    echo "$keyword test failed" >> ../../fail-test.log
                fi
            fi
            cd ../..
        
        elif [ "$overwrite" = false ] && [ "$building" = true ]; then
            cd support-files
            if [ ! -f ../submissions/$keyword/a2.h ]; then
                cp a2.h ../submissions/$keyword
            fi
            if [ ! -f ../submissions/$keyword/a2main.c ]; then
                cp a2main.c ../submissions/$keyword
            fi

            cd ../submissions/$keyword/
            gcc a2.c a2main.c -o a2main 2> /dev/null
            if [ $? -ne 0 ]; then
                echo "$keyword build failed" >> ../../fail-build.log
            fi
            if [ -f ./a2main ]; then
                ./a2main 2> /dev/null
                if [ $? -ne 0 ]; then
                    echo "$keyword test failed" >> ../../fail-test.log
                fi
            fi
            cd ../..
        
        elif [ "$overwrite" = false ] && [ "$building" = false ]; then
            cd support-files
            if [ ! -f ../submissions/$keyword/a2.h ]; then
                cp a2.h ../submissions/$keyword
            fi
            if [ ! -f ../submissions/$keyword/a2main.c ]; then
                cp a2main.c ../submissions/$keyword
            fi
            
            cd ../submissions/$keyword/
            if [ ! -f ./a2main ]; then
                gcc a2.c a2main.c -o a2main 2> /dev/null
                if [ $? -ne 0 ]; then
                    echo "$keyword build failed" >> ../../fail-build.log
                fi
            elif [ -f ./a2main ]; then
                if [ ./a2main.c -nt ./a2main ]\
                || [ ./a2.c -nt ./a2main ]\
                || [ ./a2.h -nt ./a2main ]; then
                    gcc a2.c a2main.c -o a2main 2> /dev/null
                    if [ $? -ne 0 ]; then
                        echo "$keyword build failed" >> ../../fail-build.log
                    fi
                fi
            fi
            if [ -f ./a2main ]; then
                ./a2main 2> /dev/null
                if [ $? -ne 0 ]; then
                    echo "$keyword test failed" >> ../../fail-test.log
                fi
            fi
            cd ../..
        fi
    fi
done
