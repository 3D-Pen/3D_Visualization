/* autogenerated by Processing revision 1293 on 2024-10-18 */
import processing.core.*;
import processing.data.*;
import processing.event.*;
import processing.opengl.*;

import processing.net.*;

import java.util.HashMap;
import java.util.ArrayList;
import java.io.File;
import java.io.BufferedReader;
import java.io.PrintWriter;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.IOException;

public class test extends PApplet {


int port = 10001;
Server server;

int base_time = 0;      //一定時間ごとにmillis()を初期化
int NUM = 10000;         //描ける直線の総数
int i;               //直線の数
PVector[] start = new PVector[NUM];     //直線の始まりの座標
PVector[] end = new PVector[NUM];       //直線の終わりの座標
//String lin;             //テキストで読み込んだ任意の行の文字列
int ln;                 //行数
//String lines[];         //テキスト全体を読み込む文字列
float xx;               //
float zz;               //
float px, pz;           //
float rotX,rotY,protY;  //マウスで座標を記録する値
float xc, yc, zc;       //
float pxc, pyc, pzc;    //
float s;                //
PrintWriter file;
int jump = 9999;        //csvファイルの外れ値
int head = 0;
int ap = 5;
int sele = 0;
int time;
String whatClientSaid;
int count;



public void setup() {
    /* size commented out by preprocessor */;        //横1366，縦768の3D
    //size(800, 600, P3D);        //横800，縦600の3D
    stroke(0);                //線の色(白色)
    hint(ENABLE_DEPTH_SORT);    //P3DレンダラとOPENGLレンダラにおいて、プリミティブなzソートを有効にする．(よく分からん)
    lights();                   //デフォルトの環境光
    textSize(54);               //テキストサイズを54
    frameRate(30);              //フレームレートを30
    server = new Server(this, port);
    println("server address: " + server.ip());
    formatting();
    //file = createWriter("test.csv");
    count = 0;
}

public void draw() {
    background(255);                      //背景を白にする
    translate(width/2, height/2,0);     //中心を決定
    //lines = loadStrings("pos.txt");     //pod.txtを読み込む
    textFont(createFont("MS Mincho", 48, true));             //フォントをMS明朝にする．
    if (sele == 3){
        exit();
    }
    else if (sele == 2){
        time = millis() - base_time;
        endscreen();
        if (time >= 1000){
            base_time = millis();
            ap--;
            }
        if (ap == 0){
            sele = 0;
            for (int k = 0; k < i; k++){
                start[k] = new PVector(0,0,0);
                end[k] = new PVector(0,0,0);
            }
            formatting();
        }
    }
    else if (sele == 1){
        if(sin(zz) >= 0){
            camera(500*cos(xx)*sin(zz), 500*sin(xx)*sin(zz), 500*cos(zz), xc, yc, 0, 0, 0, -1);
        }           //カメラの位置
        else {
            camera(500*cos(xx)*sin(zz), 500*sin(xx)*sin(zz), 500*cos(zz), xc, yc, 0, 0, 0, 1);
        }           //カメラの位置
        
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

        for (int k = 0; k < i; k++){
            line(start[k].x, start[k].y, start[k].z, end[k].x, end[k].y, end[k].z);
        }           //毎フレームごとに線を描く

        time = millis() - base_time;        //一定時間ごとにtimeを初期化
        Client client = server.available();
        if(client ==null){
            return;             //読み込んだ行数が最終行なら最初に戻る
        }
        else{
            //何もしない
        }
        whatClientSaid = client.readString();
        String[] so = split(whatClientSaid, ',');
        //println(so[0] + "," + so[1] + "," + so[2] + "," + so[3] + "," + so[4] + "," + so[5] + "," + so[6]);
        if(unhex(so[0]) == 43690) {
            start[i] = new PVector(0,0,0);
            head = 0;
            return;
        }
        if(unhex(so[0]) == 65535){      //so[0]がFFFFなら
                if(i >= 10000){          //10000個以上直線を描いたら終了
                    exit();
                }
                else {
                    //何もしない
                }
                if(head == 0){
                    start[i] = new PVector(PApplet.parseInt(so[1]),PApplet.parseInt(so[2]),PApplet.parseInt(so[3]));
                    head = 1;
                }
                else {
                    end[i] = new PVector(PApplet.parseInt(so[1]),PApplet.parseInt(so[2]),PApplet.parseInt(so[3]));
                    start[i + 1] = end[i];
                    i++;
                    ln++;       //1行増やす
                }
                
                base_time = millis();
            
            //head = 0;
        }
        else if(unhex(so[0]) == 4369){
            end[i] = new PVector(PApplet.parseInt(so[1]),PApplet.parseInt(so[2]),PApplet.parseInt(so[3]));
            i++;
            ln++;
            file = createWriter("test_" + count + ".csv");
            makecsvfile();
            sele = 2;
            count++;
            //head = 0;
        }
        ap = 5;
    }
    else if(sele == 0){
        startscreen();
    }
}
public void mouseDragged(){            //マウスの割り込み
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
            zz = map(mouseY-pmouseY, 0, height, 0, 2*PI);
        }
        if(mouseY-pmouseY <= 0){
            zz = map(mouseY-pmouseY, -height, 0, -2*PI, 0);
        }
        zz += pz;
        pz = zz;
    }
    
    if(mouseButton == CENTER){      //平行移動
        xc += pmouseY-mouseY;
        pxc = xc;
        yc += mouseX-pmouseX;
        pyc = yc;
    }
}

public void mouseWheel(MouseEvent e){      //ホイールでサイズを変更
    float mw = e.getCount();
    if(mw == 1){
        s *= 0.9f;
    }
    if(mw == -1){
        s *= 1.1f;
    }   
}

public void keyPressed(){
    if (key == ENTER){
        sele = 1;
    }
    else if (key == TAB){
        sele = 2;
    }
    else if (key == ESC){
        sele = 3;
    }
    else {
        sele = 0;
    }
}

public void formatting(){
    head = 0;
    i = 0;
    ln = 0;             //行数を0にする
    px = PI/6;          //
    pz = PI/6;          //
    xx = PI/6;          //
    zz = PI/6;          //カメラの初期環境
    xc = 0;             //
    yc = 0;             //
    zc = 0;             //
    s = 0.7f;            //
}

public void makecsvfile(){
    file.println(start[0].x + "," + start[0].y + "," + start[0].z);
    file.flush();
    for (int o = 0; o < ln - 1; o++){
        if (start[o + 1].x == end[o].x && start[o + 1].y == end[o].y && start[o + 1].z == end[o].z){
            file.println(start[o + 1].x + "," + start[o + 1].y + "," + start[o + 1].z);
            file.flush();
        }
        else {
            file.println(end[o].x + "," + end[o].y + "," + end[o].z);
            file.println(jump + "," + jump + "," + jump);
            file.println(start[o + 1].x + "," + start[o + 1].y + "," + start[o +1].z);
            file.flush();
        }
    }
    file.println(end[ln - 1].x + "," + end[ln - 1].y + "," + end[ln - 1].z);
    file.flush();
    file.close();
}

public void startscreen(){
    camera(0,10,500, 0, 0, 0, 0, 0, -1);
    hint(DISABLE_DEPTH_TEST);
    fill(0);
    textFont(createFont("HG正楷書体-PRO", 110));
    textSize(54);
    text("ENTERキーを押して",0, 0);
    textAlign(CENTER,CENTER);
    hint(ENABLE_DEPTH_TEST);  // z軸を有効化
}

public void endscreen(){
    camera(0, 10, 500, xc, yc, 0, 0, 0, -1);
    background(255);
    hint(DISABLE_DEPTH_TEST);
    fill(0);
    textFont(createFont("HG正楷書体-PRO", 110));
    textSize(54);
    text("終了まであと",200, 220);
    text(ap,380, 220);
    text("秒",430, 220);
    textAlign(CENTER,CENTER);
    hint(ENABLE_DEPTH_TEST);  // z軸を有効化
}


  public void settings() { size(1366, 768, P3D); }

  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "test" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
