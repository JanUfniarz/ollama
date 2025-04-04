import sys

from lib.file import File
from lib.ollama import Ollama
from lib.terminal import Terminal


def main() -> None:
    File.DATA_PATH = '../../data/'

    output = File('output.md')
    model = File('model.txt')
    context = File('active_conversation/context.json', json_=True)
    history = File('active_conversation/show_conversation.md')

    ollama: Ollama = Ollama(port=11434, model=model.read())
    terminal: Terminal = Terminal()

    prompt: str = ' '.join(sys.argv[1:])

    response = ollama(prompt, context.read())
    text, tokens = terminal.stream_response(response)

    if tokens:
        context.write(tokens)

    terminal.clear()
    output.write(text)

    history.append(f'\n---\nYou:\n{prompt}\n---\n{model.read()}:\n{text}\n')



if __name__ == '__main__':
    main()