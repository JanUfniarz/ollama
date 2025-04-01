from requests import Response, post


class Ollama:
    def __init__(self, port: int, model: str):
        self.port: int = port
        self.model: str = model

    def __call__(self,prompt: str, conversation: list[int] | None = None) -> Response:
        url = f"http://localhost:{self.port}/api/generate"
        data = dict(
            model=self.model,
            prompt=prompt,
            stream=True
        )

        if conversation:
            data["context"] = conversation

        return post(url, json=data, stream=True)