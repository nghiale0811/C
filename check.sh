sentinel=true

if [ "$1" = "-d" ]; then
    sentinel=false
fi

for keyword in "$@" 
do   
    if [ -d "$keyword" ] && [ "$sentinel" = true ] && [ "$keyword" != "-d" ]; then
        echo "$keyword exists"
    elif [ ! -d "$keyword" ] && [ "$sentinel" = true ] && [ "$keyword" != "-d" ]; then
        echo "$keyword does not exist"
    elif [ -d "$keyword" ] && [ "$sentinel" = false ] && [ "$keyword" != "-d" ]; then
        echo "$keyword is a directory"
    elif [ ! -d "$keyword" ] && [ "$sentinel" = false ] && [ "$keyword" != "-d" ]; then
        echo "$keyword is not a directory"
    fi
    
    case "$keyword" in  
        *-d* )
            sentinel=false
            ;;
        *)
            sentinel=true
            ;;
    esac
    
done



