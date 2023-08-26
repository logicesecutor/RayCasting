# RayCasting
An experimental project to understand the math and the logic behind the ray-casting graphic algorithm.

# Used IDE
To develop this project I have used Processing IDE which provides an easy-to-use interface to the OpenGL API.
The main language is **Java**. We can easily draw some lines or 3D shapes on the screen with a few lines of code.

[Processing Download](https://processing.org/download)
You just need to download the IDE, the code, open the code inside Processing, and click on the **"Run"** button.

If interested in modifying the code consult the reference page on the website:
[Processing Reference]([https://processing.org/download](https://processing.org/reference))

The objective was to develop an easy-to-understand algorithm to visualize the concept of casting a ray in 2D and, with some math intuition, project the world in a three-dimensional form. This type of algorithm was at the base of the very famous Game DOOM!

# How it works
We have 3 main classes:
- Light point: is the point where we cast the ray from;
- Ray: is the data structure that represents the ray. A ray is completely described from its origin point and its direction
- Wall: a wall is a line that can block a ray and which a ray can have an intersection. A wall is defined in 2D by two points in the space (a line).

# The algorithm 
In the code, I use only one "LightPoint" representing our player but we can create an arbitrary number of LightPoint objects. 
I give the player a Field of view (FOV) which is the angle between which we can cast the rays. 

The logic is very simple. We cast a bunch of rays (theoretically one ray for one pixel of the width of the screen) in the FOV range, for example, with a resolution of 1080x1920 and a FOV of 60 degrees we want to cast 1920 rays in a range of 60 degrees.

The following code is the **cast** function that takes a wall and, if there is an intersection returns the distance of the intersection otherwise returns -1.

```java
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
```

For each ray, I cast it against all the walls in the scene. We save the distance with the lower value and draw a line from the origin in the ray direction with the length of the founded intersection distance.
```java
Final Ray = origin + direction * intersection_distance;
```

# The 3D part
It is easy to simulate a 3D environment starting from the concept expressed above.
We can think about it as at each intersection a piece of the world needs to be rendered into the screen. 
For each intersection, I draw a vertical line whose height must be inversely proportional to the intersection distance: the greater the distance, the smaller the line will be and vice-versa.  
This can be seen as projecting a line on a view plane.

```java
float projectionPlanePlayerDistance = (projectionPlaneWidth * 0.5) / tan(radians(FOV * 0.5));
float final wallHeight = windowHeight * reduction_factor * projectionPlanePlayerDistance / intersection_distance ;
```

# Fish-eye Effect
We encounter visual distortion in the rendering due to the fact that when we face a wall and cast rays some rays are longer than others and that leads to curved rendered walls.
```java
correct_intersection_distance = intersection_distance * cos(angle_from_player_direction);
```
![Fish eye adjustment](https://github.com/logicesecutor/RayCasting/blob/main/src/raycaster-distance.png)
[Fish eye adjustment Reference](https://www.playfuljs.com/a-first-person-engine-in-265-lines/)

# Comands
The player
- Rotate counter-clockwise with "A";
- Rotate clockwise with "D";
- Move following the mouse pointer.

![Working Algorithm](https://github.com/logicesecutor/RayCasting/blob/main/src/final_results.gif)



