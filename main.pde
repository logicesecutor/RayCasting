int nWalls = 10;
int FOV = 120;   //degrees
int nRays = 500;

float rotAngle = 0;
float rotVelocity = 4;  //radians per frame
LightPoint player;

ArrayList<Wall> edgeWalls;

void setup() {
  size(1000, 500, P2D); //<>//
  //fullScreen(P2D);
  
  float dividedWidth = width * 0.5;
  float dividedHeight = height;
  
  player = new LightPoint(FOV, nRays, dividedWidth, dividedHeight);
  edgeWalls = new ArrayList();

  //Edge Walls
  edgeWalls.add(new Wall(0, 0, dividedWidth, 0, "Top")); //<>//
  edgeWalls.add(new Wall(0, 0, 0, dividedHeight, "Left"));
  edgeWalls.add(new Wall(0, dividedHeight, dividedWidth, dividedHeight, "Right"));
  edgeWalls.add(new Wall(dividedWidth, 0, dividedWidth, dividedHeight, "Bottom"));
  
  edgeWalls.add(new Wall(dividedWidth * 0.5, 0, dividedWidth * 0.5, dividedWidth * 0.5, "In the middle"));
  
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
  
  player.updateRotation(rotAngle); //<>//
  player.show(edgeWalls); //<>//

  //println(frameRate);
}

void keyPressed(){
  if (key == 'a')
    //player.updateRotation(-rotVelocity);
    rotAngle = -rotVelocity;
  if (key == 'd')
    //player.updateRotation(rotVelocity);
    rotAngle = rotVelocity;
}

void mouseMoved(){
  player.updatePosition(mouseX, mouseY);
}

void keyReleased(){
  rotAngle = 0;
}
