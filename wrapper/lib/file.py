class File:
    def __init__(self, path: str):
        self.path: str = path

    def read(self) -> str:
        with open(self.path, 'r') as file:
            return file.read().strip()

    def write(self, text: str):
        with open(self.path, "w", encoding="utf-8") as f:
            f.write(text)

    def append(self, text: str):
        with open(self.path, "a", encoding="utf-8") as f:
            f.write(text)