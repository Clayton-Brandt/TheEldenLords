from fastapi import FastAPI


from bosses import router as bosses_router
from lore import router as lore_router
from weaknesses import router as weaknesses_router
from resistances import router as resistances_router
from rewards import router as rewards_router
from stats import router as stats_router
from help_links import router as help_links_router
from prerequisites import router as prerequisites_router
from completion import router as completion_router

app = FastAPI(title="Elden Ring Boss API")


app.include_router(bosses_router)
app.include_router(lore_router)
app.include_router(weaknesses_router)
app.include_router(resistances_router)
app.include_router(rewards_router)
app.include_router(stats_router)
app.include_router(help_links_router)
app.include_router(prerequisites_router)
app.include_router(completion_router)


@app.get("/")
def root():
    return {"message": "Elden Ring Boss API is running"}
