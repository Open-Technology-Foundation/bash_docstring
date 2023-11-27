# bash_docstring 0.4.20

Displays docstring from a Bash script or function within a Bash
script docstring directly from script source file.

`bash_docstring` is a robust way to organise script and function
documentation in a more standardized and consistent manner, using
the well-known conventions and protocols of contemporary computer
programming.

`bash_docstring` is written using wholesome, 100% Bash builtins,
and the in-memory size of the function is less than 2.5K.

In typical usage, the `bash_docstring` function is simply sourced
or copied into your application script as a replacement for
`usage()` or `help()`.

## Usage

  `bash_docstring [-e] [source_file [function_name]]`

  -e, --eval
      Execute `eval` for each docstring line. (Default is no
      `eval`.) Escape '$' chars as required, otherwise Bash
      parameter expansion will take place. Note: All '``' and '""'
      chars in the docstring are escaped when `-e` is used.

  source_file
      Name of script file in which to search for a docstring. If
      not specified, `source_file` defaults to $PRG0
      (if present), which otherwise falls back to $0.

  function_name
      Name of a function within `source_file`.
      If `function_name` is not defined or empty, then the
      docstring for the script `source_file` is displayed.
      If defined, then the docstring for the `function_name`
      function is displayed, and 0 returned.
      If a docstring is not found, an error message is displayed
      and 1 is returned.

  `bash_docstring` reads `source_file` for all contiguous comments
  at the top of the script or (optionally) immediately after a
  function definition.

  docstring comments are indicated with a leading '# '
  (hash space).

  ignored. docstring processing stops at the first non-'# '*
  line, usually a command.

  docstrings are output minus leading '# '.

## Examples:

  ```
  ./bash_docstring

  ./bash_docstring -h

  ./bash_docstring bash_docstring

  ./bash_docstring -e bash_docstring.bash bash_docstring

  ./bash_docstring -e "" bash_docstring

  ./bash_docstring /my/dir/myscript

  ```

# $PRGNAME Script/Function

Displays docstring from a Bash script or function within a Bash
script docstring directly from script source file.

`bash_docstring` is a robust way to organise script and function
documentation in a more standardized and consistent manner, using
the well-known conventions and protocols of contemporary computer
programming.

`bash_docstring` is written using wholesome, 100% Bash builtins,
and the in-memory size of the function is less than 2.5K.

In typical usage, the `bash_docstring` function is simply sourced
or copied into your application script as a replacement for
`usage()` or `help()`.

## Usage

  `bash_docstring [-e] [source_file [function_name]]`

  -e, --eval
      Execute `eval` for each docstring line. (Default is no
      `eval`.) Escape '\$' chars as required, otherwise Bash
      parameter expansion will take place. Note: All '``' and '""'
      chars in the docstring are escaped when `-e` is used.

  source_file
      Name of script file in which to search for a docstring. If
      not specified, `source_file` defaults to \$PRG0
      (if present), which otherwise falls back to \$0.

  function_name
      Name of a function within `source_file`.
      If `function_name` is not defined or empty, then the
      docstring for the script `source_file` is displayed.
      If defined, then the docstring for the `function_name`
      function is displayed, and 0 returned.
      If a docstring is not found, an error message is displayed
      and 1 is returned.

  `bash_docstring` reads `source_file` for all contiguous comments
  at the top of the script or (optionally) immediately after a
  function definition.

  docstring comments are indicated with a leading '# '
  (hash space).

  ignored. docstring processing stops at the first non-'# '*
  line, usually a command.

  docstrings are output minus leading '# '.

## Examples:

  ```
  ./bash_docstring

  ./bash_docstring -h

  ./bash_docstring bash_docstring

  ./bash_docstring -e bash_docstring.bash bash_docstring

  ./bash_docstring -e "" bash_docstring

  ./bash_docstring /my/dir/myscript

  ```


Version: $VERSION
Updated: $UPDATED
Author: $AUTHOR
Organisation: $ORGANIZATION
Licence: $LICENSE
Repository: $REPOSITORY

