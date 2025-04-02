class History:
    def __init__(self, file, model: str):
        self.model: str = model
        self.file = file

    def save_prompt(self, prompt: str) -> None:
        self.file.append(f'\n---\nYou:\n{prompt}')

    def save_response(self, response: str) -> None:
        self.file.append(f'\n---\n{self.model}:\n{response}')
