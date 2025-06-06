from qpoint3df import *
from PyQt6.QtCore import *
from PyQt6.QtGui import *
from PyQt6.QtWidgets import *

class Triangle:
    def __init__(self, p1_: QPoint3DF, p2_: QPoint3DF, p3_: QPoint3DF, slope_: float, aspect_: float):
        self.vertices = QPolygonF()
        self.p1 = p1_
        self.p2 = p2_
        self.p3 = p3_
        self.slope = slope_
        self.aspect = aspect_