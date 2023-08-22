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
  
  void show3D(float index,
              float windowHeight,
              float centerX, 
              float centerY, 
              float rectWidth, 
              float rectHeight, 
              float strokeAlpha) {
    // Ceiling
    rectMode(CORNER);
    stroke(#abcdef);
    rect(centerX, 0, rectWidth, (windowHeight - rectHeight) * 0.5);
    
    // Wall
    rectMode(CENTER);
    stroke(this.c);
    //fill(this.c);
    rect(centerX, centerY, rectWidth, rectHeight);
    
    // Floor
    rectMode(CORNER);
    stroke(155);
    rect(centerX, centerY + rectHeight * 0.5 , rectWidth, (windowHeight - rectHeight) * 0.5);
    
  }
}
