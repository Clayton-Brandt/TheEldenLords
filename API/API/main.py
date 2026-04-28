from fastapi import FastAPI
from bosses import router as bosses_router
from completion import router as completion_router

app = FastAPI()

app.include_router(bosses_router)
app.include_router(completion_router)
