def test_create_user():
    from app.schemas.user import UserCreate

    user = UserCreate(email="test@example.com")
    assert user.email == "test@example.com"
