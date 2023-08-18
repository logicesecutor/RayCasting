class LightPoint { //<>// //<>// //<>//

  // List of Rays that we cast from that point in a specific direction
  // in a range of Angle
  ArrayList<Ray> rays = new ArrayList();

  float nRays;  // Number of rays we cast from the light point
  float FOV;    // Field of view intended as the range of the angle where we cast the rays

  float windowHeight, windowWidth;

  // Position of the light point
  PVector pos;
  PVector cameraDir;
  PVector sentinelVector;

  LightPoint(int FOV, int nRays, float windowWidth, float windowHeight) {

    float offset = float(FOV) / nRays;

    this.nRays = nRays;
    this.pos = new PVector(0, 0);
    this.FOV = FOV;
    this.windowWidth = windowWidth;
    this.windowHeight = windowHeight;

    this.sentinelVector = new PVector(Float.MAX_VALUE, Float.MAX_VALUE);

    //this.cameraDir = ((this.nRays % 2) == 0) ? int(nRays * 0.5 -1) : int(nRays * 0.5);
    this.cameraDir = PVector.fromAngle(radians(FOV * 0.5)).setMag(20);

    for (int i = 0; i < nRays; i++)
      //rays.add(new Ray (this.pos, i* offset));
      this.rays.add(new Ray(this.pos, PVector.fromAngle(radians(i * offset))));
  }

  void updatePosition(float newX, float newY) {

    if (newX > this.windowWidth - 1)
      this.pos.x = this.windowWidth - 1;
    else if (newX < 1)
      this.pos.x = 1;
    else
      this.pos.x = newX;

    if (newY > this.windowHeight - 1)
      this.pos.y = this.windowHeight - 1;
    else if (newY < 1)
      this.pos.y = 1;
    else
      this.pos.y = newY;

    for (Ray r : this.rays)
      r.updatePosition(this.pos.x, this.pos.y);
  }

  void updateRotation(float rotAngle) {
    this.cameraDir.rotate(radians(rotAngle));
    for (Ray r : this.rays) {
      r.updateRotation(rotAngle);
    }
  }

  void show(ArrayList<Wall> walls) {
    // Draw the Light Point
    circle(this.pos.x, this.pos.y, 3);
    for (int index = 0; index < this.rays.size(); index++) {
      Ray r = this.rays.get(index);
      //Find nearest wall per each ray and render it
      float minDistance = Float.MAX_VALUE;
      float intersectDistance;

      // Cast each ray against each wall in the scene (Brute Force slow)
      // TODO: consider using space quantization or quadTree data-structures
      for (Wall w : walls) {
        intersectDistance = this.cast(r, w);
        // If do not intersect (parallel/coplanar lines) test the next wall
        if (intersectDistance == -1)
          continue;

        // Save the nearest point of intersection
        if (intersectDistance < minDistance)
          minDistance = intersectDistance;
      }

      // If no wall was find do not render the Ray
      if (minDistance == Float.MAX_VALUE)
        continue;

      // Draw the ray from the start point to the intersection point
      r.show(new PVector(r.start.x + r.dir.x * minDistance, r.start.y + r.dir.y * minDistance));

      //FISH EYE CORRECTION
      float z = minDistance * cos(PVector.angleBetween(this.cameraDir, r.dir));
      float wallHeight = this.windowHeight  *  (this.windowHeight - 200 )/ z;
      
      //float angle = PVector.angleBetween(this.rays.get(this.cameraDir).dir, r.dir);
      //float cosine = PVector.dot(this.rays.get(this.cameraDir).dir, r.dir);
      //float fishEyeCorr = minDistance * cosine;
      float mappedHeight = map(z, .1, windowHeight, windowHeight, 1);
      if (mappedHeight < 0) continue;

      rectMode(CENTER);
      stroke(wallHeight/windowHeight * 255);
      rect(this.windowWidth+index, windowHeight*0.5, 1, wallHeight);
    }
  }

  //float cast(Ray r, Wall w) {

  //  PVector ortho = new PVector(-r.dir.y, r.dir.x);
  //  //PVector aToO = PVector.sub(r.start, w.P1);
  //  PVector aToO = new PVector(r.start.x - w.P1.x, r.start.y - w.P1.y);
  //  //PVector aToB = PVector.sub(w.P2, w.P1);
  //  PVector aToB = new PVector(w.P2.x - w.P1.x, w.P2.y - w.P1.y);

  //  float denominator = PVector.dot(aToB, ortho);

  //  if (abs(denominator) < 0.0000001)
  //    return -1;

  //  float t = aToB.cross(aToO).mag() / denominator;
  //  float u = PVector.dot(aToO, ortho) / denominator;

  //  if (t >= 0 && u <= 1 && u >= 0)
  //    return t;

  //  return -1;
  //}

  float cast(Ray r, Wall w) {

    // Ray Data
    float x1=r.start.x;
    float y1=r.start.y;
    float x2=r.start.x + r.dir.x;
    float y2=r.start.y + r.dir.y;

    // Wall Data
    float x3=w.P1.x;
    float y3=w.P1.y;
    float x4=w.P2.x;
    float y4=w.P2.y;

    float denominator = (x1-x2)*(y3-y4)-(y1-y2)*(x3-x4);

    // For numerical stability
    if (abs(denominator) < 0.00000001)
      return -1;

    float t=((x1-x3)*(y3-y4)-(y1-y3)*(x3-x4))/denominator;
    float u=-(((x1-x2)*(y1-y3)-(y1-y2)*(x1-x3))/denominator);

    // Return the intersection distance
    if (t>=0 && u<=1 && u>=0 )
      return t;

    return -1;
  }
}
