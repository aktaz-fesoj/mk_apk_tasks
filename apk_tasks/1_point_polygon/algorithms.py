from PyQt6.QtCore import *
from PyQt6.QtGui import *
from PyQt6.QtWidgets import *

from math import sqrt, acos, pi

class Algorithms:
    def __init__(self):
        pass
    
    def ray_crossing(self, q: QPointF, pol: QPolygonF):
        # analyze point and polygon position using ray crossing algorithm
        if self.point_vertex(q, pol):
            return "vertex"
        k = 0 #amount of intersection points
        n = len(pol)
        for i in range(n): #process all points
            
            #Get i-th point
            xir = pol[i].x() - q.x()
            yir = pol[i].y() - q.y()
            
            #Get (i+1)st point
            xi1r = pol[(i+1)%n].x() - q.x()
            yi1r = pol[(i+1)%n].y() - q.y()
            
            #Test criterion
            if (yi1r > 0) and (yir <= 0) or (yi1r <= 0) and (yir > 0):
                # We found a suitable segment, now we compute intersection
                xm = (xi1r*yir - xir*yi1r)/(yi1r-yir)
                if xm == 0 and self.inside_bounding(q, pol[i], pol[(i+1)%n]):
                    return "edge"
                elif xm > 0:
                    # if m is in the right half-plane; increase number of k 
                    k = k + 1
        return "inside" if k%2 == 1 else "outside"
    
    def inside_bounding(self, q: QPointF, point1: QPointF, point2: QPointF):
        # analyze whether point is inside bounding box of an edge
        bounding_x = [min(point1.x(), point2.x()), max(point1.x(), point2.x())]
        bounding_y = [min(point1.y(), point2.y()), max(point1.y(), point2.y())]
        x_statement = bounding_x[0] <= q.x() <= bounding_x[1]
        y_statement = bounding_y[0] <= q.y() <= bounding_y[1]
        return x_statement and y_statement
    
    def winding_number(self, q: QPointF, polygon: QPolygonF):
        # analyze point and polygon position using winding number algorithm
        # returns "inside" / "outside" / "edge"
        if self.point_vertex(q, polygon):
            return "vertex"
        cum_angle_meas = 0
        tolerance = 0.01
        n = len(polygon)
        for i in range(len(polygon)):
            point1 = polygon[i]
            point2 = polygon[(i+1)%n]

            vector1 = [point1.x() - q.x(), point1.y() - q.y()]
            vector2 = [point2.x() - q.x(), point2.y() - q.y()]

            # A * B = ∥A∥∥B∥cos(θ) ==> cos(θ) = (A * B) / (∥A∥∥B∥)

            dot_product = vector1[0] * vector2[0] + vector1[1] * vector2[1]

            # normalize vectors
            norm1 = sqrt(vector1[0]**2 + vector1[1]**2)
            norm2 = sqrt(vector2[0]**2 + vector2[1]**2)
            angle = acos(round(dot_product / (norm1 * norm2), 10)) # get rid of small inaccuracies caused by floaters (acos requires numbers from range -1 to 1)
            
            cross_product = (point2.x() - point1.x()) * (q.y() - point1.y()) - (point2.y() - point1.y()) * (q.x() - point1.x()) # 2d cross product
            if cross_product == 0 and self.inside_bounding(q, point1, point2): # point is collinear with the edge and inside bouding box
                return "edge"
            if cross_product > 0: # point on the left side
                cum_angle_meas += angle
            else: # point on the right side or collinear (but then angle is 0)
                cum_angle_meas -= angle

        if abs(cum_angle_meas - 2 * pi) < tolerance:
            return "inside"
        return "outside"
    
    def minmaxbox(self, pol: QPolygonF):
        mmb = QPolygonF()

        #findVertices
        x_min = min(pol, key = lambda k: k.x()).x()
        x_max = max(pol, key = lambda k: k.x()).x()

        y_min = min(pol, key = lambda k: k.y()).y()
        y_max = max(pol, key = lambda k: k.y()).y()

        v0 = QPointF(x_min, y_min)
        v1 = QPointF(x_max, y_min)
        v2 = QPointF(x_max, y_max)
        v3 = QPointF(x_min, y_max)

        mmb.append(v0)
        mmb.append(v1)
        mmb.append(v2)
        mmb.append(v3)
        
        return mmb
    
    def point_inside_minmaxbox(self, q: QPointF, mmb: QPolygonF):
        """
        #  Tests if a point is inside minmaxbox polygon using its min and max coordinates
        #  Returns True (inside) or False (outside)
        """
        if q.x() >= mmb[0].x() and q.x() <= mmb[2].x() and q.y() >= mmb[0].y() and q.y() <= mmb[2].y():
            return True
        else:
            return False
        
    def select_suspicious_polygons(self, q: QPointF, list_of_polygons):
        """
        #  Tests if a point is inside minmaxbox of each polygon from given list of polygons using its min and max coordinates
        #  Returns list of polygons whose minmax boxes have the point inside
        """
        suspicious_polygons = []
        #searching for potential polygons (testing if the point is inside the minmax box of each polygon)
        for pol in list_of_polygons:
            mmb = self.minmaxbox(pol)
            sus = self.point_inside_minmaxbox(q,mmb)
            if sus:
                suspicious_polygons.append(pol) #adds suspicious polygon to the list of suspicious polygons
        return suspicious_polygons
    
    def point_vertex(self, q: QPointF, polygon: QPointF):
        """
        Anallyze whether the input point is identical to one of polygons vertices
        """
        for point in polygon:
            if q.x() == point.x() and q.y() == point.y():
                return True
        return False
