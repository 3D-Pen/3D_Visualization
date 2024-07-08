void setup(){
    size(800,800,P3D);
    background(255);
    camera(200,200,200,0,0,0,0,0,-1);
}
float t=0;
void draw(){
    int [][] data3D = {{0,0,0},{100,100,100}};
    line(data3D[0][0], data3D[0][1], data3D[0][2], data3D[1][0], data3D[0][1], data3D[0][2]);
    line(data3D[0][0], data3D[0][1], data3D[0][2], data3D[0][0], data3D[1][1], data3D[0][2]);
    line(data3D[0][0], data3D[0][1], data3D[0][2], data3D[0][0], data3D[0][1], data3D[1][2]);
    line(data3D[0][0],data3D[0][1], data3D[0][2],0,100*sin(0.01*t),100*cos(0.01*t));
    t+=1;
}