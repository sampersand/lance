# CC?=gcc
# LFLAGS+=-Wall -Wextra -Wpedantic -std=c11
LCC=../compiler/test.rb
LFLAGS=
LLVM=clang
SRCDIR?=src
OBJDIR?=obj
BINDIR?=bin

exe=$(BINDIR)/lance
#source_files=$(wildcard $(SRCDIR)/*.lc)
source_files=$(shell find src -type f -name '*.lc')
objects=$(patsubst $(SRCDIR)/%.lc,$(OBJDIR)/%.ll,$(source_files))

.PHONY: all optimized clean

all: $(exe)

clean:
	-@rm -r $(OBJDIR) $(BINDIR)

$(exe): $(objects) | $(BINDIR) $(OBJDIR)/include
	$(LLVM) -o $(exe) $+ $(shell find $(OBJDIR)/include -type f)

$(BINDIR) $(OBJDIR):
	@mkdir -p $@

$(OBJDIR)/include: $(OBJDIR)
	mkdir $(OBJDIR)/include
	$(LCC) -o $@ --include --no-compile

$(OBJDIR)/%.ll: $(SRCDIR)/%.lc | $(OBJDIR)
	$(LCC) $(LFLAGS) -i $< -o $(shell dirname $< | sed 's!$(SRCDIR)!$(OBJDIR)!') --no-compile
