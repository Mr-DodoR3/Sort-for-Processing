import java.util.Random;
import java.util.List;
import java.util.ArrayList;

int arraylength = 100;
int maxvalue = 500;
int[] x;
int[] graph;
boolean[] graph_check;
int move_bar = -1;
int move_bar_2 = -1;
int scene = 0;
int graph_type = 0;
int sort_type = 0;
int input_focus = -1;
int framerate = 6000;
int[][] color_data = {
  { 0, 0, 0 },
  { 255, 255, 255 },
  { 225, 225, 225 },
  { 255, 0, 0 },
  { 0, 0, 255 }
};
int[] test_array = { 5, 0, 9, 7, 1, 6, 3, 8, 4, 2 };

PFont japaneseFont;

GraphWindow gw;
SortTemplate[] sort = new SortTemplate[5];
ArrayList<Button> button = new ArrayList<>();

private void gui() {
  if (scene == 0) {
    for (int i = 0; i < button.size(); i++) {
      button.get(i).update();
    }
  }
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
  String[] settings_name = { "データ数", "最大値", "速度倍率" };
  String[] settings_first_value = { "100", "500", "10" };
  for (int i = 0; i < 3; i++) {
    button.add(new Button("textbox", 100, 280 + 40 * i, 50, 30, settings_name[i]));
    button.get(button.size()-1).value = settings_first_value[i];
  }
  String[] graph_color = { "背景色", "グラフ色(通常)", "グラフ色(終了)", "グラフ色(選択)", "グラフ色(予備)" };
  for (int i = 0; i < 5; i++) {
    button.add(new Button("colorbox", 250, 290 + 14 * i, 200, 12, graph_color[i]));
  }
  String[] rgb_settings = { "RED", "GREEN", "BLUE" };
  for (int i = 0; i < 3; i++) {
    button.add(new Button("textbox", 190 + 80 * i, 370, 30, 25, rgb_settings[i]));
    button.get(button.size()-1).value = "255";
  }
  button.add(new Button("", 400, 370, 60, 25, "色適応"));
}

void resetArray(int arrsize, int valsize) {
  arraylength = arrsize;
  maxvalue = valsize;
  x = new int[arraylength];
  //x = new int[10];
  graph = new int[10];
  graph_check = new boolean[arraylength];

  Random random = new Random();
  int[] setdata = { 49,64,377,311,484,305,492,358,191,82 };
  for (int i = 0; i < x.length; i++) {
    x[i] = random.nextInt(1, valsize + 1);
    //x[i] = setdata[i];
  }
  
  sort[0] = new BubbleSort(x);
  sort[1] = new SelectSort(x);
  sort[2] = new HeapSort(x);
  sort[3] = new InsertionSort(x);
  sort[4] = new QuickSort(x);
  //System.out.println(sort[4].debugsort());
}

private void color_set(int bar_num) {
  button.get(12 + bar_num).fill_color = color(color_data[bar_num][0], color_data[bar_num][1], color_data[bar_num][2]);
}

public void settings() {
  size(500, 500);
}

public void setup() {
  frameRate(60);
  japaneseFont = createFont("data/NotoSansJP-Medium.otf", 28);
  textFont(japaneseFont);
  
  gw = new GraphWindow();
  buttonsetup();
  for (int i = 0; i < 5; i++)
    color_set(i);
}

public void draw() {
  //println(mouseX + "," + mouseY);
  background(255);
  gui();
  if (scene == 1) {
    sort[sort_type].updateGraph();
    graph = sort[sort_type].getArray();
    graph_check = sort[sort_type].getcheckArray();
    move_bar = sort[sort_type].getmove();
    move_bar_2 = sort[sort_type].getmove_2();
    gw.setArray(graph, graph_check, move_bar, move_bar_2);
  }
  //println(mouseX + "," + mouseY);
}

void mousePressed() {
  int old_input_focus = input_focus;
  input_focus = -1;
  if (scene == 0) {
    for (int i = 0; i < button.size(); i++) {
      boolean c = button.get(i).click();
      if (c) {
        switch(i) {
          case 0:
            int array_size = button.get(9).get_value_int();
            int array_value = button.get(10).get_value_int();
            frameRate(60 * button.get(11).get_value_int());
            resetArray(array_size, array_value);
            scene = 1;
            
            String[] args = {"--location=100,200","SecondApplet"};  
            PApplet.runSketch(args, gw);
            String[] graph_type_name = { "bar", "scatter", "line" };
            gw.graphSetup(graph_type_name[graph_type]);
            //frameRate(framerate);
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
          case 10:
          case 11:
          case 12:
          case 13:
          case 14:
          case 15:
          case 16:
          case 17:
          case 18:
          case 19:
            button.get(i).check = true;
            input_focus = i;
            break;
          case 20:
            if (!(old_input_focus == -1)) {
              if (button.get(old_input_focus).type == "colorbox") {
                int bar_color_num = old_input_focus - 12;
                color_data[bar_color_num][0] = button.get(17).get_value_int();
                println(button.get(17).get_value_int());
                color_data[bar_color_num][1] = button.get(18).get_value_int();
                color_data[bar_color_num][2] = button.get(19).get_value_int();
                color_set(bar_color_num);
              }
            }
            break;
        }
      }
      else if ((button.get(i).type == "textbox" || button.get(i).type == "colorbox") && button.get(i).check) {
        button.get(i).check = false;
        switch(i) {
          case 9:
            if (int(button.get(i).value) < 1)
              button.get(i).value = "1";
            else if (int(button.get(i).value) > 1000)
              button.get(i).value = "1000";
            break;
          case 10:
            if (int(button.get(i).value) < 1)
              button.get(i).value = "1";
            else if (int(button.get(i).value) > 1000)
              button.get(i).value = "1000";
            break;
          case 11:
            if (int(button.get(i).value) < 1)
              button.get(i).value = "1";
            else if (int(button.get(i).value) > 200)
              button.get(i).value = "200";
            break;
          case 17:
          case 18:
          case 19:
            if (int(button.get(i).value) < 0 || button.get(i).value == "")
              button.get(i).value = "0";
            else if (int(button.get(i).value) > 255)
              button.get(i).value = "255";
            break;
        }
      }
    }
  }
}

void keyPressed() {
  if (!(input_focus == -1)) {
    if (button.get(input_focus).type == "textbox") {
      int cursor =  button.get(input_focus).value.length() - button.get(input_focus).get_insert();
      if (keyCode == 8) {
        if (button.get(input_focus).value.length() > 0 && cursor - 1 >= 0)
          button.get(input_focus).value = button.get(input_focus).value.substring(0, cursor-1) + button.get(input_focus).value.substring(cursor, button.get(input_focus).value.length());
      }
      else if (keyCode == 37) {
        button.get(input_focus).shift_cursor_left();
      }
      else if (keyCode == 39) {
        button.get(input_focus).shift_cursor_right();
      }
      else {
        int a = int(key) - 48;
        if (a >= 0 && a <= 9) {
          //button.get(input_focus).value = button.get(input_focus).value + str(a);
          button.get(input_focus).value = button.get(input_focus).value.substring(0, cursor) + str(a) + button.get(input_focus).value.substring(cursor, button.get(input_focus).value.length());
        }
      }
    }
  }
}
