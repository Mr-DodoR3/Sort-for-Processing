import java.util.Random;

int arraylength = 20;
int[] x = new int[arraylength];
int[] heap_array = new int[arraylength];
int[] graph = new int[arraylength];
int scene = 0;
int graph_type = 0;

PFont japaneseFont;

GraphWindow gw;
HeapSort hs;

private boolean check_heap(int[] arr, int n) {
  for (int i = n - 1; i >= 0; i--) {
    if ((2*i+1) < n) {
      int p = 1;
      if ((2*i+2) < n)
        p = arr[2*i+1] > arr[2*i+2] ? 1 : 2;
      if (arr[i] < arr[2*i+p])
        return false;
    }
  }
  return true;
}

private int[] shift_down(int[] arr, int i, int n) {
  int p = 1;
  if ((2*i+2) < n) {
    p = arr[2*i+1] > arr[2*i+2] ? 1 : 2;
  }
  if (arr[i] < arr[2*i+p]) {
    int temp = arr[2*i+p];
    arr[2*i+p] = arr[i];
    arr[i] = temp;
  }
  
  return arr;
}

private int[] heap_build(int[] arr) {
  int n = arr.length;
  while(!check_heap(arr, n)) {
    for (int i = n - 1; i >= 0; i--) {
      if ((2*i+1) < n)
        arr = shift_down(arr, i, n);
    }
  }
  return arr;
}
private int[] heap_build(int[] arr, int n_set) {
  int n = n_set;
  while(!check_heap(arr, n)) {
    for (int i = n - 1; i >= 0; i--) {
      if ((2*i+1) < n)
        arr = shift_down(arr, i, n);
    }
  }
  return arr;
}

private int[] heap_sort(int[] arr) {
  int n = arr.length;
  for (int i = n - 1; i > 0; i--) {
    int temp = arr[0];
    arr[0] = arr[i];
    arr[i] = temp;
    arr = heap_build(arr, i);
  }
  
  return arr;
}

private void array_draw(int[] arr) {
  String str = "{";
  for (int i = 0; i < x.length; i++) {
    str += arr[i] + (i == arr.length - 1 ? "}" : ",");
  }
  println("Array=" + str);
}

private int[] bubble(int[] arr) {
  for (int i = 0; i < arr.length - 1; i++) {
    for (int j = 0; j < arr.length - i - 1; j++) {
      if (arr[j] > arr[j+1]) {
        int temp = arr[j+1];
        arr[j+1] = arr[j];
        arr[j] = temp;
      }
    }
  }
  
  return arr;
}

private int findmin(int[] arr, int standard) {
  int min = standard;
  for (int i = standard; i < arr.length; i++) {
    if (arr[i] < arr[min]) {
      min = i;
    }
  }
  
  return min;
}

private int[] select(int[] arr) {
  for (int i = 0; i < arr.length - 1; i++) {
    int min = findmin(arr, i);
    if (i < min) {
      int temp = arr[min];
      arr[min] = arr[i];
      arr[i] = temp;
    }
  }
  
  return arr;
}

private void gui() {
  if (scene == 0) {
    fill(255);
    stroke(0);
    rect(120, 240, 160, 30);
    textAlign(CENTER);
    
    for (int i = 0; i < 3; i++)
      ellipse(140, 60 + i * 30, 20, 20);
    fill(50, 100, 255);
    noStroke();
    ellipse(140.5, 60.5 + graph_type * 30, 14, 14);
    
    fill(0);
    textSize(20);
    textAlign(CENTER);
    text("START", 200, 265);
    textAlign(LEFT);
    String[] buttonText = { "棒グラフ", "散布図", "折れ線グラフ" };
    for (int i = 0; i < 3; i++)
      text(buttonText[i], 160, 70 + i * 30);
  }
}

public void settings() {
  size(400, 300);
}

public void setup() {
  japaneseFont = createFont("data/NotoSansJP-Medium.otf", 28);
  textFont(japaneseFont);
  
  Random random = new Random();
  for (int i = 0; i < x.length; i++) {
    x[i] = random.nextInt(0, 501);
  }
  
  hs = new HeapSort(x);
  //graph = hs.fastsort();
  //array_draw(graph);
  
  gw = new GraphWindow();
}

public void draw() {
  background(255);
  gui();
  if (scene == 1)
    hs.updateGraph();
  graph = hs.getArray();
  gw.setArray(graph);
}

void mousePressed() {
  if (scene == 0) {
    if (mouseX > 120 && mouseX < 280) {
      for (int i = 0; i < 3; i++) {
        if (mouseY > 50 + i * 30 && mouseY < 70 + i * 30) {
          graph_type = i;
        }
      }
    }
    if (mouseX > 120 && mouseX < 280 && mouseY > 240 && mouseY < 270) {
      scene = 1;
      String[] args = {"--location=100,200","SecondApplet"};  
      PApplet.runSketch(args, gw);
      String[] graph_type_name = { "bar", "scatter", "line" };
      gw.graphSetup(graph_type_name[graph_type]);
    }
  }
}
