import sys

from lib.context import Context
from lib.file import File
from lib.history import History
from lib.ollama import Ollama
from lib.terminal import Terminal


def main() -> None:
    data_path: str = '../../data'

    output: File = File(f'{data_path}/output.md')
    model: File = File(f'{data_path}/model.txt')

    history: History = History(
        file=File(f'{data_path}/active_conversation/show_conversation.md'),
        model=model.read()
    )
    context: Context = Context(path=f'{data_path}/active_conversation/context.json')
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