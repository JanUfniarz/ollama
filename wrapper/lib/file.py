import json
import os


class File:
    DATA_PATH: str = ''

    def __init__(self, path: str, json_: bool = False):
        self.path: str =  self.DATA_PATH + path
        if json_:
            self._default_content = []
            self._get = lambda file: json.load(file)
            self._save = lambda file, value: json.dump(value, file, ensure_ascii=False)
            self.append = self._append_json
        else:
            self._default_content = ''
            self._get = lambda file: file.read().strip()
            self._save = lambda file, value: file.write(value)
            self.append = lambda text: self._write_or_append('a', text)

        self.write = lambda text: self._write_or_append('w', text)

    def read(self) -> str|list:
        if not self._is_empty:
            with open(self.path, 'r') as file:
                return self._get(file)
        return self._default_content

    def _write_or_append(self, mode: str, text: str) -> None:
        with open(self.path, mode, encoding="utf-8") as file:
            self._save(file, text)

    def _append_json(self, value: list) -> None:
        content = self.read()
        content.append(value)
        self.write(content)

    @property
    def _is_empty(self) -> bool:
        if not os.path.exists(self.path):
            return True

        with open(self.path, "r", encoding="utf-8") as f:
            return len(f.read().strip()) == 0