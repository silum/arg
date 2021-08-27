/* Released under MIT License
 *
 * Copyright (c) 2021 Deneys S. Maartens.
 *
 * Permission is hereby granted, free of charge, to any person
 * obtaining a copy of this software and associated documentation
 * files (the "Software"), to deal in the Software without
 * restriction, including without limitation the rights to use, copy,
 * modify, merge, publish, distribute, sublicense, and/or sell copies
 * of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be
 * included in all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
 * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
 * HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
 * WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 * DEALINGS IN THE SOFTWARE.
 */

/* Uses exit() & EXIT_FAILURE (from stdlib.h), and NULL (from stddef.h). */

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
	     && '-' == argv[0][0] \
	     && '\0' != argv[0][1]; \
	     argc--, argv++) { \
		int _i, _used; \
		char **_argv; \
		if ('-' == argv[0][1] \
		    && '\0' == argv[0][2]) { \
			argc--, argv++; \
			break; \
		} \
		for (_i = 1, _used = 0, _argv = argv; \
		     '\0' != argv[0][_i] \
		     && 0 == _used; \
		     _i++) { \
			char _argc; \
			if (_argv != argv) \
				break; \
			_argc = argv[0][_i]; \
			switch (_argc)
#define ARGEND \
		} \
	}

#define ARGC()  _argc

#define ARGF_(expr) \
	(('\0' == argv[0][_i + 1] \
	  && NULL == argv[1]) \
	 ? (expr) \
	 : (_used = 1, ('\0' != (argv[0][_i + 1])) \
	                ? (&argv[0][_i + 1]) \
	                : (argc--, argv++, *argv)))
#define EARGF(x)  ARGF_(((x), exit(EXIT_FAILURE), (char *)NULL))
#define ARGF()  ARGF_((char *)NULL)

#endif  /* ARG_H */
