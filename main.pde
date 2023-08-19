// TODO: precompute the cosine and sine values to speed up the computation //<>// //<>// //<>// //<>//

int nWalls = 10;
int nRays; //One for each pixel-width

int FOV;  
float wallHeight;
float projectionPlaneHeight, projectionPlaneWidth ;
float projectionPlanePlayerDistance;
float angleBetweenRays;

float dividedWidth;
float dividedHeight;

float rotAngle = 0;
float rotVelocity = 4;  //radians per frame
LightPoint player;

ArrayList<Wall> edgeWalls;

void setup() {
  size(1280, 720, P2D);
  //fullScreen(P2D);

  dividedWidth = width * 0.5;
  dividedHeight = height;
  FOV = 60;   //degrees
  wallHeight = dividedHeight;
  projectionPlaneHeight = dividedWidth;
  projectionPlaneWidth = dividedHeight;
  
  projectionPlanePlayerDistance = (projectionPlaneWidth * 0.5) / tan(radians(FOV * 0.5));
  angleBetweenRays = FOV / projectionPlaneWidth;

  nRays = int(dividedWidth);
  println("Number of Casted Rays: " + nRays);

  player = new LightPoint(FOV, nRays, dividedWidth, dividedHeight);
  edgeWalls = new ArrayList();

  //Edge Walls
  edgeWalls.add(new Wall(0, 0, dividedWidth, 0, "Top", color(255, 0, 0)));
  edgeWalls.add(new Wall(0, 0, 0, dividedHeight, "Left", color(0, 255, 0)));
  edgeWalls.add(new Wall(0, dividedHeight, dividedWidth, dividedHeight, "Right", color(0, 0, 255)));
  edgeWalls.add(new Wall(dividedWidth, 0, dividedWidth, dividedHeight, "Bottom", color(0, 255, 255)));

  edgeWalls.add(new Wall(dividedWidth * 0.5, 0, dividedWidth * 0.5, dividedWidth * 0.5, "In the middle", color(255, 0, 255)));

  //Other Random Walls
  //for (int i=0; i<nWalls; ++i)
  //  walls.add(new Wall(random(0, dividedWidth),
  //    random(0, dividedHeight),
  //    random(0, dividedWidth),
  //    random(0, dividedHeight)
  //    ));
  //frameRate(10);
}

void draw() {

  background(0);

  for (Wall ew : edgeWalls) ew.show2D();

  player.updateRotation(rotAngle);
  player.show(edgeWalls);

  //println(frameRate);
}

void keyPressed() {
  if (key == 'a')
    rotAngle = -rotVelocity;
  if (key == 'd')
    rotAngle = rotVelocity;
}

void mouseMoved() {
  player.updatePosition(mouseX, mouseY);
}

color randomColor() {
  return color(random(0, 255), random(0, 255), random(0, 255));
}

void keyReleased() {
  rotAngle = 0;
}
