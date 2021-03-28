class Ray { //<>// //<>// //<>//

  PVector start, dir, end;
  float oldAngle;

  Ray(PVector start, float angle) {
    this.start = start;
    this.dir = new PVector(this.start.x+cos(radians(angle)), this.start.y+sin(radians(angle)));
    this.end = this. dir.copy().mult(20);
  }

  void update(float mx, float my) {

    this.start.x = mx;
    this.start.y = my;
    this.end.x = mx + this.dir.x ;
    this.end.y = my + this.dir.y ;
  }
  
  void updateDir(float angle){
    this.dir.rotate(radians(angle));
  }


  float getMag(PVector point) { 
    return new PVector(point.x-this.start.x, point.y-this.start.y).mag();
  }

  void show(PVector intersect) {
    stroke(255);
    line(this.start.x, this.start.y, intersect.x, intersect.y);
  }

  PVector cast(Wall w) {

    float x1=start.x;
    float y1=start.y;
    float x2=end.x;
    float y2=end.y;
    float x3=w.P1.x;
    float y3=w.P1.y;
    float x4=w.P2.x;
    float y4=w.P2.y;

    float denominator=(x1-x2)*(y3-y4)-(y1-y2)*(x3-x4);

    if (denominator==0) 
      return null;

    float t=((x1-x3)*(y3-y4)-(y1-y3)*(x3-x4))/denominator;
    float u=-(((x1-x2)*(y1-y3)-(y1-y2)*(x1-x3))/denominator);

    if (t>=0 && u<=1 && u>=0 ) 
      return new PVector(x1+t*(x2-x1), y1+t*(y2-y1));

    return null;
  }
}  
