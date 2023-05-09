// Morgan Brooke-deBock
// November 15 2022
// Program to calculate and display the barycentric coordinates of a point inside a triangle

BaryTriangle B;
PImage BackgroundPlate;
PFont font;

void setup() {
  fullScreen();
  B = new BaryTriangle(557, 196, 1555, 843, 443, 963);
  BackgroundPlate = loadImage("bareframe.png");
}

void draw() {
  image(BackgroundPlate, 0, 0);
  B.show(16);
  DisplayBaryCoords();
  DisplayVertexLabels();
}

void DisplayVertexLabels() {
  fill(255);
  font = createFont("Courier", 48);
  textFont(font);
  text("A", B.Corner1.x - 30, B.Corner1.y - 30);
  text("B", B.Corner2.x + 30, B.Corner2.y + 10);
  text("C", B.Corner3.x - 45, B.Corner3.y + 45);
}

void DisplayBaryCoords() {
  fill(255);
  font = createFont("Courier", 36);
  textFont(font);
  fill(B.c1);
  text(B.l1, 1290 + 50, 167);
  fill(B.c2);
  text(B.l2, 1290 + 50, 315);
  fill(B.c3);
  text(B.l3, 1290 + 50, 465);
}

void keyPressed() {
  // Print out coordinate values to the console when a key is pressed
  if (key == ESC) {
    // if the escape key is pressed, kill the program.
    exit();
  } else {
    println("Corner1:", B.Corner1.x, B.Corner1.y);
    println("Corner2:", B.Corner2.x, B.Corner2.y);
    println("Corner3:", B.Corner3.x, B.Corner3.y);
    println("InnerPoint:", B.l1, B.l2, B.l3);
    //println(mouseX, mouseY);
  }
}

void mouseDragged() {
  // Function to allow points to be dragged across the canvas
  float[] CartCoords = B.BaryToCart();
  if (abs(mouseX - CartCoords[0]) < 16 && abs(mouseY - CartCoords[1]) < 16) {
    B.UpdateInnerPoint(mouseX, mouseY);
  } else if (abs(mouseX - B.Corner1.x) < 16 && abs(mouseY - B.Corner1.y) < 16) {
    B.UpdateCorner1(mouseX, mouseY);
  } else if (abs(mouseX - B.Corner2.x) < 16 && abs(mouseY - B.Corner2.y) < 16) {
    B.UpdateCorner2(mouseX, mouseY);
  } else if (abs(mouseX - B.Corner3.x) < 16 && abs(mouseY - B.Corner3.y) < 16) {
    B.UpdateCorner3(mouseX, mouseY);
  }
}
