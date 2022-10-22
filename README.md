# PLISS

Skip material for PLISS 2022. Unfortunately, we didn't have time to open-source the version
of the SKIP compiler  that we use at SkipLabs.
The reason is more because of a lack of time than anything else.
We are hopeful we should be able to open-source it in 2023.

In the mean time, here is a bare minimum version available for the class of PLISS 2022.
It is far from perfect, but it should do the job.
The things that are annoying:
- There are no stacktraces on exceptions, you need to rerun the program in gdb to have
a stacktrace.
- You cannot use try/catch directly, you have to use vtry with two closures.

# INSTALL

The compiler should also compile on mac, but I would recommend using linux ubuntu.
Clone the repo:
```
git clone https://github.com/SkipLabs/pliss.git
```

Build:
```
cd pliss && make
```

If this step fails, make sure you have the right version of clang installed. Anything under
12 (included) should work. If you already have clang installed, type clang --version. If that version
is lower or equal to 12, go in the Makefile and change clang++-12 to clang++XX where XX
is your version. If for some reason you cannot install a version of clang that is older than
12, come to me and I can help you make it work with a workaround.

# Hello world

Choose a directory to work from, and then run the command:
```
./new_project.sh path/to/your/working/directory
```

This will create a default project with a generic Makefile (for convenience).
To run your code:
```
cd path/to/your/working/directory
make
./build/bin
```

This should print "Hello world!". If it doesn't feel free to reach out for help.
If you are using M1/M2 (the new Mac chips), try removing state.db from the Makefile, it
will slow down the compiler, but it should still work.