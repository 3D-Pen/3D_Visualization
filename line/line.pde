float[][] MatrixMul(float A[][], float B[][]) {
  float [][] Mat = new float [4][4];
  for (int i=0; i<4; i++) {
    for (int j=0; j<4; j++) {
      for (int k=0; k<4; k++) {
        Mat[i][j] += A[i][k]*B[k][j];
      }
    }
  }
  return Mat;
}

float[][] Matrixreset() {
  float [][] Mat = new float [4][4];
  Mat[0][0] = 0;
  Mat[0][2] = 0;
  Mat[1][1] = 0;
  Mat[2][0] = 0;
  Mat[2][2] = 0;
  Mat[3][3] = 0;
  return Mat;
}

float[][] Matrixlinear(float a) {
  float [][] Mat = new float [4][4];
  Mat[0][0] = 2*a;
  Mat[0][2] = 2*a;
  Mat[1][1] = 1;
  Mat[2][0] = 2*a;
  Mat[2][2] = 2*a;
  Mat[3][3] = 1;
  return Mat;
}

float[][] MatrixMove(Vector3D v) {
  float [][] Mat = new float [4][4];
  Mat[0][0] = 1;
  Mat[1][1] = 1;
  Mat[2][2] = 1;
  Mat[3][3] = 1;
  Mat[0][3] = v.x;
  Mat[1][3] = v.y;
  Mat[2][3] = v.z;
  return Mat;
}

void printMatrix(float[][] mat) {
  for (int i=0; i<4; i++) {
    for (int j=0; j<4; j++) {
      print(mat[i][j]);
      print(", ");
    }
    print("\n");
  }
}

class Vector3D {
  float x, y, z;
  Vector3D(float _x, float _y, float _z) {
    this.x = _x;
    this.y = _y;
    this.z = _z;
  }
  Vector3D actMatrix(float Mat[][]) {
    Vector3D p = new Vector3D(0, 0, 0);
    p.x = this.x * Mat[0][0] + this.y * Mat[0][1] + this.z * Mat[0][2] + Mat[0][3];
    p.y = this.x * Mat[1][0] + this.y * Mat[1][1] + this.z * Mat[1][2] + Mat[1][3];
    p.z = this.x * Mat[2][0] + this.y * Mat[2][1] + this.z * Mat[2][2] + Mat[2][3];
    return p;
  }
}

float transformMatrix[][] = new float [4][4];
float t = 0;

void line3D(Vector3D p1, Vector3D p2) {
  Vector3D a1 = p1.actMatrix(transformMatrix);
  Vector3D a2 = p2.actMatrix(transformMatrix);
  //ellipse(a1.x, a1.y, 10, 10); 頂点
  //ellipse(a2.x, a2.y, 10, 10);
  line(a1.x, a1.y, a2.x, a2.y);
}

void setup() {
  size(750, 750);
  frameRate(50); // 50fpsでアニメーションする
}

void draw(){;
  t += 1;
  background(255);
  translate(width/2, height/2);
  
  int s = 100;
  // Remove the line that calls the undefined method
  // transformMatrix = MatrixI();
  float mat1[][] =Matrixlinear(t);
  float mat2[][] =  Matrixreset();
  transformMatrix = MatrixMul(mat2, transformMatrix);
  transformMatrix = MatrixMul(mat1, transformMatrix);

  Vector3D p1 = new Vector3D(-s, -s, s);
  Vector3D p2 = new Vector3D(s, -s, s);
  stroke(35);
  strokeWeight(3);
  line3D(p1, p2);
}
