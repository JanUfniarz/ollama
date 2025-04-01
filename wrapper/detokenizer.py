from lib.io import IO
from lib.ollama import Ollama
from lib.context import Context


def main() -> None:
    io: IO = IO(
        output_path='../data/history/history.md',
        input_path='../data/model.txt'
    )
    context: Context = Context(path='../data/context.json')
    ollama: Ollama = Ollama(port=11434, model=io.input)

    output: str = ollama.detokenize(context.conversation)

    io.save_output(output)


if __name__ == '__main__':
    main()