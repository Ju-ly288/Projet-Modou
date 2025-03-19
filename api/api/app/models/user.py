import os

from sqlalchemy.ext.declarative import declarative_base

from sqlalchemy.orm import sessionmaker
from sqlalchemy import create_engine, Column, Integer, String, Float

from pydantic import BaseModel

DB_URL = os.getenv('DATABASE_URL')

print("DB_URL:", DB_URL)  # Debug

engine = create_engine(
    DB_URL
)

SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)
Base = declarative_base()

# Modèle de la table User


class UserModel(Base):
    __tablename__ = "users"
    id = Column(Integer, primary_key=True, index=True, autoincrement=True)
    email = Column(String, nullable=False, index=True, unique=True)
    password = Column(String, nullable=False)
    username = Column(String, nullable=False, unique=True)


class UserBase(BaseModel):
    email: str
    password: str
    username: str


class UserCreateDTO(UserBase):
    username: str


class UserSignInDTO(BaseModel):
    email: str
    password: str


class User(UserBase):
    """
    User avec id
    """
    id: int

    class Config:
        from_attributes = True


Base.metadata.create_all(engine)
