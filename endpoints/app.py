from fastapi import FastAPI
from pydantic import BaseModel
import uvicorn
import json

app = FastAPI()

tweather = {
    "temp": 10.0,
    "hum": 20.0,
    "pre": 44.0
}

class WeatherData(BaseModel):
    temp: float
    hum: float
    pre: float

@app.post("/posts")
async def create_weather_data(weather: WeatherData):
    print(weather)
    # weather_data = json.loads(weather)
    global tweather
    tweather = weather.model_dump()
    return tweather

@app.get("/")
async def root():
    print("Hello World")
    global tweather
    return tweather

if __name__ =="__main__":
    uvicorn.run(app)


