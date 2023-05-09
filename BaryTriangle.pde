class BaryTriangle {
  float l1, l2, l3; // Barycentric coords of the inner point
  PVector Corner1, Corner2, Corner3; // Vectors to store the locations of the triangle vertices
  color c1, c2, c3; // Color value for the vertices

  BaryTriangle(float x1, float y1, float x2, float y2, float x3, float y3) {
    Corner1 = new PVector(x1, y1);
    Corner2 = new PVector(x2, y2);
    Corner3 = new PVector(x3, y3);

    c1 = color(200, 50, 50);
    c3 = color(50, 200, 50);
    c2 = color(50, 50, 200);

    // Initialize the inner point to be at the center
    l1 = 0.35487068;
    l2 = 0.13178484;
    l3 = 1 - l1 - l2;
  }

  float[] BaryToCart() {
    // convert the Barycentric coords to cartesian coords
    float[] CartCoords = new float[2];
    CartCoords[0] = l1*Corner1.x + l2*Corner2.x + l3*Corner3.x;
    CartCoords[1] = l1*Corner1.y + l2*Corner2.y + l3*Corner3.y;
    return CartCoords;
  }

  float[] CartToBary(float x, float y) {
    // convert input cartesian coords to Barycentric coords

    float x1, x2, x3, y1, y2, y3;
    x1 = Corner1.x;
    x2 = Corner2.x;
    x3 = Corner3.x;
    y1 = Corner1.y;
    y2 = Corner2.y;
    y3 = Corner3.y;

    float[] BaryCoords = new float[3];
    float den = (y2 - y3)*(x1 - x3) + (x3 - x2)*(y1 - y3);
    BaryCoords[0] = ((y2 - y3)*(x - x3) + (x3 - x2)*(y - y3))/den;
    BaryCoords[1] = ((y3 - y1)*(x - x3) + (x1 - x3)*(y - y3))/den;
    BaryCoords[2] = 1 - BaryCoords[0] - BaryCoords[1];
    return BaryCoords;
  }

  void UpdateInnerPoint(float x, float y) {
    float[] newCoords = CartToBary(x, y);
    l1 = newCoords[0];
    l2 = newCoords[1];
    l3 = newCoords[2];
  }

  void UpdateCorner1(float x, float y) {
    Corner1.set(x, y);
  }

  void UpdateCorner2(float x, float y) {
    Corner2.set(x, y);
  }

  void UpdateCorner3(float x, float y) {
    Corner3.set(x, y);
  }

  void show(float diameter) {
    float[] InnerCoords = BaryToCart();

    noStroke();

    // draw the vertices
    fill(c1);
    ellipse(Corner1.x, Corner1.y, diameter, diameter);

    fill(c2);
    ellipse(Corner2.x, Corner2.y, diameter, diameter);

    fill(c3);
    ellipse(Corner3.x, Corner3.y, diameter, diameter);

    // draw the inner point
    fill(255);
    ellipse(InnerCoords[0], InnerCoords[1], 8, 8);

    // draw the outer triangle
    noFill();
    stroke(255);
    strokeWeight(4);
    triangle(Corner1.x, Corner1.y, Corner2.x, Corner2.y, Corner3.x, Corner3.y);

    // draw the subtriangles
    strokeWeight(2);
    stroke(c1);
    fill(c1, 50);
    triangle(InnerCoords[0], InnerCoords[1], Corner2.x, Corner2.y, Corner3.x, Corner3.y);

    stroke(c2);
    fill(c2, 50);
    triangle(InnerCoords[0], InnerCoords[1], Corner1.x, Corner1.y, Corner3.x, Corner3.y);

    stroke(c3);
    fill(c3, 50);
    triangle(InnerCoords[0], InnerCoords[1], Corner1.x, Corner1.y, Corner2.x, Corner2.y);

    // Clean up the edges of the subtriangles
    stroke(255);
    line(InnerCoords[0], InnerCoords[1], Corner1.x, Corner1.y);
    line(InnerCoords[0], InnerCoords[1], Corner2.x, Corner2.y);
    line(InnerCoords[0], InnerCoords[1], Corner3.x, Corner3.y);
  }
}
