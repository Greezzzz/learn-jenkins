from fastapi import APIRouter, FastAPI

app = FastAPI()
router = APIRouter()


@app.get("/health")
def health():
    return {"status": "Ok"}
