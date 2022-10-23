# PLISS

Skip material for PLISS 2022. Unfortunately, SkipLabs didn't have time to open-source the version
of the SKIP compiler  that we use internally.
The reason is more because of a lack of time than anything else.
We are hopeful we should be able to open-source it in 2023.

In the mean time, here is a bare minimum version available for the class of PLISS 2022.
Unfortunately, that version still has a few bugs, but it's much much simpler to build.
Long term, that's the version we will be using at SkipLabs too, but it's just not
ready for prime time. However, it should be enough to play!

Before you ask, the things that are annoying:
- There are no stacktraces on exceptions, you need to rerun the program in gdb to have
a stacktrace.
- You cannot use try/catch directly, you have to use vtry with two closures.

# INSTALL

The compiler should also compile on mac, but I would recommend using linux ubuntu.
You *have* to use clang-12 (or older). The runtime seems to segfault starting at
version 13 (and later). It's probably nothing, but I didn't find the time
to debug it.

Clone the repo:
```
git clone https://github.com/SkipLabs/pliss.git
```

Build:
```
cd pliss && make
```

# Mini skip

You can find an implementation of a mini skip language under mini_skip/
You can run it using:
```
$ echo "path/to/source/file" | ./build/mini_skip
```

To run things "reactively", in other words, for skip to only recompute
what changed. You should run the following: 

```
$ echo "path/to/source/file" | ./build/mini_skip --init /path/to/state
```

The file path/to/state will then contain the internal state of SKFS.
And then, after every change, run the following:

```
$ echo "path/to/source/file" | ./build/mini_skip --data /path/to/state
```

That way, SKFS will only recompute what changed between the last run
and the moment when it's called.

The same pattern will work with any SKIP program using SKFS.
You first initialize the state with --init, and then run the same
command with --data to update incrementally. 

Finally, the easiest thing to do if you want to play is just to modify
the files in mini_skip/.
So for example, in mini_skip/main.sk, try commenting the main source
code and replace it with

```
debug("Hello world!"); // debug can print any skip object!
```
