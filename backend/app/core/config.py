import os
from sqlalchemy import create_engine
from dotenv import load_dotenv

load_dotenv()  # Ensure this loads your .env file

DATABASE_URL = os.getenv("DATABASE_URL")

engine = create_engine(DATABASE_URL)  # Ensure it's correct
