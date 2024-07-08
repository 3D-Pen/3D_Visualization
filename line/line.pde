void setup(){
    size(800,800,P3D);
    frameRate(60);
}

int basetime = 0;

void draw(){
    int time = millis()-basetime;
    background(255);
    camera(200,200,200,0,0,0,0,0,-1);
    
    int [][] data3D = {{0,0,0},{100,100,100}};
    line(data3D[0][0], data3D[0][1], data3D[0][2], data3D[1][0], data3D[0][1], data3D[0][2]);
    line(data3D[0][0], data3D[0][1], data3D[0][2], data3D[0][0], data3D[1][1], data3D[0][2]);
    line(data3D[0][0], data3D[0][1], data3D[0][2], data3D[0][0], data3D[0][1], data3D[1][2]);
    line(data3D[0][0],data3D[0][1], data3D[0][2],0,0.01*time,0.01*time);
}