for keyword in *.pdf
do
    STR=$(find . -name "$keyword.gz")
    if [ -n $STR ]; then
        rm "$keyword"
    fi
done