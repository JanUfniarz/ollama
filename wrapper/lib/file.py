class File:
    DATA_PATH: str

    def __init__(self, path: str):
        self.path: str = path

    def read(self) -> str:
        with open(self.DATA_PATH + self.path, 'r') as file:
            return file.read().strip()

    def write(self, text: str):
        with open(self.DATA_PATH + self.path, "w", encoding="utf-8") as f:
            f.write(text)

    def append(self, text: str):
        with open(self.DATA_PATH + self.path, "a", encoding="utf-8") as f:
            f.write(text)