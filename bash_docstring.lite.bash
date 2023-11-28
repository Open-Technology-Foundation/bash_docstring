#!/usr/bin/env bash

bash_docstring.lite() {
  # #canonical bash_docstring.lite; only reads script docstring, not function docstring within the script.
  # See Also: bash_docstring
  [[ $0 == 'bash' ]] && return 0
  while IFS= read -r line; do
    line=${line#"${line%%[![:space:]]*}"}
    [[ -z "$line" ]] && continue
    [[ ${line:0:1} == '#' ]] || break
    [[ $line == '#' ]] && { echo; continue; }
    [[ ${line:0:2} == '# '  || ${ln:0:2} == '#@' ]] && echo "${line:2}"
  done <"$0"
  return 0
}
declare -fx 'bash_docstring.lite'

#fin
