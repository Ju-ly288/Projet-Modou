import os

from sqlalchemy.ext.declarative import declarative_base

from sqlalchemy.orm import  sessionmaker
from sqlalchemy import create_engine, Column, Integer, String, Float

from pydantic import BaseModel

DB_URL = os.getenv('DATABASE_URL')

engine = create_engine(
    DB_URL
)

SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)
Base = declarative_base()

# Modèle de la table Pizza
class PizzaModel(Base):
    __tablename__ = "pizzas"
    id = Column(Integer, primary_key=True, index=True, autoincrement=True)
    name = Column(String, nullable=False, index=True, unique=True)
    ingredients = Column(String, nullable=False)
    price = Column(Float, nullable=False)

class PizzaBase(BaseModel):
    name: str
    ingredients: str
    price: float

class PizzaCreateDTO(PizzaBase):
    """
    Pizza sans id (utile pour la création)
    """
    pass

class Pizza(PizzaBase):
    """
    Pizza avec id
    """
    id: int

    class Config:
        from_attributes = True


Base.metadata.create_all(engine)
