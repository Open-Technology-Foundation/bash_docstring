#!/usr/bin/env bash
# # bash_docstring
#
# ## Docstrings for Shell/Bash
#
# Docstrings are extremely useful for centralising documentation in
# one place, helping to standarise the content that appears in
# READMEs, manpages and command-line help.
#
# Bash docstrings are a semantic near-equivalent of Python docstrings.
# The `bash_docstring` script/function thus emulates Python's
# `__doc__`.
#
# ## Bash Docstring Structure
#
#     [[function ]funcname[ ]()]
#     [#!hashbangs]
#     [#shellchecks]
#     []
#     [#non-docstring comment]
#     # docstring comment '# '
#     # docstring comment
#     # docstring comment
#     # ...
#     # ...
#     commands #docstrings stop when commands start.
#     ...
#
# All hashbangs, shellchecks, blank lines and non-docstring comments
# are ignored while processing the docstring.  Docstring processing
# stops with the first command.
#
# To test `bash_docstring`'s functionality, use `bash_docstring`
# itself:
#
#     # Display the bash_docstring's script docstring
#     bash_docstring
#
#     # Display a script's docstring specifying a source file,
#     # and with parameter expansion (-e).
#     bash_docstring -e bash_docstring.bash
#
#     # Display the docstring for the bash_docstring function
#     # in script file bash_docstring.bash,
#     # with parameter expansion (-e).
#     bash_docstring -e bash_docstring.bash bash_docstring
#
# `bash_docstring` is designed to extract and display docstrings from
# a Bash script or function. The concept of docstrings here is
# similar to Python, where documentation is embedded within the
# code.
#
# The -e switch determines whether to `eval` docstring lines, useful
# if you wish to include display of current variables within the
# docstring.  This can be very useful for dynamic help text.
# Note: '``' and '\$(' are disabled. See warnings below.
#
# If no function name specified, then `bash_docstring` looks for the
# docstring at the start of the script file. If a function name is
# provided, it searches for the docstring associated with that
# function within the source file.
#
# ## Error Handling and Output
#
# If the script fails to find a docstring, it outputs a message and
# returns an error.
#
# ## Security Considerations
#
# The use of `-e|--eval` can be risky if not handled carefully.
# `docstring` attempts to mitigate this risk by escaping '``' and '\$
# (' characters, but users should still be cautious, especially when
# dealing with untrusted input.
#
# ---
#
# Version: $VERSION
#
# Updated: $UPDATED
#
# Author: $AUTHOR
#
# Organisation: $ORGANIZATION
#
# Licence: $LICENSE
#
# Repository: $REPOSITORY
#
# See Also: $SEE_ALSO
#
bash_docstring() {
  #This is a function docstring:
  # ## $PRGNAME Script/Function
  #
  # Displays docstring from a Bash script, or function within a Bash
  # script docstring, directly from script source file.
  #
  # `bash_docstring` is a robust way to organise script and function
  # documentation in a more standardized and consistent manner, using
  # the well-known conventions and protocols of contemporary computer
  # programming.
  #
  # `bash_docstring` is written using 100% core Bash.
  # The in-memory size of the function is less than 2.5K.
  #
  # In typical usage, the `bash_docstring` function is simply sourced
  # or copied into your application script as a replacement for
  # `usage()` or `help()`.
  #
  # ### Usage
  #
  #   `$USAGE`
  #
  #     -e, --eval
  #         Execute `eval` for each docstring line. (Default is no
  #         `eval`.) Escape '\$' chars as required, otherwise Bash
  #         parameter expansion will take place. Note: All '``'
  #         and '""' chars in the docstring are escaped when `-e` is
  #         used.
  #
  #     source_file
  #         Name of script file in which to search for a docstring. If
  #         not specified, `source_file` defaults to \$PRG0
  #         (if present), which otherwise falls back to \$0.
  #
  #     function_name
  #         Name of a function within `source_file`. If
  #         `function_name` is not defined or empty, then the
  #         docstring for the script `source_file` is displayed. If
  #         defined, then the docstring for the `function_name`
  #         function is displayed, and 0 returned. If a docstring is
  #         not found, an error message is displayed and 1 is
  #         returned.
  #
  #   `bash_docstring` reads `source_file` for all contiguous comments
  #   at the top of the script or (optionally) immediately after a
  #   function definition.
  #
  #   Docstring comments are indicated with '# ' (hash-space). Leading
  #   white-space is ignored.
  #
  #   Hashbangs, shellchecks and 'empty' comment lines are all
  #   ignored. Docstring processing stops at the first command in the
  #   script or function.
  #
  #   Docstrings are output to stdout minus leading hash-space '# '.
  #
  # ### Examples:
  #
  #     ./bash_docstring
  #
  #     ./bash_docstring -e
  #
  #     ./bash_docstring -h
  #
  #     ./bash_docstring bash_docstring
  #
  #     ./bash_docstring -e bash_docstring.bash bash_docstring
  #
  #     ./bash_docstring -e "" bash_docstring
  #
  #     ./bash_docstring /my/dir/myscript
  #

  #local -i _verbose=0
  local -i _eval=0
  local -a _arg=()
  while(($#)); do case "$1" in
    -e|--eval)      _eval=1 ;;
    +e|--no-eval)   _eval=0 ;;
    #-v|--verbose)  _verbose+=1 ;;
    #-q|--quiet)    _verbose=0 ;;
    -V|--version)
        [[ -v PRGNAME ]] && echo "$PRGNAME $VERSION"
        return 0 ;;
    -h|--help)
        #dog-fooding to display help from current source.
        [[ -v PRGNAME ]] && bash_docstring -e '' "${FUNCNAME[0]}" | less -FXRS; return 0 ;;
    -D|--debug)
        declare -ix DEBUG; DEBUG+=1
        declare -x PS4='+ $LINENO '
        set -vx
        ;;
    -[eDVh]*) #shellcheck disable=SC2046 # de-aggregate aggregated short options
        set -- '' $(printf -- "-%c " $(grep -o . <<<"${1:1}")) "${@:2}"
        ;;
    -?|--*)
        >&2 echo "${FUNCNAME[0]}: error: Invalid option '$1'"
        return 22
        ;;
    *)  ((${#_arg[@]} > 2)) && {
          >&2 echo "${FUNCNAME[0]}: error: Invalid argument '$1'"
          return 2
        }
        _arg+=("$1")
        ;;
  esac; shift; done

  local -- input_from="${PRG0:-"${0:-}"}"
  ((${#_arg[@]} > 0)) && ((${#_arg[0]})) && input_from="${_arg[0]}"
  [[ -f "$input_from" ]] || {
    >&2 echo "${FUNCNAME[0]}: error: Source file '$input_from' not found"
    return 1
  }
  local -- input_from_base="${input_from##*/}"

  local -- funcname=''
  ((${#_arg[@]} > 1)) && funcname="${_arg[1]}"
  funcname="${funcname//[ \(\)]/}"
  local -- ofuncname="$funcname"

  local -- ln
  while IFS= read -r ln; do
    # hashbang begone.
    [[ "${ln:0:2}" == '#!' ]] && continue
    # Remove leading-trailing blanks from each line.
    ln="${ln#"${ln%%[![:blank:]]*}"}"; ln="${ln%"${ln##*[![:blank:]]}"}";
    # If line is empty, then ignore and continue
    [[ -z "$ln" ]] && continue
    # If 'funcname' has been specified, ignore all lines until we
    # find the start of the function definition for 'funcname'.
    if [[ -n "$funcname" ]]; then
      [[ $ln =~ ^(function[[:blank:]]+)?$funcname[[:blank:]]*\(\) ]] \
        && funcname=''
      continue
    fi
    # If it's not a comment, then bugger orf.
    [[ ${ln:0:1} == '#' ]]          || return 0
    # If it's a lone comment, print a line and keep going.
    [[ $ln == '#' ]]                && { echo; continue; }
    # shellcheck begone.
    [[ $ln =~ ^#[[:space:]]*shellcheck[[:space:]]+disable ]] && continue
    # If it's not a Bash docstring comment, then bugger orf.
    ##[[ ${ln:0:2} == '# ' || ${ln:0:2} == '#@' ]]     || continue
    [[ $ln =~ ^\#[\@]{,1}\ (.*) ]]  &&  ln="${BASH_REMATCH[1]}" || continue

    # Output the docstring line.
    if ((_eval)); then
      # Escape all `, $(, and ".
      ln="${ln//\"/\\\"}"; ln="${ln//\`/\\\`}"; ln="${ln//\$\(/\\\$ \(}";
      [[ "${ln:0:1}" == '-' ]] && ln=" $ln" #hmmm
      eval "echo -e \"$ln\""
    else
      [[ "${ln:0:1}" == '-' ]] && ln=" $ln" #hmmm2
      echo -e "$ln"
    fi
  done <"$input_from"
  >&2 echo "${FUNCNAME[0]}: error: Bash docstring not found for $input_from_base:${ofuncname:-'script'}"
  return 1
}
declare -fx bash_docstring

if [[ "${BASH_SOURCE[0]}" == "$0" ]]; then
  set -euo pipefail
  #! #canonical Provenence Globals for scripts
  declare -ir BUILD=26
  declare -r  \
      PRGNAME='bash_docstring' \
      VERSINFO=([0]='0' [1]='4' [2]='20' [3]="$BUILD" [4]='beta' [5]="${BASH_VERSION:-}") \
      UPDATED='2023-11-30' \
      AUTHOR='Gary Dean' \
      ORGANISATION='Open Technology Foundation' \
      LICENSE='GPL3' \
      DESCRIPTION='Docstrings for Bash/Shell.' \
      DEPENDENCIES='bash >= 5' \
      SEE_ALSO='bash_docstring.lite'
  declare -r  \
      USAGE="$PRGNAME [-e] [source_file [function_name]]" \
      VERSION="${VERSINFO[0]}.${VERSINFO[1]}.${VERSINFO[2]}(${VERSINFO[3]})-${VERSINFO[4]}" \
      REPOSITORY="https://github.com/Open-Technology-Foundation/${PRGNAME}" \
      REPOSITORY_NAME=$PRGNAME
  # For US compatibility
  declare -n  \
      ORGANIZATION=ORGANISATION \
      LICENCE=LICENSE
  # For manpage compatibility
  declare -n  \
      AUTHORS=AUTHOR \
      NAME=PRGNAME \
      VERSIONS=VERSION \
      HISTORY=DESCRIPTION \
      COPYRIGHT=LICENSE \
      REQUIREMENTS=DEPENDENCIES \
      SYNOPSIS=USAGE

  declare -ixg DEBUG=${DEBUG:-0}
  ((DEBUG>1)) && { declare -xg PS4='+ $LINENO: '; set -xv; }
  bash_docstring "$@"
fi

#fin
