# !IMPORTANT
# This file for Linux in (Debian Or Ubuntu)

# color in compile
GREEN="\033[0;32m" # color green
RED="\033[0;31m" # color red
NC="\033[0m" # color reset

# settings all variable in this
COMPILE="g++" # default compile: g++, support for clang (clang+)
NAME_OUTPUT="jgw"
FILES=("app/worker/util.cpp" "app/worker/helper.cpp" \
	"src/jgw_controller.cpp" "app/worker/frequency.cpp" \
	"system/linux/sound.cpp" "src/jgw_play.cpp" \
	"app/worker/fileshelp.cpp" "src/jgw_compile.cpp" \
	"src/jgw_compile_wav.cpp" "system/linux/jgw_compile_exec.cpp" \
	"system/linux/jgw_compile_cpp.cpp" "app/worker/ccm.cpp" \
	"app/worker/ls.cpp" "app/worker/pwd.cpp" "app/worker/color.cpp" \
	"app/worker/exec1.cpp" "app/worker/exec2.cpp" "app/worker/exit.cpp" \
	"app/worker/cd.cpp" "app/worker/clear.cpp") # all file in array string (array<String>)
FILES_NAME=("*") # get all file object (*.o)

# if you won't in release in mode remove -D_DEV in variable FLAGS_COMPILE_OUT
FLAGS_COMPILE_OUT="-O1 -g -D_DEV" # Flags in compile out into object file (.o)
FLAGS_COMPILE_FINISH="-O2 -g `sdl2-config --cflags --libs`" # Flags in compile out to binary file or executable file
OUT_BINARY_SRC="out_src" # out src object (.o) directory
OUT_BINARY_FINISH="out" # out executable file directory

# check its exist folder out_src
if [ -d "$OUT_BINARY_SRC" ] 
then
    # removing directory in out src directory
    rm -rf $OUT_BINARY_SRC # removing directory and all file in directory
    mkdir $OUT_BINARY_SRC # make again directory
else
    # if directory it's undefined this will make a new directory
    mkdir $OUT_BINARY_SRC
fi

# check its exist folder lib
if [ -d "lib" ] 
then
    printf "Exist Folder: ${lib}\n"
else
    mkdir lib
fi

# check its exist folder out
if [ -d "$OUT_BINARY_FINISH" ] 
then
    # if directory output it's already
    printf "Exist Folder: ${OUT_BINARY_FINISH}\n"
else
    # if undefined make new directory output of executable file
    mkdir $OUT_BINARY_FINISH
fi

# compile all files
for i in ${!FILES[@]}; do
	printf "[$i] ${GREEN}Compile: ${FILES[$i]}${NC}\n"
	${COMPILE} -c $FLAGS_COMPILE_OUT ${FILES[$i]}
done

# compile to binary
ALL_LIST_FILE=""
for i in ${!FILES_NAME[@]}; do
  ALL_LIST_FILE="${ALL_LIST_FILE} ${FILES_NAME[$i]}.o"
done

# end compile to executable file
printf "[FINISH #01] ${GREEN}Compile: ${ALL_LIST_FILE}${NC} to: ${NAME_OUTPUT} Binary\n"
${COMPILE} -o $OUT_BINARY_FINISH/$NAME_OUTPUT $ALL_LIST_FILE $FLAGS_COMPILE_FINISH

printf "[FINISH #02] ${GREEN}Compile: jgw_library.cpp${NC} to: libjgw.so Shared Library\n"
${COMPILE} $FLAGS_COMPILE_FINISH -Wall -fPIC -shared -ffast-math \
    src/jgw_library.cpp -o lib/libjgw.so

# move all file to out_src
mv *.o $OUT_BINARY_SRC
