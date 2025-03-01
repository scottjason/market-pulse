from fastapi import FastAPI
from contextlib import asynccontextmanager
import subprocess
from app.api.v1.endpoints import users


def run_migrations():
    print("Running Alembic migrations...")
    subprocess.run(["alembic", "upgrade", "head"], check=True)


@asynccontextmanager
async def lifespan(app: FastAPI):
    run_migrations()
    yield


app = FastAPI(lifespan=lifespan)

app.include_router(users.router, prefix="/users", tags=["users"])
