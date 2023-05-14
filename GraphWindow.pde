public class GraphWindow extends PApplet {
  private int[] arr;
  private int move_bar;
  private int len = 1;
  private boolean update = false;
  private String type = "bar";
  
  public void graphSetup(String atype) {
    type = atype;
  }
  
  public void setArray(int[] aarr, int amove_bar) {
    arr = aarr; 
    move_bar = amove_bar;
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
        if (move_bar == i)
          fill(color_data[3][0], color_data[3][1], color_data[3][2]);
        else
          fill(color_data[1][0], color_data[1][1], color_data[1][2]);
        float y = (float)arr[i] / (float)maxvalue * 500.0f;
        if (type == "bar") {
          float w = (float)500 / (float)len;
          rect(i * w, 500 - y, w ,500);
        }
        else if (type == "scatter") {
          float w = (float)500 / (float)len;
          ellipse(i * w + (w/2), 500 - arr[i], w < 2.0f ? 2.0f : w ,w < 2.0f ? 2.0f : w);
        }
        else if (type == "line") {
          float w = (float)500 / (float)len;
          stroke(255);
          strokeWeight(2);
          point(i * w, 500 - arr[i]);
          strokeWeight(1);
          if (i > 0)
            line((i-1) * w, 500 - arr[i-1], i * w, 500 - arr[i]);
        }
      }
      line(0, 500, 0, 500);
      update = false;
    }
  }
}
