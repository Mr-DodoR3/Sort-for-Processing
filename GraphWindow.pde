public class GraphWindow extends PApplet {
  private int[] arr;
  private boolean[] arr_check;
  private int move_bar;
  private int move_bar_2;
  private int len = 1;
  private boolean update = false;
  private String type = "bar";
  
  public void graphSetup(String atype) {
    type = atype;
  }
  
  public void setArray(int[] aarr, boolean[] aarr_check, int amove_bar, int amove_bar_2) {
    arr = aarr; 
    arr_check = aarr_check;
    move_bar = amove_bar;
    move_bar_2 = amove_bar_2;
    len = arr.length;
    update = true;
  }
  
  void settings() {
    size(500, 500);
  }
  
  void setup(){
    frameRate(120);
  }
  
  void draw() {
    if (update) {
      background(color_data[0][0], color_data[0][1], color_data[0][2]);
      fill(color_data[1][0], color_data[1][1], color_data[1][2]);
      //stroke(0);
      noStroke();
      for (int i = 0; i < len; i++) {
        float y = (float)arr[i] / (float)maxvalue * 500.0f;
        if (move_bar == i)
          fill(color_data[3][0], color_data[3][1], color_data[3][2]);
        else if (move_bar_2 == i)
          fill(color_data[4][0], color_data[4][1], color_data[4][2]);
        else if (arr_check[i])
          fill(color_data[2][0], color_data[2][1], color_data[2][2]);
        else
          fill(color_data[1][0], color_data[1][1], color_data[1][2]);
        if (type == "bar") {
          float w = (float)500 / (float)len;
          rect(i * w, 500 - y, w ,500);
        }
        else if (type == "scatter") {
          float w = (float)500 / (float)len;
          ellipse(i * w + (w/2), 500 - y, w < 2.0f ? 2.0f : w ,w < 2.0f ? 2.0f : w);
        }
        else if (type == "line") {
          float w = (float)500 / (float)len;
          stroke(255);
          strokeWeight(5);
          point(i * w, 500 - y);
          strokeWeight(1);
          if (i > 0) {
            float o_y = (float)arr[i-1] / (float)maxvalue * 500.0f;
            line((i-1) * w, 500 - o_y, i * w, 500 - y);
          }
        }
      }
      line(0, 500, 0, 500);
      update = false;
    }
  }
}
