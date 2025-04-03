import sys

from lib.context import Context
from lib.file import File
from lib.history import History
from lib.ollama import Ollama
from lib.terminal import Terminal


def main() -> None:
    File.DATA_PATH = '../../data/'

    output: File = File('output.md')
    model: File = File('model.txt')

    history: History = History(
        file=File('active_conversation/show_conversation.md'),
        model=model.read()
    )
    context: Context = Context(path=f'{File.DATA_PATH}/active_conversation/context.json')
    ollama: Ollama = Ollama(port=11434, model=model.read())
    terminal: Terminal = Terminal()

    user_input: str = ' '.join(sys.argv[1:])

    response = ollama(user_input, context.conversation)
    text: str = terminal.stream_response(response, context)

    terminal.clear()
    output.write(text)

    history.save_prompt(user_input)
    history.save_response(text)



if __name__ == '__main__':
    main()