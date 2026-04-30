from pydantic import BaseModel

class Boss(BaseModel):
    name: str
    location: str

class BossUpdate(BaseModel):
    name: str
    location: str
