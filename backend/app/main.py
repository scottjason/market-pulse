from fastapi import FastAPI
from contextlib import asynccontextmanager
import subprocess


# Run Alembic migrations on startup
def run_migrations():
    print("Running Alembic migrations...")
    subprocess.run(["alembic", "upgrade", "head"], check=True)


@asynccontextmanager
async def lifespan(app: FastAPI):
    run_migrations()  # Run migrations before startup
    yield  # This ensures the app continues running


# Create FastAPI app with lifespan
app = FastAPI(lifespan=lifespan)
