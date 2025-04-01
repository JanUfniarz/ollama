import json

from requests import Response

from wrapper.wrapper import Context


class Terminal:
    def __init__(self):
        self._lines_printed: int = 0

    def stream_response(self, response: Response, context: Context) -> str:
        full_response = ""

        for line in response.iter_lines():
            json_data = json.loads(line.decode("utf-8"))
            if "response" in json_data:
                text = json_data["response"]
                print(text, end='', flush=True)
                full_response += text
                self._lines_printed += text.count("\n")

            if "context" in json_data:
                context.conversation = json_data["context"]

        return full_response

    def clear(self) -> None:
        print('\n')
        self._lines_printed += 2

        for _ in range(self._lines_printed):
            print("\033[F\033[K", end="")

        print(' ')