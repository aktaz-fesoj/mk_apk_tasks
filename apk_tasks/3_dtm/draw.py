from PyQt6.QtCore import *
from PyQt6.QtGui import *
from PyQt6.QtWidgets import *
from qpoint3df import *
from edge import *
from triangle import *
from algorithms import *
from random import random
from math import pi


class Draw(QWidget):

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.view_points = True
        self.view_dt = True
        self.view_contour_lines = True
        self.view_slope = True
        self.view_aspect = True

        self.points = []
        self.dt = []
        self.contour_lines = []
        self.triangles = []

        self.zmin = 150
        self.zmax = 1500
        self.dz = 50

        self.aspect_colors = [
            QColor("#fa0100"),
            QColor("#ffa401"),
            QColor("#fdfe01"),
            QColor("#00fe03"),
            QColor("#00ffff"),
            QColor("#00a5fe"),
            QColor("#0000fd"),
            QColor("#fc00f9"),
        ]

    def pointsInput(self, points):
        self.points = points

    def paintEvent(self, e: QPaintEvent):
        qp = QPainter(self)

        if self.view_slope:
            qp.setPen(Qt.GlobalColor.black)
            for t in self.triangles:
                p1, p2, p3 = t.p1, t.p2, t.p3
                slope = t.slope
                color = int(255 - ((255 / (pi/2)) * slope))
                qp.setBrush(QColor(color, color, color))

                poly = QPolygonF([p1, p2, p3])
                qp.drawPolygon(poly)

        if self.view_aspect:
            qp.setPen(Qt.GlobalColor.black)
            for t in self.triangles:
                p1, p2, p3 = t.p1, t.p2, t.p3
                aspect = t.aspect
                color = self.getAspectColor(aspect)
                qp.setBrush(color)

                poly = QPolygonF([p1, p2, p3])
                qp.drawPolygon(poly)

        if self.view_points:
            qp.setPen(Qt.GlobalColor.black)
            qp.setBrush(Qt.GlobalColor.yellow)
            r = 10
            for p in self.points:
                qp.drawEllipse(int(p.x() - r), int(p.y() - r), 2 * r, 2 * r)

        if self.view_dt:
            qp.setPen(Qt.GlobalColor.gray)
            for edge in self.dt:
                qp.drawLine(edge.start, edge.end)

        if self.view_contour_lines:
            qp.setPen(Qt.GlobalColor.green)
            for edge in self.contour_lines:
                qp.drawLine(edge.start, edge.end)

    def clearData(self):
        self.dt.clear()
        self.contour_lines.clear()
        self.triangles.clear()
        self.repaint()

    def clearAll(self):
        self.points.clear()
        self.dt.clear()
        self.contour_lines.clear()
        self.triangles.clear()
        self.repaint()

    def getAspectColor(self, aspect):
        aspect_deg = aspect * 180 / pi
        index = int((aspect_deg + 22.5 )// 45) % 8 # +22.5 to properly center intervals
        return self.aspect_colors[index]