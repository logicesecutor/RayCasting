class LightPoint { //<>//

  ArrayList<Ray> rays= new ArrayList<Ray>();
  PVector pos= new PVector(.0, .0);
  float maxDist;
  float minDist;
  float nRays, FOV;
  PVector dir;

  LightPoint(int FOV, int nRays) {
    
    float offset = float(FOV) / nRays; //<>//
    
    this.nRays = nRays;
    this.FOV = FOV;
    this.dir = new PVector( cos(FOV*0.5), sin(FOV * 0.5));
    this.maxDist = 100;
    this.minDist = 1;
    
    for (int i = 0; i < nRays; i++)
      rays.add(new Ray (this.pos, i* offset));
  }

  void update(float mx, float my, float rotAngle) {
    this.pos.x += mx;
    this.pos.y += my;

    for (Ray r : rays){
      r.update(mx, my);
      
      if(rotAngle != 0) r.updateDir(rotAngle);
    }
  }

  void show() {
    circle(pos.x, pos.y, 3);

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
      rectMode(CENTER);
      
      
      //FISH EYE CORRECTION
      float angle = PVector.angleBetween(this.rays.get(int(nRays*0.5)).dir, r.dir);
      
      float fishEyeCorr = best_mag * cos(angle);
      float mappedHeight = map(fishEyeCorr, .1, height, height, 1);
      if(mappedHeight < 0) continue;
      rect(height+index, height*0.5, 1, mappedHeight);
    }
  }
}
