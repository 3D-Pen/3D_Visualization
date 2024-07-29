int base_time = 0;
int NUM = 100;
int i = 0;
int loopCount;
PVector[] start = new PVector[NUM];
PVector[] end = new PVector[NUM];



void setup() {
size(800, 600, P3D);
loopCount=0;
start[0] = new PVector(random(-200, 200), random(-200, 200), random(-200, 200));
background(0);
stroke(255);
hint(ENABLE_DEPTH_SORT);
}
void draw() {

loopCount++;
int time = millis() - base_time;
translate(width/2, height/2,0);
rotateX(PI/2);


if (time >= 2000) {
    if(i >= 100){
        exit();
    }
    i++;
    end[i - 1] = new PVector(random(-200, 200), random(-200, 200), random(-200, 200));
    start[i] = end[i - 1];


    for (int k = 0; k < i; k++){
        line(start[k].x, start[k].y, start[k].z, end[k].x, end[k].y, end[k].z);
        println("start",start[k]);
        println("end",end[k]);
    }
    base_time = millis();
    }

}