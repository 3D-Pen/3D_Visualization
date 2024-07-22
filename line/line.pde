void setup(){
    size(800,800,P3D);
    background(255);
    camera(200,200,200,0,0,0,0,0,-1);
}

PVector [] data3D = new PVector[1000];
float t=1;

void draw(){
    int [][] axis = {{0,0,0},{100,100,100}};
    data3D[0] = new PVector(0,0,0);
    data3D[t] = new PVector(random(-100,100),random(-100,100),random(-100,100));

    line(axis[0][0], axis[0][1], axis[0][2], axis[1][0], axis[0][1], axis[0][2]);
    line(axis[0][0], axis[0][1], axis[0][2], axis[0][0], axis[1][1], axis[0][2]);
    line(axis[0][0], axis[0][1], axis[0][2], axis[0][0], axis[0][1], axis[1][2]);
    line(data3D[t-1][0], data3D[t-1][1], data3D[t-1][2], data3D[t][0], data3D[t][1], data3D[t][2]);
    t+=1;

    if(t>=1000){
        noLoop();
    }
}

