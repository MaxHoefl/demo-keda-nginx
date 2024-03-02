import uvicorn
from fastapi import FastAPI

app = FastAPI(root_path="/api")


@app.get("/health")
def health():
    return {"health": "ok"}


if __name__ == "__main__":
    uvicorn.run("main:app", port=8080, host="0.0.0.0")