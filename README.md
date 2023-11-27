# bash_docstring - docstrings for Bash

Bash docstrings are a semantic near-equivalent of Python
docstrings.

Docstrings are extremely useful for centralising documentation in
one place, helping to standarise the content that appears in
READMEs, manpages and command-line help.

## Bash docstring structure

    ```
    [[function ]funcname[ ]()]
    [#!hashbangs]
    []
    [#non-docstring comment]
    # docstring comment '# '
    # docstring comment
    # docstring comment
    # ...
    # ...
    commands #docstring processing stops when commands start.
    ...
    ```

are ignored while processing the docstring.  Docstring processing
stops with the first Bash command.

To test `bash_docstring`'s functionality, use `bash_docstring`
itself:

    ```
    # Display the bash_docstring's script docstring
    :$ bash_docstring

    # Display a script's docstring specifying a source file,
    # and with parameter expansion (-e).
    :$ bash_docstring -e bash_docstring.bash

    # Display the docstring for the bash_docstring function
    # in script file bash_docstring.bash,
    # with parameter expansion (-e).
    :$ bash_docstring -e bash_docstring.bash bash_docstring

    ```

`bash_docstring` is designed to extract and display docstrings
from a Bash script or function. The concept of docstrings here is
similar to Python, where documentation is embedded within the code.

The -e switch determines whether to `eval` docstring lines, useful
if you wish to include display of current variables within the
docstring.  This can be very useful for dynamic help text.  See
warnings below.

If no function name specified, then `bash_docstring` looks for the
docstring at the start of the script file. If a function name is
provided, it searches for the docstring associated with that
function within the source file.

## Error Handling and Output

If the script fails to find a docstring, it outputs an error
message. The use of eval to process docstring lines allows for
dynamic content, but it also requires careful escaping of certain
characters to avoid unintended command execution.

## Security Considerations

The use of eval in shell scripts can be risky if not handled
carefully, as it executes the evaluated string as a command. This
script attempts to mitigate this risk by escaping characters, but
users should still be cautious, especially when dealing with
untrusted input.

Version: 0.4.20

Updated: 2023-11-30

Author: Gary Dean

Organisation: Open Technology Foundation

Licence: GPL3

Repository: https://github.com/Open-Technology-Foundation/bash_docstring


## bash_docstring Script/Function

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

### Usage

  `bash_docstring [-e] [source_file [function_name]]`

  ```
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
  ```

  `bash_docstring` reads `source_file` for all contiguous comments
  at the top of the script or (optionally) immediately after a
  function definition.

  docstring comments are indicated with a leading '# '
  (hash space).

  ignored. docstring processing stops at the first non-'# '*
  line, usually a command.

  docstrings are output minus leading '# '.

### Examples:

  ```
  :$ ./bash_docstring

  :$ ./bash_docstring -h

  :$ ./bash_docstring bash_docstring

  :$ ./bash_docstring -e bash_docstring.bash bash_docstring

  :$ ./bash_docstring -e "" bash_docstring

  :$ ./bash_docstring /my/dir/myscript

  ```
