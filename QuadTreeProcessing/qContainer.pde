class qContainer {
  PApplet applet;
  int rows, cols;
  int[][] data,ndata;
  QuadTree root = null;
  boolean mdown, kdown,simulate = true,updateGrid,wait;
  ArrayList<Object> objects = new ArrayList<Object>();
  qContainer() {
  };

  qContainer(PApplet p) {
    applet = p;
    init();
    
  };

  void init() {
    clear();
    smooth();
    background(50);

    rows = applet.height / DEFAULT_SCALE;
    cols = applet.width / DEFAULT_SCALE;

    MAX_LEVELS = int((log(applet.width / DEFAULT_SCALE) / log(2)));
    RANDOM_OBJECTS = int(pow(MAX_LEVELS, 2) * MAX_OBJECTS) * 2;

    data = new int[rows][cols];

    if (root == null) {
      root = new QuadTree(1, 0, 0, cols, rows, MAX_OBJECTS, MAX_LEVELS, true,this);
      root.parent = this;
    } else {
      root.clear();
    }

    println("Logging for Grid [rows, cols] = " + rows + " , " + cols);
    println("Min. Level QuadTree: " + (rows / int(pow(2, MAX_LEVELS - 1))));
  };

  void draw() {
    //drawGrid();

    if (simulateQuadTrees) {
      root.simulate(root, DEFAULT_SCALE, MAX_LEVELS);
    } else {
      root.draw();
    }
    kPressed();
    mPressed();
    mDragged();
    if(!mdown&&!kdown&&!wait)updateGrid();
    //init();
    if(wait){
      println("wait");
      wait = false;
      
    }
  };
  
  public void update(){
    
  };

  void drawGrid() {
    noFill();
    stroke(70);

    for (int rowId=0; rowId<data.length; rowId++) {
      for (int colId=0; colId<data[0].length; colId++) {
        rect(colId * DEFAULT_SCALE, rowId * DEFAULT_SCALE, DEFAULT_SCALE, DEFAULT_SCALE);
      }
    }
  };

  void generateRandomObjects() {
    for (int i = 0; i < RANDOM_OBJECTS; i++) {
      data[int(random(0, rows))][int(random(0, cols))] = 1;
    }
    println("data gen");
    root.loadData(data);
  };
  
  void updateGrid(){
    //if(!updateGrid)
    for (int i = 0; i < objects.size(); i++) {
      Object o = objects.get(i);
      data[o.by][o.bx] = 0;
      if(o.x>-1&&o.x<data.length
      &&o.y>-1&&o.y<data[0].length)
      data[o.y][o.x] = 1;
      
    }
    //root.loadDataN(data);
    //println("hello");
    root.loadData2(objects);
    //updateGrid = true;
  };


  void kPressed() {
    if (keyPressed&&!kdown) {
      String keyAsString = str(key).toUpperCase();
      objects = new ArrayList<Object>();
      wait = true;
      if (keyAsString.equalsIgnoreCase("C")) { // Clear
        init();
      } else if (keyAsString.equalsIgnoreCase("R")) { // Generate random objects
        
        init();
        generateRandomObjects();
      } else if (key == CODED && keyCode == KeyEvent.VK_F2) { // Show or hide (simulate) QuadTrees
        simulateQuadTrees = !simulateQuadTrees;
      }
      kdown = false;
    }
    if (!keyPressed)kdown = false;
  };

  void mPressed() {
    if (mousePressed&&!mdown) {
      int colId = getSelectedCol(mouseX);
      int rowId = getSelectedRow(mouseY);

      if (colId == -1 || rowId == -1) {
        return;
      }

      data[rowId][colId] = 1;
      Object o = new Object(1, colId, rowId);
      o.parent = this;
      root.addObject(o);
      mdown = true;
    }
    if (!applet.mousePressed)mdown = false;
  };

  void mDragged() {
    if (mdown) {
      int colId = getSelectedCol(applet.mouseX);
      int rowId = getSelectedRow(applet.mouseY);

      if (colId == -1 || rowId == -1) {
        return;
      }

      data[rowId][colId] = 1;
      Object o = new Object(1, colId, rowId);
      o.parent = this;
      if(!root.objects.contains(o))root.addObject(o);
    };
  };

  boolean hasObject(int rowId, int colId) {
    return data[rowId][colId] == 1;
  };

  int getSelectedRow(int mouseY) {
    return mouseY >=0 && mouseY < applet.height ? mouseY / DEFAULT_SCALE : -1;
  };

  int getSelectedCol(int mouseX) {
    return mouseX >=0 && mouseX < applet.width ? mouseX / DEFAULT_SCALE : -1;
  };
};
