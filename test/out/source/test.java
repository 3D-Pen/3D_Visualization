/* autogenerated by Processing revision 1293 on 2024-10-19 */
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

    //processingソケット通信
int port = 10001;           //適当なポート番号(受信、送信で一致させる)
Server server;              //Server型

int base_time = 0;          //一定時間ごとにmillis()を初期化
int NUM = 10000;            //描ける直線の総数
int i;                      //直線の数
PVector[] start = new PVector[NUM];     //直線の始まりの座標
PVector[] end = new PVector[NUM];       //直線の終わりの座標
int ln;                     //受信した行数
float xx;                   //{
float zz;                   //
float px, pz;               //
float rotX,rotY,protY;      //マウスで座標を記録する値
float xc, yc, zc;           //
float pxc, pyc, pzc;        //}
float s;                    //拡大サイズ
PrintWriter file;           //書き込む型
int jump = 9999;            //csvファイルの外れ値
int head = 0;               //受信が1回目のとき
int ap = 5;                 //5秒待つ
int sele = 0;               
int time;                   //時間
String whatClientSaid;      //受信する型
int count;                  //これまで繰り返した数



public void setup() {
    /* size commented out by preprocessor */;           //横1366，縦768の3D
    //size(800, 600, P3D);          //横800，縦600の3D
    stroke(0);                      //線の色(白色)
    hint(ENABLE_DEPTH_SORT);        //P3DレンダラとOPENGLレンダラにおいて、プリミティブなzソートを有効にする．(よく分からん)
    lights();                       //デフォルトの環境光
    textSize(54);                   //テキストサイズを54
    frameRate(60);                  //フレームレートを30
    server = new Server(this, port);
    println("server address: " + server.ip());      //このパソコンのIPアドレスを表示
    formatting();                   //いろいろな数値を初期化
    count = 0;
}

public void draw() {
    background(255);                        //背景を白にする
    translate(width / 2, height / 2,0);         //中心を決定
    textFont(createFont("MS Mincho", 48, true));             //フォントをMS明朝にする．
    if (sele == 3) {
        exit();         //強制終了
    }
    else if (sele == 5) {
        time = millis() - base_time;        //時間を初期化
        endscreen();
        
        if (time >= 1000) {      //1秒待つ
            base_time = millis();
            ap--;
        }
        if (ap == 0) {
            sele = 0;       //初期画面に戻す
            for (int k = 0; k < i; k++) {
                start[k] = new PVector(0,0,0);      //配列を初期化
                end[k] = new PVector(0,0,0);        //同上
            }
            formatting();
        }
    }
    else if (sele == 1 || sele == 2) {
        if (sin(zz) >= 0) {
            camera(500 * cos(xx) * sin(zz), 500 * sin(xx) * sin(zz), 500 * cos(zz), xc, yc, 0, 0, 0, -1);
        }           //カメラの位置
        else {
            camera(500 * cos(xx) * sin(zz), 500 * sin(xx) * sin(zz), 500 * cos(zz), xc, yc, 0, 0, 0, 1);
        }           //カメラの位置
        
        stroke(0);
        rotateX(0);
        rotateY(0);
        scale(s);
        textAlign(CENTER); // x方向をセンタリング，y方向の座標はベースライン
        text("X", 200, 0, 0); // XY平面上に書く
        text("Y", 0, 200, 0); // XY平面上に書く 
        text("Z", 0, 0, 200); // Z=200のXY平面上に書く
        strokeWeight(1);
        line(0, 0, 0, 160, 0, 0); // X軸
        line(0, 0, 0, 0, 160, 0); // Y軸
        line(0, 0, 0, 0, 0, 160); // Z軸
        
        
        strokeCap(ROUND);
        strokeWeight(10);
        
        for (int k = 0; k < i; k++) {
            stroke(0);
            strokeWeight(10);
            // 線を描く
            line(start[k].x, start[k].y, start[k].z, end[k].x, end[k].y, end[k].z);
            // sphereDetail(1);
            
            // // 線の始点に球体を描画して丸い先端を再現
            // pushMatrix();
            // translate(start[k].x, start[k].y, start[k].z);
            // noStroke();
            // fill(0);// 球体の色
            // sphere(3); // 球体のサイズ
            // popMatrix();
            
            // // 線の終点にも同様に球体を描画
            // pushMatrix();
            // translate(end[k].x, end[k].y, end[k].z);
            // noStroke();
            // fill(0);// 球体の色
            // sphere(3); // 球体のサイズ
            // popMatrix();
        }
        
        //毎フレームごとに線を描く
        
        time = millis() - base_time;        //一定時間ごとにtimeを初期化
        Client client = server.available(); //clientに受信した信号を受け取る
        if (client ==  null) {                  //何も信号が来なかったら
            return;             //最初に戻る
        }
        else{
            //何もしない
        }
        whatClientSaid = client.readString();       //受信した文字列を収容
        String[] so = split(whatClientSaid, ',');   //コンマで区切られた文字列を分ける
        if (unhex(so[0]) == 43690) {                 //AAAAならば
            start[i] = new PVector(0,0,0);
            head = 0;
            // return;
        }
        if (unhex(so[0]) == 65535) {       //so[0]がFFFFなら
            // if (i >= 10000) {          //10000個以上直線を描いたら終了
            //     exit();
        // }
            // else{
            //     //何もしない
        // }
            if (head == 0) {          //1回目かAAAAの次
                start[i] = new PVector(PApplet.parseInt(so[1]),PApplet.parseInt(so[2]),PApplet.parseInt(so[3]));
                head = 1;
            }
            else{
                end[i] = new PVector(PApplet.parseInt(so[1]),PApplet.parseInt(so[2]),PApplet.parseInt(so[3]));
                start[i + 1] = end[i];  //終端と先端を一致させる
                i++;
                ln++;       //1行増やす
            }
            base_time = millis();
        }

        
        if (sele == 2) {
            end[i] = new PVector(PApplet.parseInt(so[1]),PApplet.parseInt(so[2]),PApplet.parseInt(so[3]));
            i++;
            ln++;
            file = createWriter("csv/test_" + count + ".csv");  //csvファイルを順次作成
            makecsvfile();
            sele = 5;
            count++;
        }
        ap = 5;
    }
    else if (sele == 0) {
        startscreen();
    }
}
public void mouseDragged() {            //マウスの割り込み
    if (mouseButton == LEFT) {
        if (mouseX - pmouseX >= 0) {
            xx = map(mouseX - pmouseX, 0, width, 0, 2 * PI);
        }
        if (mouseX - pmouseX <= 0) {
            xx = map(mouseX - pmouseX, -width, 0, -2 * PI, 0);
        }
        xx += px;
        px = xx;
        
        if (mouseY - pmouseY >= 0) {
            zz = map(mouseY - pmouseY, 0, height, 0, 2 * PI);
        }
        if (mouseY - pmouseY <= 0) {
            zz = map(mouseY - pmouseY, -height, 0, -2 * PI, 0);
        }
        zz += pz;
        pz = zz;
    }
    
    if (mouseButton == CENTER) {      //平行移動
        xc += pmouseY - mouseY;
        pxc = xc;
        yc += mouseX - pmouseX;
        pyc = yc;
    }
}

public void mouseWheel(MouseEvent e) {      //ホイールでサイズを変更
    float mw = e.getCount();
    if (mw == 1) {
        s *= 0.9f;
    }
    if (mw == -1) {
        s *= 1.1f;
    }   
}

public void keyPressed() {          //キーを押したら
    if (key == ENTER) {
        sele = 1;
    }
    else if (key == TAB) {
        sele = 2;
    }
    else if (key == ESC) {
        sele = 3;
    }
    else {
        sele = 0;
    }
}

public void formatting() {          //初期化
    head = 0;
    i = 0;
    ln = 0;             //行数を0にする
    px = PI / 6;          //
    pz = PI / 6;          //
    xx = PI / 6;          //
    zz = PI / 6;          //カメラの初期環境
    xc = 0;             //
    yc = 0;             //
    zc = 0;             //
    s = 0.7f;            //
}

public void makecsvfile() {         //csvファイルの作成
    file.println(start[0].x + "," + start[0].y + "," + start[0].z);
    file.flush();
    for (int o = 0; o < ln - 1; o++) {
        if (start[o + 1].x == end[o].x && start[o + 1].y == end[o].y && start[o + 1].z == end[o].z) {//終端と先端が一致するなら
            file.println(start[o + 1].x + "," + start[o + 1].y + "," + start[o + 1].z);
            file.flush();
        }
        else {
            file.println(end[o].x + "," + end[o].y + "," + end[o].z);
            file.println(jump + "," + jump + "," + jump);       //外れ値を出力
            file.println(start[o + 1].x + "," + start[o + 1].y + "," + start[o + 1].z);
            file.flush();
        }
    }
    file.println(end[ln - 1].x + "," + end[ln - 1].y + "," + end[ln - 1].z);
    file.flush();
    file.close();
}

public void startscreen() {         //初期画面
    camera(0,10,500, 0, 0, 0, 0, 0, -1);
    hint(DISABLE_DEPTH_TEST);
    fill(0);
    textFont(createFont("HG正楷書体-PRO", 110));
    textSize(54);
    text("ENTERキーを押して",0, 0);
    textAlign(CENTER,CENTER);
    hint(ENABLE_DEPTH_TEST);  // z軸を有効化
}

public void endscreen() {           //終了画面
    camera(0, 10, 500, xc, yc, 0, 0, 0, -1);
    background(255);
    hint(DISABLE_DEPTH_TEST);
    fill(0);
    textFont(createFont("HG正楷書体 - PRO", 110));
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
