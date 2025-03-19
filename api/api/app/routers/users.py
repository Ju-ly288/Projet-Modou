from fastapi import APIRouter, HTTPException, Depends
from sqlalchemy.orm import Session
from typing import List
from passlib.context import CryptContext
import jwt
from datetime import datetime, timedelta

from ..models.user import User, UserCreateDTO, UserModel, UserSignInDTO
from ..db import get_db

router = APIRouter()

# Initialisation de CryptContext pour le hachage du mot de passe
pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")

# Secret key pour la signature du JWT (doit être gardée secrète)
SECRET_KEY = "your_secret_key"
ALGORITHM = "HS256"

# Fonction pour hacher un mot de passe
def get_password_hash(password: str) -> str:
    return pwd_context.hash(password)

# Fonction pour vérifier le mot de passe
def verify_password(plain_password, hashed_password):
    return pwd_context.verify(plain_password, hashed_password)

# Fonction pour créer un JWT
def create_access_token(data: dict, expires_delta: timedelta = timedelta(hours=1)):
    to_encode = data.copy()
    expire = datetime.utcnow() + expires_delta
    to_encode.update({"exp": expire})
    encoded_jwt = jwt.encode(to_encode, SECRET_KEY, algorithm=ALGORITHM)
    return encoded_jwt

@router.post("/users/sign-in", response_model=str, status_code=201)
def sign_in_user(user: UserSignInDTO, db: Session = Depends(get_db)):
    """
    Connecter un user
    """
    existing_user = db.query(UserModel).filter(UserModel.email == user.email).first()
    if not existing_user or not verify_password(user.password, existing_user.password):
        raise HTTPException(status_code=401, detail="Incorrect email or password")
    
    # Générer un token JWT
    token = create_access_token(data={"sub": user.email})
    return token

@router.get("/users", response_model=List[User])
def get_users(db: Session = Depends(get_db)):
    """
    Récupère la liste des users
    """
    return db.query(UserModel).all()

@router.get("/users/{user_id}", response_model=User)
def get_user(user_id: int, db: Session = Depends(get_db)):
    """
    Récupère un user par son id
    """
    user = db.query(UserModel).filter(UserModel.id == user_id).first()
    if not user:
        raise HTTPException(status_code=404, detail="User not found")
    return user


@router.post("/users/sign-up", response_model=User, status_code=201)
def sign_up_user(user: UserCreateDTO, db: Session = Depends(get_db)):
    """
    Inscrire un nouveau user avec hachage du mot de passe
    """
    existing_user = db.query(UserModel).filter(UserModel.email == user.email).first()
    if existing_user:
        raise HTTPException(status_code=400, detail="User already exists")
    
    user_data = user.model_dump()
    user_data["password"] = get_password_hash(user.password)
    
    new_user = UserModel(**user_data)
    db.add(new_user)
    db.commit()
    db.refresh(new_user)
    return new_user

@router.put("/users/{user_id}", response_model=User)
def update_user(user_id: int, updated_user: User, db: Session = Depends(get_db)):
    """
    Met à jour un user sélectionné selon son id
    """
    user = db.query(UserModel).filter(UserModel.id == user_id).first()
    if not user:
        raise HTTPException(status_code=404, detail="User not found")
    
    for key, value in updated_user.model_dump().items():
        if key == "password":
            value = get_password_hash(value)  # Hachage du mot de passe mis à jour
        setattr(user, key, value)
    
    db.commit()
    db.refresh(user)
    return user

@router.delete("/users/{user_id}", status_code=204)
def delete_user(user_id: int, db: Session = Depends(get_db)):
    """
    Supprime un user sélectionné selon son id
    """
    user = db.query(UserModel).filter(UserModel.id == user_id).first()
    if not user:
        raise HTTPException(status_code=404, detail="User not found")
    db.delete(user)
    db.commit()