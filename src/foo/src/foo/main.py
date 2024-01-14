from pydantic import BaseModel


__all__ = ["A"]


class A(BaseModel):
    """
    This is an example of a documented Pydantic model.

    [.x][foo.main.A.x]

    Attributes:
        x: An example number.
        y: An example string.
    """

    x: int
    y: str = "Hello world"
