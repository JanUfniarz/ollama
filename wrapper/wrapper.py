import sys

from lib.context import Context
from lib.ollama import Ollama
from lib.terminal import Terminal
from lib.io import IO


def main() -> None:
    io: IO = IO(
        output_path='../data/output.md',
        input_path='../data/model.txt'
    )
    context: Context = Context(path='../data/context.json')
    ollama: Ollama = Ollama(port=11434, model=io.input)
    terminal: Terminal = Terminal()

    user_input: str = ' '.join(sys.argv[1:])

    response = ollama(user_input, context.conversation)
    output: str = terminal.stream_response(response, context)

    terminal.clear()
    io.save_output(output)


if __name__ == '__main__':
    main()