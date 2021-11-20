# CC?=gcc
# LFLAGS+=-Wall -Wextra -Wpedantic -std=c11
LCC=/Users/samp/code/lance/compiler/test.rb
LFLAGS=
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

$(exe): $(objects) | $(BINDIR)
	$(LCC) $(LFLAGS) -o $@ -i $+

$(BINDIR) $(OBJDIR):
	@mkdir -p $@

$(OBJDIR)/%.ll: $(SRCDIR)/%.lc | $(patsubst $(SRCDIR),$(OBJDIR),$(shell dirname "$@"))
	$(LCC) $(LFLAGS) -i $< -o $| --no-compile
