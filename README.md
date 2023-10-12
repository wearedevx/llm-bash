# LLM-Bash - Bash Wrapper around LLM-CLI and Ollama for VIM, NEOVIM and EMACS.

## Getting Started

### Install dependencies

You can use both LLM-CLI and Ollama. I use both to experiment with many different models, local and through APIs like OpenAI or Together.

- [LLM-CLI](https://github.com/simonw/llm): A CLI utility and Python library for interacting with Large Language Models, both via remote APIs and models that can be installed and run on your own machine.

To access a large collection of open-source model, you can install the plugin [llm-together](https://github.com/wearedevx/llm-together)

- [Ollama](ollama.ai/): Get up and running with Llama 2 and other large language models locally

I recommend using Mistral 7B OpenOrca unless you have resources to run more demanding models locally.

### Add the project to your $PATH

In order to be able to invoke `lm` (llm) or `oll` (ollama) from your terminal or editors, you will need to add the root folder of this project to your $PATH

Add this line to your `.zshrc` or `.bashrc`

```bash
export PATH=$PATH:<absolute-path-to-this-folder>
```

### Test in your terminal

You can use the wrappers directly:

```bash
# single line use
lm translate/french "Hello there! How are you today?"

# multi-line entry, Ctrl-D after a return line to run the inference
echo "$(cat)" | llm translate/french
```

### Use with VIM, NeoVIM, Emacs and VSCode

Your text selection will be the context used by the prompts and will be replace in-place by the output of the LLM.

#### Vim and the likes, including Emacs Evil-Mode

1. Select a region in visual mode.
2. Enter the command-line mode, tap `:` then `!`
3. Type `lm [prompt-name]` to invoke llm-cli or `oll [prompt-name]` to invoke ollama

Examples

```bash
lm -h # list availables prompts
oll -h # same
lm code/fill # invoke lm to use the prompt code/fill to replace all occurrences of //fill in the selected region by the missing code logic
oll translate/french # translate to French
```

### Add your own prompts

Prompts are located under the folder `prompts`, just add your own bash files or directory and it will show up in the prompt list.

If you have great prompts to share to others, open a pull request, I will be happy to add it to the collection.
