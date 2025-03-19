from fastapi import APIRouter, HTTPException, Depends

from sqlalchemy.orm import Session

from typing import List

from ..models.pizza import Pizza, PizzaCreateDTO, PizzaModel

from ..db import get_db

router = APIRouter()

@router.get("/pizzas", response_model=List[Pizza])
def get_pizzas(db: Session = Depends(get_db)):
    """
    Récupère la liste des pizzas
    """
    return db.query(PizzaModel).all()


@router.get("/pizzas/{pizza_id}",response_model=Pizza)
def get_pizza(pizza_id: int, db: Session = Depends(get_db)):
    """
    Récupère une pizza par son id
    """
    pizza = db.query(PizzaModel).filter(PizzaModel.id == pizza_id).first()
    if not pizza:
        raise HTTPException(status_code=404, detail="Pizza not found")
    return pizza


@router.post("/pizzas", response_model=Pizza, status_code=201)
def create_pizza(pizza: PizzaCreateDTO, db: Session = Depends(get_db)):
    """
    Créé une nouvelle pizza
    """
    existing_pizza = db.query(PizzaModel).filter(
        PizzaModel.name == pizza.name).first()
    if existing_pizza:
        raise HTTPException(status_code=400, detail="Pizza already exists")
    new_pizza = PizzaModel(**pizza.model_dump())
    db.add(new_pizza)
    db.commit()
    db.refresh(new_pizza)
    return new_pizza


@router.put("/pizzas/{pizza_id}", response_model=Pizza)
def update_pizza(pizza_id: int, updated_pizza: Pizza, db: Session = Depends(get_db)):
    """
    Met à jour une pizza sélectionnée selon son id
    """
    pizza = db.query(PizzaModel).filter(PizzaModel.id == pizza_id).first()
    if not pizza:
        raise HTTPException(status_code=404, detail="Pizza not found")
    for key, value in updated_pizza.model_dump().items():
        setattr(pizza, key, value)
    db.commit()
    db.refresh(pizza)
    return pizza


@router.delete("/pizzas/{pizza_id}", status_code=204)
def delete_pizza(pizza_id: int, db: Session = Depends(get_db)):
    """
    Supprime une pizza sélectionnée selon son id
    """
    pizza = db.query(PizzaModel).filter(PizzaModel.id == pizza_id).first()
    if not pizza:
        raise HTTPException(status_code=404, detail="Pizza not found")
    db.delete(pizza)
    db.commit()