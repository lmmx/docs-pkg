from pydantic import BaseModel

__all__ = ["A"]


class A(BaseModel):
    """
    This is an example of a documented Pydantic model.
    """

    x: int
    y: str = "Hello world"
