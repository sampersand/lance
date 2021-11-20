# CC?=gcc
# LFLAGS+=-Wall -Wextra -Wpedantic -std=c11
LCC=../compiler/test.rb
INCLUDE=$(shell find ../include/out -type f)
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
	$(CC) -o $@ $+ $(INCLUDE)

$(BINDIR) $(OBJDIR):
	@mkdir -p $@

$(OBJDIR)/%.ll: $(SRCDIR)/%.lc | $(OBJDIR)
	$(LCC) $(LFLAGS) -i $< -o $(shell dirname $< | sed 's!$(SRCDIR)!$(OBJDIR)!') --no-compile
