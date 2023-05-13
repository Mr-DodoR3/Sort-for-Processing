import java.util.Random;

int arraylength = 200;
int[] x = new int[arraylength];
int[] heap_array = new int[arraylength];
int[] graph = new int[arraylength];
int scene = 0;
int graph_type = 0;
int sort_type = 0;
int input_focus = -1;

PFont japaneseFont;

GraphWindow gw;
SortTemplate[] sort = new SortTemplate[5];
ArrayList<Button> button = new ArrayList<>();


/*
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

private void array_draw(int[] arr) {
  String str = "{";
  for (int i = 0; i < x.length; i++) {
    str += arr[i] + (i == arr.length - 1 ? "}" : ",");
  }
  println("Array=" + str);
}
*/

private void gui() {
  if (scene == 0) {
    for (int i = 0; i < button.size(); i++) {
      button.get(i).update();
    }
  }
}

public void settings() {
  size(500, 500);
}

private void buttonsetup() {
  button.add(new Button("", 170, 420, 160, 30, "START"));
  String[] graphtype_name = { "棒グラフ", "散布図", "折れ線グラフ" };
  for (int i = 0; i < 3; i++) {
    button.add(new Button("radio", 40, 40 + i * 30, 20, 20, graphtype_name[i]));
    if (i == 0) button.get(i+1).check = true;
  }
  String[] sorttype_name = { "バブルソート", "選択ソート", "ヒープソート", "挿入ソート", "クイックソート" };
  for (int i = 0; i < 5; i++) {
    button.add(new Button("radio", 270, 40 + i * 30, 20, 20, sorttype_name[i]));
    if (i == 0) button.get(i+4).check = true;
  }
  button.add(new Button("textbox", 170, 350, 50, 30, ""));
}

public void setup() {
  frameRate(6000);
  japaneseFont = createFont("data/NotoSansJP-Medium.otf", 28);
  textFont(japaneseFont);
  
  Random random = new Random();
  for (int i = 0; i < x.length; i++) {
    x[i] = random.nextInt(0, 501);
  }
  
  sort[0] = new BubbleSort(x);
  sort[1] = new SelectSort(x);
  sort[2] = new HeapSort(x);
  sort[3] = new InsertionSort(x);
  sort[4] = new QuickSort(x);
  
  gw = new GraphWindow();
  buttonsetup();
}

public void draw() {
  background(255);
  gui();
  if (scene == 1) {
    sort[sort_type].updateGraph();
  }
  graph = sort[sort_type].getArray();
  gw.setArray(graph);
  //println(mouseX + "," + mouseY);
}

void mousePressed() {
  input_focus = -1;
  if (scene == 0) {
    for (int i = 0; i < button.size(); i++) {
      boolean c = button.get(i).click();
      if (c) {
        switch(i) {
          case 0:
            scene = 1;
            String[] args = {"--location=100,200","SecondApplet"};  
            PApplet.runSketch(args, gw);
            String[] graph_type_name = { "bar", "scatter", "line" };
            gw.graphSetup(graph_type_name[graph_type]);
            break;
          case 1:
          case 2:
          case 3:
            graph_type = i-1;
            for (int j = 0; j < 3; j++)
              button.get(j+1).check = graph_type == j ? true : false;
            break;
          case 4:
          case 5:
          case 6:
          case 7:
          case 8:
            sort_type = i-4;
            for (int j = 0; j < 5; j++)
              button.get(j+4).check = sort_type == j ? true : false;
            break;
          case 9:
            input_focus = 9;
            break;
        }
      }
      else if (button.get(i).type == "textbox"){}
        //button.get(i).check = false;
    }
  }
}

void keyPressed() {
  if (keyCode == 8) {
    if (button.get(input_focus).txt.length() > 0)
      button.get(input_focus).txt = button.get(input_focus).txt.substring(0, button.get(input_focus).txt.length()-1);
  }
  else {
    int a = int(key) - 48;
    if (a >= 0 && a <= input_focus) {
      button.get(9).txt += str(a);
    }
  }
}
