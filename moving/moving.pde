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

float[][] MatrixI() {
  float [][] Mat = new float [4][4];
  Mat[0][0] = 1;
  Mat[1][1] = 1;
  Mat[2][2] = 1;
  Mat[3][3] = 1;
  return Mat;
}


float[][] MatrixRotateX(float a) {
  float [][] Mat = new float [4][4];
  Mat[0][0] = 1;
  Mat[1][1] = cos(a);
  Mat[1][2] = -sin(a);
  Mat[2][1] = sin(a);
  Mat[2][2] = cos(a);
  Mat[3][3] = 1;
  return Mat;
}

float[][] MatrixRotateY(float a) {
  float [][] Mat = new float [4][4];
  Mat[0][0] = cos(a);
  Mat[0][2] = sin(a);
  Mat[1][1] = 1;
  Mat[2][0] = -sin(a);
  Mat[2][2] = cos(a);
  Mat[3][3] = 1;
  return Mat;
}

float[][] MatrixRotateZ(float a) {
  float [][] Mat = new float [4][4];
  Mat[0][0] = cos(a);
  Mat[0][1] = -sin(a);
  Mat[1][0] = sin(a);
  Mat[1][1] = cos(a);
  Mat[2][2] = 1;
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

void draw(){;
  t += 1;
  background(255);
  translate(width/2, height/2);
  
  int s = 50;
  transformMatrix = MatrixI();
  float mat1[][] = MatrixRotateX(t*0.1);
  float mat2[][] = MatrixRotateY(t*0.1);
  transformMatrix = MatrixMul(mat2, transformMatrix);
  transformMatrix = MatrixMul(mat1, transformMatrix);

  Vector3D p1 = new Vector3D(-s, -s, s);
  Vector3D p2 = new Vector3D(-s, s, s);
  Vector3D p3 = new Vector3D(s, s, s);
  Vector3D p4 = new Vector3D(s, -s, s);
  Vector3D p5 = new Vector3D(-s, -s, -s);
  Vector3D p6 = new Vector3D(-s, s, -s);
  Vector3D p7 = new Vector3D(s, s, -s);
  Vector3D p8 = new Vector3D(s, -s, -s);
  stroke(0);
  strokeWeight(3);
  line3D(p1, p2);
  line3D(p2, p3);
  line3D(p3, p4);
  line3D(p4, p1);
  line3D(p5, p6);
  line3D(p6, p7);
  line3D(p7, p8);
  line3D(p8, p5);
  line3D(p1, p5);
  line3D(p2, p6);
  line3D(p3, p7);
  line3D(p4, p8);
}