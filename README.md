# Lance
My only compiled language.

## History

I wanted to try to make a compiled language with LLVM. I originally was going to make [stick](https://github.com/sampersand/stick) (then named "Lance") that compiled language, but realized its stringy types made it not a very interesting target. So I renamed it to stick, and then started working on Lance.

I intended to bootstrap it, but never got around to it. However, it still functions, but it's a bit messy.

## Overview
Lance is a Rust-inspired language that I designed with the intent of bootstrapping it as soon as possible. As such, the syntax is intended to be fairly minimal to begin with, to make parsing it easier.

I added some things (like tagged enums) later, so they dont have a ton of nice syntax support. I planned on fixing that when I bootstrapped, but never did.

# Compiling
Lance's compiler is... not terrific. It compiles to llvm, but depends on things in the `include/` folder. steps:

1. Go into `./include` and run `make`. It should create an `out` directory and populate it with a few `.ll` files.
2. `cd` into the directory containing the `.lc` files, removing the `out` folder if it exists.
3. Run `/<path/to/lance/folder>/compiler/lance --no-compile`, passing `-i` for each file you want to compile. You can run this command per file, or just pass multiple `-i`s, both are fine.
4. run `clang out/*.ll /<path/to/lance/folder>/include/out/*.ll`, and your program will be in `a.out`

