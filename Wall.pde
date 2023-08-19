class Wall {
  PVector P1, P2;
  String name;
  color c;

  Wall(float x1, float y1, float x2, float y2) {
    this.P1 = new PVector(x1, y1);
    this.P2 = new PVector(x2, y2);
  }
  
  Wall(float x1, float y1, float x2, float y2, String name, color c) {
    this.P1 = new PVector(x1, y1);
    this.P2 = new PVector(x2, y2);
    this.name = name;
    this.c = c;
  }

  void show2D() {
    stroke(255, 0, 0);
    line(P1.x, P1.y, P2.x, P2.y);
  }
  
  void show3D(float centerX, float centerY, float rectWidth, float rectHeight, float strokeAlpha) {
    rectMode(CENTER);
    stroke(this.c, strokeAlpha);
    fill(this.c);
    rect(centerX, centerY, rectWidth, rectHeight);
  }
}
