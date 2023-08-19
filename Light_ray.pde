class Ray { //<>// //<>//

  PVector start, dir;

  Ray(PVector start, PVector dir) {
    this.start = start;
    this.dir = dir;
  }

  void updatePosition(float newX, float newY) {
    this.start.x = newX;
    this.start.y = newY;
  }

  void updateRotation(float angle) {
    this.dir.rotate(radians(angle));
    line(250, 250, 250 + this.dir.x * 20, 250 + this.dir.y * 20);
  }
  

  void show(PVector intersectionPoint) {
    stroke(255);
    line(this.start.x, this.start.y, intersectionPoint.x, intersectionPoint.y);
  }
}
