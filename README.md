# RayCasting
An experimental project to understand the math and the logic behind the ray-casting graphic algorithm.

# Used IDE
To develop this project I have used Processing IDE which provide an easy to tuse interface to the OpenGL API.
The main language is **Java**. With few line of code we can easily draw some line or 3D shapes on screen.

[Processing Download](https://processing.org/download)
You just need to dowload the IDE, the code, open the code inside Processing and click on the **"Run"** button.

If interested to modify the code consult the reference page on the web-site:
[Processing Reference]([https://processing.org/download](https://processing.org/reference))


The objective was to develop an easy to understand algorithm to visualize the concept of casting a ray in 2D and, with some math intuition, project the world in a threedimensional form. This type of algorithm was at the base of the very famous Game DOOM!

![Working Algorithm](https://media.giphy.com/media/vFKqnCdLPNOKc/giphy.gif)

# How it work
We have 3 main class:
- Light point: is the point where we cast the ray from;
- Ray: is the datastructure which represent the ray. A ray is completely described from its origin point and its direction
- Wall: a wall is a line that can block a ray and which a ray can have an intersection.

# The algorithm 
In the code I use only one "LightPoint" which represent our player (but we can create an arbitrary number of objects). I give that player a Field of view (FOV) which is the angle between we can cast the rays. 

The logic is very simple. We cast a bounch of rays between a certain angle range. For example we want to cast 10 rays in a range of 120 degree of field of view.




