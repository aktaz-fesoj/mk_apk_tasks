from PyQt6.QtCore import *
from PyQt6.QtGui import *
from PyQt6.QtWidgets import *
from math import *

from qpoint3df import *
from edge import *
from triangle import *

class Algorithms:
    def __init__(self):
        self.triangles = []
        pass

    def get2VectorsAngle(self, p1, p2, p3, p4):
        ux = p2.x() - p1.x()
        uy = p2.y() - p1.y()
        vx = p4.x() - p3.x()
        vy = p4.y() - p3.y()
        uv = ux * vx + uy * vy
        norm_u = sqrt(ux ** 2 + uy ** 2)
        norm_v = sqrt(vx ** 2 + vy ** 2)
        arg = uv / (norm_u * norm_v)
        arg = min(max(arg, -1), 1)
        return acos(arg)

    def analyzePointAndLinePosition(self, p, p1, p2):
        eps = 1.0e-6
        ux, uy = p2.x() - p1.x(), p2.y() - p1.y()
        vx, vy = p.x() - p1.x(), p.y() - p1.y()
        t = ux * vy - uy * vx
        if t > eps:
            return 1
        if t < -eps:
            return -1
        return 0

    def distance2D(self, p1, p2):
        dx = p2.x() - p1.x()
        dy = p2.y() - p1.y()
        return sqrt(dx ** 2 + dy ** 2)

    def getNearestPoint(self, q, points):
        min_dist = 1.0e16
        nearest_point = None
        for point in points:
            dist = self.distance2D(q, point)
            if q != point and dist < min_dist:
                min_dist = dist
                nearest_point = point
        return nearest_point

    def findDelaunayPoint(self, p1, p2, points):
        omega_max = 0
        delaunay_point = None
        for point in points:
            if point != p1 and point != p2:
                if self.analyzePointAndLinePosition(point, p1, p2) == 1:
                    omega = self.get2VectorsAngle(point, p1, point, p2)
                    if omega > omega_max:
                        omega_max = omega
                        delaunay_point = point
        return delaunay_point

    def delaunayTriangulation(self, points):
        dt = []
        ael = []
        p1 = min(points, key=lambda k: k.x())
        p2 = self.getNearestPoint(p1, points)
        e = Edge(p1, p2)
        es = Edge(p2, p1)
        ael.append(e)
        ael.append(es)
        while ael:
            e1 = ael.pop()
            e1s = e1.switch_orientation()
            p = self.findDelaunayPoint(e1s.start, e1s.end, points)
            if p:
                e2s = Edge(e1s.end, p)
                e3s = Edge(p, e1s.start)
                dt.extend([e1s, e2s, e3s])
                self.update_ael(e2s, ael)
                self.update_ael(e3s, ael)
        return dt

    def update_ael(self, e, ael):
        es = e.switch_orientation()
        if es in ael:
            ael.remove(es)
        else:
            ael.append(e)

    def contourPoint(self, p1, p2, z):
        xb = (p2.x() - p1.x()) / (p2.z - p1.z) * (z - p1.z) + p1.x()
        yb = (p2.y() - p1.y()) / (p2.z - p1.z) * (z - p1.z) + p1.y()
        return QPoint3DF(xb, yb, z)

    def createContourLines(self, dt, zmin, zmax, dz):
        contour_lines = []
        for z in range(zmin, zmax, dz):
            for i in range(0, len(dt), 3):
                p1 = dt[i].start
                p2 = dt[i+1].start
                p3 = dt[i+2].start
                dz1 = z - p1.z
                dz2 = z - p2.z
                dz3 = z - p3.z
                if dz1 == 0 and dz2 == 0 and dz3 == 0:
                    continue
                elif dz1 == 0 and dz2 == 0:
                    contour_lines.append(dt[i])
                elif dz2 == 0 and dz3 == 0:
                    contour_lines.append(dt[i+1])
                elif dz3 == 0 and dz1 == 0:
                    contour_lines.append(dt[i+2])
                elif dz1 * dz2 <= 0 and dz2 * dz3 <= 0:
                    a = self.contourPoint(p1, p2, z)
                    b = self.contourPoint(p2, p3, z)
                    contour_lines.append(Edge(a, b))
                elif dz2 * dz3 <= 0 and dz3 * dz1 <= 0:
                    a = self.contourPoint(p2, p3, z)
                    b = self.contourPoint(p3, p1, z)
                    contour_lines.append(Edge(a, b))
                elif dz3 * dz1 <= 0 and dz1 * dz2 <= 0:
                    a = self.contourPoint(p3, p1, z)
                    b = self.contourPoint(p1, p2, z)
                    contour_lines.append(Edge(a, b))
        return contour_lines

    def computeSlope(self, p1, p2, p3):
        ux, uy, uz = p3.x() - p2.x(), p3.y() - p2.y(), p3.z - p2.z
        vx, vy, vz = p1.x() - p2.x(), p1.y() - p2.y(), p1.z - p2.z
        nx = uy * vz - uz * vy
        ny = ux * vz - uz * vx
        nz = ux * vy - uy * vx
        n = sqrt(nx**2 + ny**2 + nz**2)
        return acos(nz / n)

    def convertDTToTriangles(self, dt, triangles):
        for i in range(0, len(dt), 3):
            p1 = dt[i].start
            p2 = dt[i+1].start
            p3 = dt[i+2].start
            triangle = Triangle(p1, p2, p3, 0, 0)
            triangles.append(triangle)
        return triangles

    def analyzeDTMSlope(self, dt, triangles):
        if not triangles:
            triangles = self.convertDTToTriangles(dt, triangles)
        for t in triangles:
            p1, p2, p3 = t.p1, t.p2, t.p3
            t.slope = self.computeSlope(p1, p2, p3)
        return triangles

    def computeAspect(self, p1, p2, p3):
        ux, uy, uz = p3.x() - p2.x(), p3.y() - p2.y(), p3.z - p2.z
        vx, vy, vz = p1.x() - p2.x(), p1.y() - p2.y(), p1.z - p2.z
        nx = uy * vz - uz * vy
        ny = ux * vz - uz * vx

        raw_aspect_rad = atan2(ny, nx)
        if raw_aspect_rad < 0:
            raw_aspect_rad += 2 * pi
        aspect = (2 * pi + pi / 2 - raw_aspect_rad) % (2 * pi) # QTCanvas has inverted Y-axis
        return aspect
    
    def analyzeDTMAspect(self, dt, triangles):
        if not triangles:
            triangles = self.convertDTToTriangles(dt, triangles)
        for t in triangles:
            p1, p2, p3 = t.p1, t.p2, t.p3
            t.aspect = self.computeAspect(p1, p2, p3)
        return triangles