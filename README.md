# PeachOS
Simple multi-threaded kernel written in C and Assembly.

Want to make this exact kernel? Buy the course here: https://dragonzap.com/course/developing-a-multithreaded-kernel-from-scratch?coupon=GITHUBDISCOUNT

__Note__: working with debug symbol

```
cd bin
gdb
(gdb) add-symbol-file ../build/kernelfull.o 0x100000
y
(gdb) break _start
(gdb) target remote | qemu-system-x86_64 -S -gdb stdio -hda ./os.bin
(gdb) layout asm
```
