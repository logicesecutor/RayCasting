class LightPoint { //<>// //<>//

  ArrayList<Ray> rays= new ArrayList<Ray>();
  PVector pos;
  float maxDist;
  float minDist;
  float nRays, FOV;
  float windowHeight, windowWidth;
  int cameraDir;
  PVector dir;

  LightPoint(int FOV, int nRays, float windowWidth, float windowHeight) {

    float offset = float(FOV) / nRays;

    this.nRays = nRays;
    this.pos = new PVector(.0, .0);
    this.FOV = FOV;
    this.windowWidth = windowWidth;
    this.windowHeight = windowHeight;
    this.dir = new PVector( cos(FOV*0.5), sin(FOV * 0.5));
    this.maxDist = 100;
    this.minDist = 1;
    this.cameraDir = ((this.nRays%2)==0) ? int(nRays*0.5 -1) : int(nRays*0.5);

    for (int i = 0; i < nRays; i++)
      rays.add(new Ray (this.pos, i* offset));
  }

  void update(float mx, float my, float rotAngle) {
    if (mx > this.windowWidth)
      this.pos.x = this.windowWidth;
    else if (mx < 0)
      this.pos.x = 0;
    else
      this.pos.x = mx;

    if (mx > this.windowHeight)
      this.pos.y = this.windowHeight;
    else if (my < 0)
      this.pos.y = 0;
    else
      this.pos.y = my;

    for (Ray r : rays) {
      r.update(this.pos.x, this.pos.y);

      if (rotAngle != 0) r.updateDir(rotAngle);
    }
  }

  void show() {
    circle(this.pos.x, this.pos.y, 3);

    for (Ray r : rays) {
      float best_mag = Float.MAX_VALUE;
      PVector best_intersect = null;
      //WORKAROUND
      int index = rays.indexOf(r);

      for (Wall w : walls) {
        PVector intersect = r.cast(w);
        if (intersect==null) continue;
        float localMag = r.getMag(intersect);

        if (localMag < best_mag) {
          best_mag = localMag;
          best_intersect = intersect;
        }
      }
      if (best_intersect==null) continue;
      r.show(best_intersect);


      //FISH EYE CORRECTION
      //float angle = PVector.angleBetween(this.rays.get(this.cameraDir).dir, r.dir);
      float cosine = PVector.dot(this.rays.get(this.cameraDir).dir, r.dir);
      float fishEyeCorr = best_mag * cosine;
      float mappedHeight = map(fishEyeCorr, .1, windowHeight, windowHeight, 1);
      if (mappedHeight < 0) continue;

      rectMode(CENTER);
      stroke(mappedHeight/windowHeight * 255);
      rect(this.windowWidth+index, windowHeight*0.5, 1, mappedHeight);
    }
  }
}
