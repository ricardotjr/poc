import os
import random
from fastapi import FastAPI, HTTPException
from prometheus_fastapi_instrumentator import Instrumentator


app = FastAPI()
instrumentator = Instrumentator().instrument(app)


@app.on_event("startup")
async def _startup():
    instrumentator.expose(app)


@app.get("/")
async def root():
    return {"status": True}


@app.get("/fibonacci")
def fibonacci():
    max = int(random.uniform(20, 50))
    numbers = [1]
    for number in range(1, max):
        if number > 1:
            for i in range(2, number):
                if (number % i) == 0:
                    break
            else:
                numbers.append(number)
    if random.uniform(1, 10) > float(os.getenv('APP_ERROR_RATE', '9.5')):
        raise HTTPException(status_code=404, detail="Not working")
    return {"start": 1, "end": max, "fibonacci": numbers}
