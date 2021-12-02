#ifndef SHARED_H
#define SHARED_H

struct _str;
typedef long long ll;

void *xmalloc(ll);
void *xrealloc(void *, ll);
void quit(ll);
void abort_msg(struct _str *);
ll powll(ll, ll);

ll random_(void);
struct _str *prompt(void);

#endif
