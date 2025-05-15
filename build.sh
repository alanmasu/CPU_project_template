if [ "$1" == "-c" ]; then
    echo "Cleaning build..."
    make clean
    rm -rf output
    mkdir -p output
fi
make
make dump > output/dump.txt
make symbols > output/symbols.txt
make sections > output/sections.txt

mkdir -p output

# Dumping symbols using nm and objdump
riscv32-unknown-elf-nm -n -S bin/main.elf > output/nm.txt
echo "" >> output/nm.txt
echo "Dumping symbols section (with objdump)..." >> output/nm.txt
riscv32-unknown-elf-objdump -t bin/main.elf | sort >> output/nm.txt
riscv32-unknown-elf-objdump -D bin/main.elf > output/disas.txt

# Dumping sections and symbols of main.o using nm and objdump
riscv32-unknown-elf-nm -n -S obj/src/main.o > output/nm_main.txt
echo "" >> output/nm_main.txt
echo "Dumping sections..." >> output/nm_main.txt
riscv32-unknown-elf-readelf -S obj/src/main.o >> output/nm_main.txt
echo "" >> output/nm_main.txt
echo "Dumping symbols section (with objdump)..." >> output/nm_main.txt
riscv32-unknown-elf-objdump -t obj/src/main.o | sort >> output/nm_main.txt

# Creating programs files
executePython bin/main.elf bin/testLib.h testLib
# executePython --format sv bin/main.elf bin/testLib.svh testLib
# executePython --format coe bin/main.elf bin/instruction.coe bin/RAM.coe

executePython bin/main.elf ~/workspace/TestCPU/src/programs/testLibProgram.h LibProgram