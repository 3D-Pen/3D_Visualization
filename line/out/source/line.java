/* autogenerated by Processing revision 1293 on 2024-07-22 */
import processing.core.*;
import processing.data.*;
import processing.event.*;
import processing.opengl.*;

import java.util.HashMap;
import java.util.ArrayList;
import java.io.File;
import java.io.BufferedReader;
import java.io.PrintWriter;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.IOException;

public class line extends PApplet {

public void setup(){
    /* size commented out by preprocessor */;
    background(255);
    camera(200,200,200,0,0,0,0,0,-1);
}

float [1001][3] data3D = {{0,0,0}};
float t=1;

public void draw(){
    int [][] axis = {{0,0,0},{100,100,100}};
    data3D[t][0]=random(0,100);
    data3D[t][1]=random(0,100);
    data3D[t][2]=random(0,100);

    line(axis[0][0], axis[0][1], axis[0][2], axis[1][0], axis[0][1], axis[0][2]);
    line(axis[0][0], axis[0][1], axis[0][2], axis[0][0], axis[1][1], axis[0][2]);
    line(axis[0][0], axis[0][1], axis[0][2], axis[0][0], axis[0][1], axis[1][2]);
    line(data3D[t-1][0], data3D[t-1][1], data3D[t-1][2], data3D[t][0], data3D[t][1], data3D[t][2]);
    t+=1;

    if(t>=1000){
        noLoop();
    }
}


  public void settings() { size(800, 800, P3D); }

  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "line" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
