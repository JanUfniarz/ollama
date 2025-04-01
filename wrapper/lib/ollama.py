from requests import Response, post


class Ollama:
    def __init__(self, port: int, model: str):
        self.path: str = f"http://localhost:{port}/api"
        self.model: str = model

    def __call__(self, prompt: str, conversation: list[int] | None = None) -> Response:
        data = dict(
            model=self.model,
            prompt=prompt,
            stream=True
        )

        if conversation:
            data["context"] = conversation

        return post(self.path + "/generate", json=data, stream=True)

    def detokenize(self, conversation: list[int]) -> str:
        return post(
            self.path + "/detokenize",
            json=dict(
                model=self.model,
                tokens=conversation
            )
        ).json()["text"]