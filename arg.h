/* Uses EXIT_FAILURE (from stdlib.h), and NULL (from stddef.h). */

/* The following files served as inspiration for the code below:
 *
 * - <git.suckless.org/st/file/arg.h.html>
 * - <git.suckless.org/farbfeld/file/arg.h.html>
 */

#ifndef ARG_H
#define ARG_H

extern char *argv0;

#define ARGBEGIN \
	for (argv0 = *argv, argc--, argv++; \
	     NULL != *argv \
	     && '-' == (*argv)[0] \
	     && '\0' != (*argv)[1]; \
	     argc--, argv++) { \
		int _i, _used; \
		if ('-' == (*argv)[1] \
		    && '\0' == (*argv)[2]) { \
			argc--, argv++; \
			break; \
		} \
		for (_i = 1, _used = 0; \
		     '\0' != (*argv)[_i]; \
		     _i++) { \
			char _argc; \
			_argc = (*argv)[_i]; \
			switch (_argc)
#define ARGEND \
			if (_used) { \
				if ((*argv)[_i + 1]) { \
					break; \
				} else { \
					argc--, argv++; \
					break; \
				} \
			} \
		} \
	} \

#define ARGC()  _argc

#define ARGF_(expr) \
	(((*argv)[_i + 1]) \
	 ? (_used = 1, &((*argv)[_i + 1])) \
	 : (*(argv + 1)) \
	   ? (_used = 1, *(argv + 1)) \
	   : (expr))
#define EARGF(x)  ARGF_(((x), exit(EXIT_FAILURE), (char *)NULL))
#define ARGF()  ARGF_((char *)NULL)

#endif  /* ARG_H */
