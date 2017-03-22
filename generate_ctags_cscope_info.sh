#!/bin/bash


#DIR_LIST=( "Algorithm" "Data_Structure" "miscellaneous" "lib")
DIR_LIST=( "${PWD}" )

function generate_db_file() {
    echo "========================================="
    echo "<<start to generate database for ctags and cscope!>>"
    #create ctag data base
    for dir in ${DIR_LIST[@]}
    do
        cd ${dir}
        # create ctags db files
        ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .
        # create cscope db files
        find . -name "*.h"\
        -o -name "*.hpp"  \
        -o -name "*.c"    \
        -o -name "*.cpp"  \
        -o -name "*.py"   \
         >cscope.files
        cscope -Rbkq -i cscope.files
    cd -
    done
    echo "<<Finished!>>"
    echo "========================================="
}

function clean_db_file() {
    echo "========================================="
    echo "start to clean ctag and cscope database files>>"
    #create ctag data base
    for dir in ${DIR_LIST[@]}
    do
        cd ${dir}
        rm -rf tags cscope*
        cd -
    done
    echo "Finished!"
    echo "========================================="
}

function main() {
    echo "option is \"${1}\""
    case "${1}" in
        make)
        generate_db_file
        ;;
        clean)
        clean_db_file
        ;;
        *)
        echo "usage example ${0} {make/clean}"
        ;;
    esac
}

option=${1}
main ${option}




