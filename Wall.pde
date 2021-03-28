class Wall {

  PVector P1, P2;

  Wall(float x, float y, float x1, float y1) {
    this.P1=new PVector(x, y);
    this.P2=new PVector(x1, y1);
  }

  void show() {
    stroke(255, 0, 0);
    line(P1.x, P1.y, P2.x, P2.y);
  }
}
