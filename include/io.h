#ifndef IO_H
#define IO_H
#include "str.h"
#include <stdio.h>

typedef struct {
	str *name, *mode;
	FILE *file;
} io;

io *open_io(str *name, str *mode);
str *readline_io(io *io);
str *readall_io(io *io);
void write_io(io *io, str *contents);

#endif
