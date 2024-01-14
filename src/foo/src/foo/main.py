from dataclasses import dataclass


__all__ = ["A"]


@dataclass
class A:
    """
    This is an example of a documented class.

    [.x][]

    Attributes:
        x: An example number.
        y: An example string.
    """

    x: int
    y: str = "Hello world"
