import json
import os


class Context:
    _CONTEXT_FILE = '../../data/context.json'

    @property
    def conversation(self) -> list[int]:
        """Wczytuje kontekst rozmowy z pliku."""
        if not self._is_file_empty(self._CONTEXT_FILE):
            with open(self._CONTEXT_FILE, "r", encoding="utf-8") as f:
                return json.load(f)
        return []

    @conversation.setter
    def conversation(self, new_conversation: list[int]):
        """Zapisuje kontekst rozmowy do pliku."""
        with open(self._CONTEXT_FILE, "w", encoding="utf-8") as f:
            json.dump(new_conversation, f, ensure_ascii=False)

    @staticmethod
    def _is_file_empty(filename: str) -> bool:
        if not os.path.exists(filename):
            return True

        with open(filename, "r", encoding="utf-8") as f:
            return len(f.read().strip()) == 0
