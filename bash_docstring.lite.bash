#!/usr/bin/env bash

bash_docstring.lite() {
  # #canonical bash_docstring.lite; only reads script docstring, not function docstring within the script.
  # See Also: bash_docstring
  [[ $0 == 'bash' ]] && return 0
  local -i _eval=0
  [[ "${1:-}" == '-e' ]] && { _eval=1; shift; }
  (($#)) && { echo "$1"; shift; }
  local -- line pline
  while IFS= read -r line; do
    line=${line#"${line%%[![:blank:]]*}"}
    [[ -z "$line" ]]                    && continue
    [[ ${line:0:1} == '#' ]]            || break
    [[ $line == '#' || $line == '#@' ]] && { echo; continue; }
    [[ $line =~ ^\#[\@]{,1}\ (.*) ]]    &&  pline="${BASH_REMATCH[1]}" || continue
    ((_eval)) && { eval "echo -e \"$pline\""; continue; }
    echo -e "$pline"
  done <"$0"
  (($#)) && echo "$1"
  return 0
}
declare -fx 'bash_docstring.lite'

#fin
