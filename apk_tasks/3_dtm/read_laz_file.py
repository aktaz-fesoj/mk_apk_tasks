from pathlib import Path

from qpoint3df import QPoint3DF

def load_file(file_path, width, height):
    """
    Loads .las/.laz LiDAR data using laspy and lazrs and rescales it for display.
    Can also load .txt data

    Args:
        file_path (str): Path to the .laz file
        width (int): Canvas width for scaling
        height (int): Canvas height for scaling

    Raises:
        ImportError: If required modules laspy for .las; laspy and lazrs for .laz files arent installed but required

    Returns:
        List of QPoint3DF objects (scaled)
    """
    extension = Path(file_path).suffix
    if extension in [".las", ".laz"]:
        try:
            import laspy
        except ImportError:
            raise ImportError("Required library 'laspy' is not installed. Either install it or try loading a .txt file.")
        if extension in [".laz"]:
            try:
                import lazrs
            except ImportError:
                raise ImportError("Required laspy binding 'lazrs' is not installed. Either install it or try loading a .txt file.")
        
        laz = laspy.read(file_path)
        xs = laz.x
        ys = laz.y
        zs = laz.z

        min_x, max_x = xs.min(), xs.max()
        min_y, max_y = ys.min(), ys.max()
        
    elif extension in [".txt"]:
        with open(file_path, "r") as f:
            rows = f.readlines()
            f.close()
        xs, ys, zs = [], [], []
        for row in rows:
            vals = row.split()
            xs.append(float(vals[0]))
            ys.append(float(vals[1]))
            zs.append(float(vals[2]))
        min_x, max_x = min(xs), max(xs)
        min_y, max_y = min(ys), max(ys)        

    # Compute scale factor
    scale_x = width / (max_x - min_x)
    scale_y = height / (max_y - min_y)
    scale_factor = min(scale_x, scale_y)

    # Transform and scale coordinates
    points = []
    for x, y, z in zip(xs, ys, zs):
        x_scaled = (x - min_x) * scale_factor
        y_scaled = (max_y - y) * scale_factor  # Pyqt Canvas has inverted Y axis
        points.append(QPoint3DF(x_scaled, y_scaled, z))
    
    return points