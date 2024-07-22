void setup(){
    size(800,800,P3D);
    background(255);
    camera(200,200,200,0,0,0,0,0,-1);
}

int NUM=100;

PVector [] location = new PVector[NUM];
PVector [] velocity = new PVector[NUM];
int t=1;

void draw(){
    location[0] = new PVector(100,100,100);
    velocity[t-1] = new PVector(random(-5,5),random(-5,5),random(-5,5));
    location[t] = new PVector(location[t-1].x+velocity[t-1].x, location[t-1].y+velocity[t-1].y, location[t-1].z+velocity[t-1].z);

    int [][] axis = {{0,0,0},{150,150,150}};
    line(axis[0][0], axis[0][1], axis[0][2], axis[1][0], axis[0][1], axis[0][2]);
    line(axis[0][0], axis[0][1], axis[0][2], axis[0][0], axis[1][1], axis[0][2]);
    line(axis[0][0], axis[0][1], axis[0][2], axis[0][0], axis[0][1], axis[1][2]);
    line(location[t-1].x,location[t-1].y,location[t-1].z, location[t].x, location[t].y, location[t].z);
    t++;
    delay(100);
    if(t>=NUM-1){
        noLoop();
    }
}

