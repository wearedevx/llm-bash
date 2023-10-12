#!/bin/bash

CLI="${1}"
PROMPT_NAME="${2}"
SCRIPT_DIR="$( cd "$( dirname "$(readlink -f "$0")" )" && pwd )"
PROMPT_PATH="${SCRIPT_DIR}/prompts/${PROMPT_NAME}.sh"
TEMPERATURE="${temperature:-0.7}"

function display_help() {
    cat << EOF
Usage: lm [OPTION] [PROMPT]

This is a language model bash wrapper for LLM-CLI and OLLAMA.

Options:
  -h, --help    Display this help message and exit

Prompts:

EOF
     # Loop over the example files
    for prompt_file in ${SCRIPT_DIR}/prompts/**/*.sh; do
        # Source the file to get the 'description' variable
        # Extract the last two parts of the path without .sh extension
        path_without_ext="${prompt_file%.sh}"   # Remove .sh extension
        id="${path_without_ext##*/}"            # Get the file name
        parent_dir="${path_without_ext%/$id}"   # Get the directory containing the file
        parent_dir_name="${parent_dir##*/}"     # Extract the directory name

        final_id="${parent_dir_name}/${id}"     # Concatenate the directory name and file name
    
        description=""
        source "${prompt_file}"
        echo "  ${final_id}: ${description:-missing}"
    done
    echo ""
}

if [[ "${PROMPT_NAME}" == "-h" ]] || [[ "${PROMPT_NAME}" == "--help" ]]; then
 display_help
 exit 0
fi


if [[ ! -f "${PROMPT_PATH}" ]]; then
    echo "${PROMPT_NAME} prompt not found"
    exit 2
fi

input=$(cat)
source "${PROMPT_PATH}" "${input}"

if [[ "${CLI}" == "llm" ]]; then
    MODEL="${llm_model:-gpt-3.5-turbo}"
    llm "${prompt}" -s "${system}" -o temperature "${temperature}" -m "${MODEL}"
elif [[ "${CLI}" == "oll" ]]; then
    MODEL="${oll_model:-mistral:instruct}"
    ollama run "${MODEL}" "${system}" "${prompt}"
else
    echo "${CLI} is unknown."
    exit 2
fi

