import sys
import time

from lib.context import Context
from lib.ollama import Ollama
from lib.terminal import Terminal

def main() -> None:
    user_input = ' '.join(sys.argv[1:])

    context: Context = Context()
    ollama: Ollama = Ollama(port=11434, model="gemma3")
    terminal: Terminal = Terminal()

    response = ollama(user_input, context.conversation)
    output = terminal.stream_response(response, context)

    time.sleep(0.5)
    terminal.clear()

    save_output(output)

def save_output(output) -> None:
    with open('../data/output.md', "w", encoding="utf-8") as f:
        f.write(output)

if __name__ == '__main__':
    main()