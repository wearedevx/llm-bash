#!/bin/bash

SCRIPT_DIR="$( cd "$( dirname "$(readlink -f "$0")" )" && pwd )"

function display_help() {
    cat << EOF
Usage: lm [OPTION] [PROMPT]

This is a language model bash wrapper for LLM-CLI and OLLAMA.

Options:
  -h, --help           Display this help message and exit
  -t, --temperature    Set the temperature 
  -h, --model          Set the model

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

while [[ "$#" -gt 0 ]]; do
    case $1 in
        --temperature|-t)
            shift
            force_temperature=$1
            ;;
        --model|-m)
            shift
            force_model=$1
            ;;
        --help|-h)
            display_help
            exit 0
            ;;
        *)
            positional_args+=("$1")
            ;;
    esac
    shift
done

set -- "${positional_args[@]}"

CLI="${1}"
PROMPT_NAME="${2}"
TEXT="${3}"
PROMPT_PATH="${SCRIPT_DIR}/prompts/${PROMPT_NAME}.sh"
TEMPERATURE="${temperature:-0.7}"

if [[ ! -f "${PROMPT_PATH}" ]]; then
    echo "${PROMPT_NAME} prompt not found"
    exit 2
fi

if [[ -z "${TEXT}" ]]; then
    input="$(cat)"
else
    input="${TEXT}"
fi

source "${PROMPT_PATH}" "${input}"
temperature="${force_temperature:-${temperature:-0.7}}"

case "${CLI}" in
    "llm")
        model="${force_model:-${llm_model:-gpt-3.5-turbo}}"
        llm "${prompt}" -s "${system}" -o temperature "${temperature}" -m "${model}"
        ;;
    "oll")
        model="${force_model:-${oll_model:-mistral-openorca}}"
        ollama run "${model}" "${system}" "${prompt}"
        ;;
    *)
        echo "${CLI} is unknown."
        exit 2
        ;;
esac
