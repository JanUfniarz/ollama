class IO:
    def __init__(self, output_path: str|None = None, input_path: str|None = None):
        self._output_path: str|None = output_path
        self._input_path: str|None = input_path

    @property
    def input(self) -> str|None:
        if not self._input_path:
            return None

        with open(self._input_path, 'r') as file:
            return file.read().strip()

    def save_output(self, output) -> None:
        if not self._output_path:
            return

        with open(self._output_path, "w", encoding="utf-8") as f:
            f.write(output)