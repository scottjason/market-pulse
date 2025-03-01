from sqlalchemy import Column, Integer, String
from app.db.base import Base  # Safe to import after fixing circular issue


class User(Base):
    __tablename__ = "users"

    id = Column(Integer, primary_key=True, index=True)
    email = Column(String, unique=True, index=True, nullable=False)
