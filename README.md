# LLM-Bash - A Wrapper for llm & Ollama made for your code editors

This is the result of experiments with the visual-mode and command-line mode in vi. By combining a bash utility wrapping AI CLIs with the flow "Selection -> Run Shell Command on Selection -> Replace Selection", you gain powerful AI capabilities.

See my blog post [Follow up "vim + llm = 🔥": small things that awww](https://modernchaos.heytwist.com/p/follow-up-vim-llm-small-things-that-awww)

It works on VIM, NeoVIM, Emacs and even VSCode.

## Setting Things Up

### 1. Install Required Dependencies

Explore a myriad of models, both local and via robust APIs such as OpenAI and Together.

- [LLM-CLI](https://github.com/simonw/llm): A robust CLI tool and Python library for interfacing with LLMs, catering to both remote APIs and local installations.

For those willing to try large open-source models, consider adding [llm-together](https://github.com/wearedevx/llm-together).

- [Ollama](ollama.ai/): A straightforward approach to working with Llama 2 and other open-source language models on a local setup.

Note: It's advisable to start with Mistral 7B OpenOrca unless you're equipped to handle more resource-intensive models.

### 2. Update your $PATH

To efficiently call upon `lm` (representing llm) or `oll` (representing ollama) from your terminal or editor, integrate the main directory of this project into your $PATH.

Incorporate the following line into your `.zshrc` or `.bashrc`:

```bash
export PATH=$PATH:<path-to-the-project-directory>
```

### 3. Experiment in Your Terminal

Engage with the wrappers directly:

```bash
# Quick translation to French:
lm translate/french "Hello there! How are you today?"

# For a multi-line input, use Ctrl-D post entry to initiate the process:
echo "$(cat)" | llm translate/french
```

### 4. Integration with VIM, NeoVIM, Emacs & VSCode

The text you select serves as the context for the LLM's prompts, which in turn, will be replaced by the LLM's output.

#### Procedures for Vim, NeoVIM, Emacs:

1. Initiate a region selection in visual mode.
2. Transition to the command-line mode with `:` followed by `!`.
3. Enter `lm [prompt-name]` to activate llm-cli or `oll [prompt-name]` to call ollama.

Examples for clarity:

```bash
lm -h # Displays available prompts
oll -h # Likewise
lm code/fill # Engage llm to utilize the 'code/fill' prompt
oll translate/french # Translation to French using Ollama CLI
```

### 5. Customize with Your Prompts

Add your own bash scripts or directories under the `prompts` folder, and they'll be integrated into the prompt list.

Feel free to contribute your own prompts to this repository. I'll be happy to add new ones.

## More Experiments

We share our experiments and our journey through our newsletter (Modern Chaos)[https://modernchaos.heytwist.com/]

Modern chaos is a newsletter exploring tech and AI through the journey of a dev agency shifting from services to product design. We share our notes, analysis and experiments.

(Subscribe)[https://modernchaos.heytwist.com/]
