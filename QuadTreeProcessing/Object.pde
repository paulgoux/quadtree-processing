
final int DEFAULT_SIZE = DEFAULT_SCALE;

class Object {
  qContainer parent;
  int value, id = -1, qid = -1;
  int x,bx;
  int y,by;


  Object(int id, int value, int x, int y) {
    id = id;
    this.value = value;
    this.x = x;
    this.y = y;
    bx = x;
    by = y;
  }

  Object(int value, int x, int y) {
    this.value = value;
    this.x = x;
    this.y = y;
    bx = x;
    by = y;
  }

  void draw(color colorForQuad) {
    fill(colorForQuad);
    stroke(255);

    ellipse(this.x * DEFAULT_SCALE, this.y * DEFAULT_SCALE, DEFAULT_SIZE, DEFAULT_SIZE);
    update();
  };
  
  void update(){
    x+= random(-1,2);
    y+= random(-1,2);
    //println("hhh", frameCount);
  };

  void log() {
    println("Logging Object for [value, x, y] = " + value + " , " + x + " , " + y);
  }
}
