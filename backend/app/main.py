import subprocess
import logging

from fastapi import FastAPI
from app.api.v1.api import api_router

app = FastAPI()


# Run Alembic migrations automatically on startup
def run_migrations():
    try:
        logging.info("Running Alembic migrations...")
        subprocess.run(["alembic", "upgrade", "head"], check=True)
        logging.info("Migrations completed successfully.")
    except subprocess.CalledProcessError as e:
        logging.error(f"Error running migrations: {e}")


@app.on_event("startup")
async def startup_event():
    run_migrations()


# Include API routes
app.include_router(api_router)
