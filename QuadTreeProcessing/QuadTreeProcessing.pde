
import java.awt.event.KeyEvent;

final int DEFAULT_SCALE = 4;
final int MAX_OBJECTS = 4;

int MAX_LEVELS;
int RANDOM_OBJECTS;

qContainer q;
boolean simulateQuadTrees = false;


void setup() {
  size(512, 512,FX2D);
  q = new qContainer(this);
}

void draw() {
  background(50);
  q.draw();
  fill(255);
  text(frameRate,200,200);
  text(q.objects.size(),200,220);
}
