#! /bin/sh
#
# Test various argument combinations; arg permutations generated with:
#
# ```py
# from itertools import permutations
#
# arg = ["-", "--", "-b", "-f", "-f x", "arg"]
#
# print('    "" \\')
# for len in range(1, 4):
#     for each in permutations(arg, len):
#         print(f'    "{" ".join(each)}" \\')
#
# arg = ["--", "---", "--b", "--f", "--f x", "arg"]
#
# print('    "" \\')
# for len in range(1, 3):
#     for each in permutations(arg, len):
#         print(f'    "{" ".join(each)}" \\')
# ```

set -e

for arg in \
    "" \
    "-" \
    "--" \
    "-b" \
    "-f" \
    "-f x" \
    "arg" \
    "- --" \
    "- -b" \
    "- -f" \
    "- -f x" \
    "- arg" \
    "-- -" \
    "-- -b" \
    "-- -f" \
    "-- -f x" \
    "-- arg" \
    "-b -" \
    "-b --" \
    "-b -f" \
    "-b -f x" \
    "-b arg" \
    "-f -" \
    "-f --" \
    "-f -b" \
    "-f -f x" \
    "-f arg" \
    "-f x -" \
    "-f x --" \
    "-f x -b" \
    "-f x -f" \
    "-f x arg" \
    "arg -" \
    "arg --" \
    "arg -b" \
    "arg -f" \
    "arg -f x" \
    "- -- -b" \
    "- -- -f" \
    "- -- -f x" \
    "- -- arg" \
    "- -b --" \
    "- -b -f" \
    "- -b -f x" \
    "- -b arg" \
    "- -f --" \
    "- -f -b" \
    "- -f -f x" \
    "- -f arg" \
    "- -f x --" \
    "- -f x -b" \
    "- -f x -f" \
    "- -f x arg" \
    "- arg --" \
    "- arg -b" \
    "- arg -f" \
    "- arg -f x" \
    "-- - -b" \
    "-- - -f" \
    "-- - -f x" \
    "-- - arg" \
    "-- -b -" \
    "-- -b -f" \
    "-- -b -f x" \
    "-- -b arg" \
    "-- -f -" \
    "-- -f -b" \
    "-- -f -f x" \
    "-- -f arg" \
    "-- -f x -" \
    "-- -f x -b" \
    "-- -f x -f" \
    "-- -f x arg" \
    "-- arg -" \
    "-- arg -b" \
    "-- arg -f" \
    "-- arg -f x" \
    "-b - --" \
    "-b - -f" \
    "-b - -f x" \
    "-b - arg" \
    "-b -- -" \
    "-b -- -f" \
    "-b -- -f x" \
    "-b -- arg" \
    "-b -f -" \
    "-b -f --" \
    "-b -f -f x" \
    "-b -f arg" \
    "-b -f x -" \
    "-b -f x --" \
    "-b -f x -f" \
    "-b -f x arg" \
    "-b arg -" \
    "-b arg --" \
    "-b arg -f" \
    "-b arg -f x" \
    "-f - --" \
    "-f - -b" \
    "-f - -f x" \
    "-f - arg" \
    "-f -- -" \
    "-f -- -b" \
    "-f -- -f x" \
    "-f -- arg" \
    "-f -b -" \
    "-f -b --" \
    "-f -b -f x" \
    "-f -b arg" \
    "-f -f x -" \
    "-f -f x --" \
    "-f -f x -b" \
    "-f -f x arg" \
    "-f arg -" \
    "-f arg --" \
    "-f arg -b" \
    "-f arg -f x" \
    "-f x - --" \
    "-f x - -b" \
    "-f x - -f" \
    "-f x - arg" \
    "-f x -- -" \
    "-f x -- -b" \
    "-f x -- -f" \
    "-f x -- arg" \
    "-f x -b -" \
    "-f x -b --" \
    "-f x -b -f" \
    "-f x -b arg" \
    "-f x -f -" \
    "-f x -f --" \
    "-f x -f -b" \
    "-f x -f arg" \
    "-f x arg -" \
    "-f x arg --" \
    "-f x arg -b" \
    "-f x arg -f" \
    "arg - --" \
    "arg - -b" \
    "arg - -f" \
    "arg - -f x" \
    "arg -- -" \
    "arg -- -b" \
    "arg -- -f" \
    "arg -- -f x" \
    "arg -b -" \
    "arg -b --" \
    "arg -b -f" \
    "arg -b -f x" \
    "arg -f -" \
    "arg -f --" \
    "arg -f -b" \
    "arg -f -f x" \
    "arg -f x -" \
    "arg -f x --" \
    "arg -f x -b" \
    "arg -f x -f" \
    "" \
    "---" \
    "--b" \
    "--f" \
    "--f x" \
    "--- --" \
    "--- --b" \
    "--- --f" \
    "--- --f x" \
    "--- arg" \
    "--b --" \
    "--b ---" \
    "--b --f" \
    "--b --f x" \
    "--b arg" \
    "--f --" \
    "--f ---" \
    "--f --b" \
    "--f --f x" \
    "--f arg" \
    "--f x --" \
    "--f x ---" \
    "--f x --b" \
    "--f x --f" \
    "--f x arg"
do
    printf "% 16s: " "'$arg'"
    ./ex $arg 2>&1
done | cmp -s /dev/stdin /dev/stderr 2<<EOT
              '': ./ex 0 args:
             '-': ./ex 1 args: '-'
            '--': ./ex 0 args:
            '-b': ./ex -b 0 args:
            '-f': ./ex -f(no arg) 0 args:
          '-f x': ./ex -f(x) 0 args:
           'arg': ./ex 1 args: 'arg'
          '- --': ./ex 2 args: '-' '--'
          '- -b': ./ex 2 args: '-' '-b'
          '- -f': ./ex 2 args: '-' '-f'
        '- -f x': ./ex 3 args: '-' '-f' 'x'
         '- arg': ./ex 2 args: '-' 'arg'
          '-- -': ./ex 1 args: '-'
         '-- -b': ./ex 1 args: '-b'
         '-- -f': ./ex 1 args: '-f'
       '-- -f x': ./ex 2 args: '-f' 'x'
        '-- arg': ./ex 1 args: 'arg'
          '-b -': ./ex -b 1 args: '-'
         '-b --': ./ex -b 0 args:
         '-b -f': ./ex -b -f(no arg) 0 args:
       '-b -f x': ./ex -b -f(x) 0 args:
        '-b arg': ./ex -b 1 args: 'arg'
          '-f -': ./ex -f(-) 0 args:
         '-f --': ./ex -f(--) 0 args:
         '-f -b': ./ex -f(-b) 0 args:
       '-f -f x': ./ex -f(-f) 1 args: 'x'
        '-f arg': ./ex -f(arg) 0 args:
        '-f x -': ./ex -f(x) 1 args: '-'
       '-f x --': ./ex -f(x) 0 args:
       '-f x -b': ./ex -f(x) -b 0 args:
       '-f x -f': ./ex -f(x) -f(no arg) 0 args:
      '-f x arg': ./ex -f(x) 1 args: 'arg'
         'arg -': ./ex 2 args: 'arg' '-'
        'arg --': ./ex 2 args: 'arg' '--'
        'arg -b': ./ex 2 args: 'arg' '-b'
        'arg -f': ./ex 2 args: 'arg' '-f'
      'arg -f x': ./ex 3 args: 'arg' '-f' 'x'
       '- -- -b': ./ex 3 args: '-' '--' '-b'
       '- -- -f': ./ex 3 args: '-' '--' '-f'
     '- -- -f x': ./ex 4 args: '-' '--' '-f' 'x'
      '- -- arg': ./ex 3 args: '-' '--' 'arg'
       '- -b --': ./ex 3 args: '-' '-b' '--'
       '- -b -f': ./ex 3 args: '-' '-b' '-f'
     '- -b -f x': ./ex 4 args: '-' '-b' '-f' 'x'
      '- -b arg': ./ex 3 args: '-' '-b' 'arg'
       '- -f --': ./ex 3 args: '-' '-f' '--'
       '- -f -b': ./ex 3 args: '-' '-f' '-b'
     '- -f -f x': ./ex 4 args: '-' '-f' '-f' 'x'
      '- -f arg': ./ex 3 args: '-' '-f' 'arg'
     '- -f x --': ./ex 4 args: '-' '-f' 'x' '--'
     '- -f x -b': ./ex 4 args: '-' '-f' 'x' '-b'
     '- -f x -f': ./ex 4 args: '-' '-f' 'x' '-f'
    '- -f x arg': ./ex 4 args: '-' '-f' 'x' 'arg'
      '- arg --': ./ex 3 args: '-' 'arg' '--'
      '- arg -b': ./ex 3 args: '-' 'arg' '-b'
      '- arg -f': ./ex 3 args: '-' 'arg' '-f'
    '- arg -f x': ./ex 4 args: '-' 'arg' '-f' 'x'
       '-- - -b': ./ex 2 args: '-' '-b'
       '-- - -f': ./ex 2 args: '-' '-f'
     '-- - -f x': ./ex 3 args: '-' '-f' 'x'
      '-- - arg': ./ex 2 args: '-' 'arg'
       '-- -b -': ./ex 2 args: '-b' '-'
      '-- -b -f': ./ex 2 args: '-b' '-f'
    '-- -b -f x': ./ex 3 args: '-b' '-f' 'x'
     '-- -b arg': ./ex 2 args: '-b' 'arg'
       '-- -f -': ./ex 2 args: '-f' '-'
      '-- -f -b': ./ex 2 args: '-f' '-b'
    '-- -f -f x': ./ex 3 args: '-f' '-f' 'x'
     '-- -f arg': ./ex 2 args: '-f' 'arg'
     '-- -f x -': ./ex 3 args: '-f' 'x' '-'
    '-- -f x -b': ./ex 3 args: '-f' 'x' '-b'
    '-- -f x -f': ./ex 3 args: '-f' 'x' '-f'
   '-- -f x arg': ./ex 3 args: '-f' 'x' 'arg'
      '-- arg -': ./ex 2 args: 'arg' '-'
     '-- arg -b': ./ex 2 args: 'arg' '-b'
     '-- arg -f': ./ex 2 args: 'arg' '-f'
   '-- arg -f x': ./ex 3 args: 'arg' '-f' 'x'
       '-b - --': ./ex -b 2 args: '-' '--'
       '-b - -f': ./ex -b 2 args: '-' '-f'
     '-b - -f x': ./ex -b 3 args: '-' '-f' 'x'
      '-b - arg': ./ex -b 2 args: '-' 'arg'
       '-b -- -': ./ex -b 1 args: '-'
      '-b -- -f': ./ex -b 1 args: '-f'
    '-b -- -f x': ./ex -b 2 args: '-f' 'x'
     '-b -- arg': ./ex -b 1 args: 'arg'
       '-b -f -': ./ex -b -f(-) 0 args:
      '-b -f --': ./ex -b -f(--) 0 args:
    '-b -f -f x': ./ex -b -f(-f) 1 args: 'x'
     '-b -f arg': ./ex -b -f(arg) 0 args:
     '-b -f x -': ./ex -b -f(x) 1 args: '-'
    '-b -f x --': ./ex -b -f(x) 0 args:
    '-b -f x -f': ./ex -b -f(x) -f(no arg) 0 args:
   '-b -f x arg': ./ex -b -f(x) 1 args: 'arg'
      '-b arg -': ./ex -b 2 args: 'arg' '-'
     '-b arg --': ./ex -b 2 args: 'arg' '--'
     '-b arg -f': ./ex -b 2 args: 'arg' '-f'
   '-b arg -f x': ./ex -b 3 args: 'arg' '-f' 'x'
       '-f - --': ./ex -f(-) 0 args:
       '-f - -b': ./ex -f(-) -b 0 args:
     '-f - -f x': ./ex -f(-) -f(x) 0 args:
      '-f - arg': ./ex -f(-) 1 args: 'arg'
       '-f -- -': ./ex -f(--) 1 args: '-'
      '-f -- -b': ./ex -f(--) -b 0 args:
    '-f -- -f x': ./ex -f(--) -f(x) 0 args:
     '-f -- arg': ./ex -f(--) 1 args: 'arg'
       '-f -b -': ./ex -f(-b) 1 args: '-'
      '-f -b --': ./ex -f(-b) 0 args:
    '-f -b -f x': ./ex -f(-b) -f(x) 0 args:
     '-f -b arg': ./ex -f(-b) 1 args: 'arg'
     '-f -f x -': ./ex -f(-f) 2 args: 'x' '-'
    '-f -f x --': ./ex -f(-f) 2 args: 'x' '--'
    '-f -f x -b': ./ex -f(-f) 2 args: 'x' '-b'
   '-f -f x arg': ./ex -f(-f) 2 args: 'x' 'arg'
      '-f arg -': ./ex -f(arg) 1 args: '-'
     '-f arg --': ./ex -f(arg) 0 args:
     '-f arg -b': ./ex -f(arg) -b 0 args:
   '-f arg -f x': ./ex -f(arg) -f(x) 0 args:
     '-f x - --': ./ex -f(x) 2 args: '-' '--'
     '-f x - -b': ./ex -f(x) 2 args: '-' '-b'
     '-f x - -f': ./ex -f(x) 2 args: '-' '-f'
    '-f x - arg': ./ex -f(x) 2 args: '-' 'arg'
     '-f x -- -': ./ex -f(x) 1 args: '-'
    '-f x -- -b': ./ex -f(x) 1 args: '-b'
    '-f x -- -f': ./ex -f(x) 1 args: '-f'
   '-f x -- arg': ./ex -f(x) 1 args: 'arg'
     '-f x -b -': ./ex -f(x) -b 1 args: '-'
    '-f x -b --': ./ex -f(x) -b 0 args:
    '-f x -b -f': ./ex -f(x) -b -f(no arg) 0 args:
   '-f x -b arg': ./ex -f(x) -b 1 args: 'arg'
     '-f x -f -': ./ex -f(x) -f(-) 0 args:
    '-f x -f --': ./ex -f(x) -f(--) 0 args:
    '-f x -f -b': ./ex -f(x) -f(-b) 0 args:
   '-f x -f arg': ./ex -f(x) -f(arg) 0 args:
    '-f x arg -': ./ex -f(x) 2 args: 'arg' '-'
   '-f x arg --': ./ex -f(x) 2 args: 'arg' '--'
   '-f x arg -b': ./ex -f(x) 2 args: 'arg' '-b'
   '-f x arg -f': ./ex -f(x) 2 args: 'arg' '-f'
      'arg - --': ./ex 3 args: 'arg' '-' '--'
      'arg - -b': ./ex 3 args: 'arg' '-' '-b'
      'arg - -f': ./ex 3 args: 'arg' '-' '-f'
    'arg - -f x': ./ex 4 args: 'arg' '-' '-f' 'x'
      'arg -- -': ./ex 3 args: 'arg' '--' '-'
     'arg -- -b': ./ex 3 args: 'arg' '--' '-b'
     'arg -- -f': ./ex 3 args: 'arg' '--' '-f'
   'arg -- -f x': ./ex 4 args: 'arg' '--' '-f' 'x'
      'arg -b -': ./ex 3 args: 'arg' '-b' '-'
     'arg -b --': ./ex 3 args: 'arg' '-b' '--'
     'arg -b -f': ./ex 3 args: 'arg' '-b' '-f'
   'arg -b -f x': ./ex 4 args: 'arg' '-b' '-f' 'x'
      'arg -f -': ./ex 3 args: 'arg' '-f' '-'
     'arg -f --': ./ex 3 args: 'arg' '-f' '--'
     'arg -f -b': ./ex 3 args: 'arg' '-f' '-b'
   'arg -f -f x': ./ex 4 args: 'arg' '-f' '-f' 'x'
    'arg -f x -': ./ex 4 args: 'arg' '-f' 'x' '-'
   'arg -f x --': ./ex 4 args: 'arg' '-f' 'x' '--'
   'arg -f x -b': ./ex 4 args: 'arg' '-f' 'x' '-b'
   'arg -f x -f': ./ex 4 args: 'arg' '-f' 'x' '-f'
              '': ./ex 0 args:
           '---': ./ex badflag('-') badflag('-') 0 args:
           '--b': ./ex badflag('-') -b 0 args:
           '--f': ./ex badflag('-') -f(no arg) 0 args:
         '--f x': ./ex badflag('-') -f(x) 0 args:
        '--- --': ./ex badflag('-') badflag('-') 0 args:
       '--- --b': ./ex badflag('-') badflag('-') badflag('-') -b 0 args:
       '--- --f': ./ex badflag('-') badflag('-') badflag('-') -f(no arg) 0 args:
     '--- --f x': ./ex badflag('-') badflag('-') badflag('-') -f(x) 0 args:
       '--- arg': ./ex badflag('-') badflag('-') 1 args: 'arg'
        '--b --': ./ex badflag('-') -b 0 args:
       '--b ---': ./ex badflag('-') -b badflag('-') badflag('-') 0 args:
       '--b --f': ./ex badflag('-') -b badflag('-') -f(no arg) 0 args:
     '--b --f x': ./ex badflag('-') -b badflag('-') -f(x) 0 args:
       '--b arg': ./ex badflag('-') -b 1 args: 'arg'
        '--f --': ./ex badflag('-') -f(--) 0 args:
       '--f ---': ./ex badflag('-') -f(---) 0 args:
       '--f --b': ./ex badflag('-') -f(--b) 0 args:
     '--f --f x': ./ex badflag('-') -f(--f) 1 args: 'x'
       '--f arg': ./ex badflag('-') -f(arg) 0 args:
      '--f x --': ./ex badflag('-') -f(x) 0 args:
     '--f x ---': ./ex badflag('-') -f(x) badflag('-') badflag('-') 0 args:
     '--f x --b': ./ex badflag('-') -f(x) badflag('-') -b 0 args:
     '--f x --f': ./ex badflag('-') -f(x) badflag('-') -f(no arg) 0 args:
     '--f x arg': ./ex badflag('-') -f(x) 1 args: 'arg'
EOT

# -fin-
