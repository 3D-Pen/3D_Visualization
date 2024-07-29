int base_time = 0;
int NUM = 100;
int i = 0;
int Countloop = 0;
PVector[] start = new PVector[NUM];
PVector[] end = new PVector[NUM];

float xx;
float zz;
float px, pz;
float rotX,rotY,protY;
float xc, yc, zc;
float pxc, pyc, pzc;
float s;

void setup() {
size(800, 600, P3D);
start[0] = new PVector(random(-200, 200), random(-200, 200), random(-200, 200));
//background(0);
stroke(255);
hint(ENABLE_DEPTH_SORT);
lights();
PFont font = createFont("MS Mincho", 48, true);
textFont(font);
textSize(54);

px = 0;
pz = 0;
xx = PI/6;
zz = 0;
xc = 0;
yc = 0;
zc = 0;
s = 1;
}

void draw() {
background(0);
translate(width/2, height/2,0);
//rotateX(PI/2);
//camera(100,0,600,0,0,0,0,0,-1);
//camera(400*cos(radians(Countloop)), 400*sin(radians(Countloop)), 400, 0, 0, 0, 0, 0, -1);
//Countloop+=PI/6;
camera(400*cos(xx), 400*sin(xx), 350, xc, yc, 0, 0, 0, -1);
rotateX(0);
rotateY(0);
scale(s);

textAlign(CENTER); // x方向をセンタリング，y方向の座標はベースライン
text("x軸", 200, 0, 0); // XY平面上に書く
text("y軸", 0, 200, 0); // XY平面上に書く 
text("z軸", 0, 0, 200); // Z=200のXY平面上に書く
line(0, 0, 0, 160, 0, 0); // X軸
line(0, 0, 0, 0, 160, 0); // Y軸
line(0, 0, 0, 0, 0, 160); // Z軸


int time = millis() - base_time;




//if (time >= 2000) {
    if(i >= 100){
        exit();
    }
    i++;
    end[i - 1] = new PVector(random(-200, 200), random(-200, 200), random(-200, 200));
    start[i] = end[i - 1];


    for (int k = 0; k < i; k++){
        line(start[k].x, start[k].y, start[k].z, end[k].x, end[k].y, end[k].z);
    }
    delay(500);
    //base_time = millis();
    }
//}
void mouseDragged(){
    if(mouseButton == LEFT){
        if(mouseX-pmouseX >= 0){
            xx = map(mouseX-pmouseX, 0, width, 0, 2*PI);
        }
        if(mouseX-pmouseX <= 0){
            xx = map(mouseX-pmouseX, -width, 0, -2*PI, 0);
        }
        xx += px;
        px = xx;
        
        if(mouseY-pmouseY >= 0){
            zz = map(mouseY-pmouseY, 0, height, 0, PI);
        }
        if(mouseY-pmouseY <= 0){
            zz = map(mouseY-pmouseY, -height, 0, PI, 0);
        }
        //println("zz",zz);
        zz += pz;
        pz = zz;
        //println("zz",zz);
    }
    
    if(mouseButton == CENTER){
        xc += pmouseY-mouseY;
        pxc = xc;
        yc += mouseX-pmouseX;
        pyc = yc;
    }
}

void mouseWheel(MouseEvent e){
    float mw = e.getCount();
    if(mw == 1){
        s *= 0.9;
    }
    if(mw == -1){
        s *= 1.1;
    }   
}