int base_time = 0;      //一定時間ごとにmillis()を初期化
int NUM = 1000;         //描ける直線の総数
int i = 0;              //直線の数
PVector[] start = new PVector[NUM];     //直線の始まりの座標
PVector[] end = new PVector[NUM];       //直線の終わりの座標
String lin;             //テキストで読み込んだ任意の行の文字列
int ln;                 //行数
String lines[];         //テキスト全体を読み込む文字列

float xx;               //
float zz;               //
float px, pz;           //
float rotX,rotY,protY;  //マウスで座標を記録する値
float xc, yc, zc;       //
float pxc, pyc, pzc;    //
float s;                //


void setup() {
    size(800, 600, P3D);        //横800，縦600の3D
    stroke(255);                //線の色(黒色)
    hint(ENABLE_DEPTH_SORT);    //P3DレンダラとOPENGLレンダラにおいて、プリミティブなzソートを有効にする．(よく分からん)
    lights();                   //デフォルトの環境光
    PFont font = createFont("MS Mincho", 48, true);     //fontにMS明朝を代入
    textFont(font);             //フォントをMS明朝にする．
    textSize(54);               //テキストサイズを54
    frameRate(30);              //フレームレートを30
    ln = 0;                     //行数を0にする

    px = PI/6;          //
    pz = PI/6;          //
    xx = PI/6;          //
    zz = PI/6;          //カメラの初期環境
    xc = 0;             //
    yc = 0;             //
    zc = 0;             //
    s = 1;              //
}

void draw() {
    lines = loadStrings("pos.txt");     //pod.txtを読み込む
    background(0);                      //背景を黒にする
    translate(width/2, height/2,0);     //中心を決定
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

    int time = millis() - base_time;        //一定時間ごとにtimeを初期化
    if(ln == lines.length){
        return;             //読み込んだ行数が最終行なら最初に戻る
    }
    else{
        //何もしない
    }
    lin = lines[ln];        //linに任意の行の文字列を代入
    String[] co = split(lin, ',');      //コンマで区切ってcoに代入
    if(unhex(co[0]) == 65535){      //co[0]がFFFFなら
        if (time >= 200) {          //0.2秒ずつ
            if(i >= 1000){          //1000個以上直線を描いたら終了
                exit();
            }
            start[i] = new PVector(int(co[1]),int(co[2]),int(co[3]));
            end[i] = new PVector(int(co[4]),int(co[5]),int(co[6]));
            i++;
            ln++;       //1行増やす
            base_time = millis();
            }

    }
    else{
        //何もしない
    }
}
void mouseDragged(){            //マウスの割り込み
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

void mouseWheel(MouseEvent e){      //ホイールでサイズを変更
    float mw = e.getCount();
    if(mw == 1){
        s *= 0.9;
    }
    if(mw == -1){
        s *= 1.1;
    }   
}