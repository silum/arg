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
		char **_argv; \
		if ('-' == (*argv)[1] \
		    && '\0' == (*argv)[2]) { \
			argc--, argv++; \
			break; \
		} \
		for (_i = 1, _used = 0, _argv = argv; \
		     '\0' != (*argv)[_i] \
		     && 0 == _used; \
		     _i++) { \
			char _argc; \
			if (_argv != argv) \
				break; \
			_argc = (*argv)[_i]; \
			switch (_argc)
#define ARGEND \
		} \
	}

#define ARGC()  _argc

#define ARGF_(expr) \
	(('\0' == (*argv)[_i + 1] \
	  && NULL == argv[1]) \
	 ? (expr) \
	 : (_used = 1, ('\0' != ((*argv)[_i + 1])) \
	                ? (&(*argv)[_i + 1]) \
	                : (argc--, argv++, *argv)))
#define EARGF(x)  ARGF_(((x), exit(EXIT_FAILURE), (char *)NULL))
#define ARGF()  ARGF_((char *)NULL)

#endif  /* ARG_H */
