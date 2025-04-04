import json
from typing import Any

from requests import Response

class Terminal:
    def __init__(self):
        self._lines_printed: int = 0

    def stream_response(self, response: Response) -> tuple[str, Any|None]:
        full_response = ""
        context = None

        for line in response.iter_lines():
            json_data = json.loads(line.decode("utf-8"))
            if "response" in json_data:
                text = json_data["response"]
                print(text, end='', flush=True)
                full_response += text
                self._lines_printed += text.count("\n")

            if "context" in json_data:
                context = json_data["context"]

        return full_response, context

    def clear(self) -> None:
        print('\n')
        self._lines_printed += 2

        for _ in range(self._lines_printed):
            print("\033[F\033[K", end="")

        print(' ')