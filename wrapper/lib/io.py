class IO:
    def __init__(self, output_path: str, model_path: str):
        self._output_path: str = output_path
        self._model_path: str = model_path

    @property
    def model_name(self) -> str:
        with open(self._model_path, 'r') as file:
            return file.read().strip()

    def save_output(self, output) -> None:
        with open(self._output_path, "w", encoding="utf-8") as f:
            f.write(output)