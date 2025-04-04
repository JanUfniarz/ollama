import sys

from lib.file import File
from lib.ollama import Ollama
from lib.terminal import Terminal

File.DATA_PATH = '../../data/'

output = File('output.md')
model = File('model.txt')
context = File('active_conversation/context.json', json_=True)
system_prompts = File('system_prompts.json', json_=True)
history = File('active_conversation/show_conversation.md')

ollama: Ollama = Ollama(port=11434, model=model.read())
terminal: Terminal = Terminal()

def attach_sys_prompts(user_input):
    if not context.read():
        return '\n'.join(system_prompts.read()) + '\nUser: ' + user_input
    return user_input

def main() -> None:
    user_input: str = ' '.join(sys.argv[1:])

    prompt = attach_sys_prompts(user_input)

    response = ollama(prompt, context.read())
    text, tokens = terminal.stream_response(response)

    if tokens:
        context.write(tokens)

    terminal.clear()
    output.write(text)

    history.append(f'\n---\nYou:\n{user_input}\n---\n{model.read()}:\n{text}\n')



if __name__ == '__main__':
    main()