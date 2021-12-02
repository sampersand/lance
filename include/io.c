#include "io.h"
#include <string.h>

io *open_io(str *name, str *mode) {
	io *f = xmalloc(sizeof(io));
	f->name = name;
	f->mode = mode;

	char nullterm_name[name->len + 1];
	memcpy(nullterm_name, name->ptr, name->len);
	nullterm_name[name->len] = '\0';

	char nullterm_mode[mode->len + 1];
	memcpy(nullterm_mode, mode->ptr, mode->len);
	nullterm_mode[mode->len] = '\0';

	if (!(f->file = fopen(nullterm_name, nullterm_mode)))
		abort_msg(create_str_from_borrowed("unable to open file."));

	return f;
}

str *readline_io(io *io) {
	char *line = NULL;
	size_t len;

	if ((line = fgetln(io->file, &len)) == NULL) {
		if (feof(io->file)) return allocate_str(0);
		abort_msg(create_str_from_borrowed("unable to read input line."));
	}

	str *s = allocate_str(len);
	s->ptr = strndup(line, len);
	return s;
}

// str *readall_io(io *io);
// void write_io(io *io, str *contents);

// #endif
