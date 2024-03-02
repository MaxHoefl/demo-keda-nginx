import uvicorn
from fastapi import FastAPI

app = FastAPI()


@app.get("/hello")
def read_random_slice():
    return {"hello": "world"}


if __name__ == "__main__":
    uvicorn.run("main:app", port=8080, host="0.0.0.0")