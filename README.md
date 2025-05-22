# Cat in ASM

This is a simple exercise to reproduce the ´cat´ executable that you find on most Linux distributions.

The challenge is to write it purely in x86_64 ASM.

Right now it works in the sense that it takes in a list of files as command line args, and outputs the contents of those files one by one.

## Comparison with GNU cat
This project produces something that is much more limited than the `cat` you probably already have available to you, and so in any fair comparison that version is much better.  You should choose it over this project for real world uses.

That said, it is still fun to compare the speed of these executables.

```console
$ time for n in $(seq 1 10000); do ./cat testfile.txt > /dev/null; done

real    0m3.266s
user    0m1.899s
sys     0m1.611s
$ time for n in $(seq 1 10000); do cat testfile.txt > /dev/null; done

real    0m8.182s
user    0m3.126s
sys     0m5.085s
```

Note that the exeuctable produced by this project takes only 40% of the time taken by GNU `cat`.  As mentioned already, this is an apples-to-oranges comparison, but still a fun little observation.

## Todo
1. Handle command line flags
1. Handle stdin

