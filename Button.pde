public class Button {
  private String type = "none";
  public int x, y, w, h;
  public String txt = "";
  public color fill_color = #ffffff;
  public boolean check_stroke = true;
  public color stroke_color = #000000;
  public color text_color = #000000;
  
  public boolean check = false;
  
  //public int selecter_num = 0;
  //public String[] selecter_txt;
  
  public boolean overmousepointer_anime = true;
  private boolean overmousepointer = false;
  
  Button(String atype, int ax, int ay, int aw, int ah, String atxt) {
    txt = atxt;
    setupdata(atype, ax, ay, aw, ah);
  }
  Button(String atype, int ax, int ay, int aw, int ah) {
    setupdata(atype, ax, ay, aw, ah);
  }
  
  private void setupdata(String arg_type, int ax, int ay, int aw, int ah) {
    type = arg_type;
    x = ax;
    y = ay;
    w = aw;
    h = ah;
  }
  
  private void getmousepointer() {
    switch(type) {
      case "radio":
        if (mouseX > x-w/2 && mouseX < x+w/2 && mouseY < y+h/2 && mouseY > y-h/2) {
          overmousepointer = true;
        }
        else {
          overmousepointer = false;
        }
        break;
      default:
        if (mouseX > x && mouseX < x + w && mouseY > y && mouseY < y + h) {
          overmousepointer = true;
        }
        else {
          overmousepointer = false;
        }
        break;
    }
  }
  
  public boolean click() {
    if (overmousepointer)
      return true;
    else
      return false;
  }
  
  public void update() {
    pushStyle();//デザイン関係の保存（色など）
    
    fill(fill_color);
    if (!check_stroke)
      noStroke();
    else
      stroke(stroke_color);
    
    switch(type) {
      case "radio":
        ellipse(x, y, w, h);
        if (check) {
          noStroke();
          fill(50, 100, 255);
          ellipse(x, y, w*0.8, h*0.8);
        }
        else if (overmousepointer && overmousepointer_anime) {
          noStroke();
          fill(50, 100, 255, 100);
          ellipse(x, y, w*0.8, h*0.8);
        }
        textSize(h);
        noStroke();
        fill(text_color);
        textAlign(LEFT);
        text(txt, x+w, y+h/2.5);
        break;
      case "textbox":
        if (check)
          rect(x-2, y-2, w+4, h+4);
        stroke(0);
        fill(255);
        rect(x, y, w, h);
        textSize(h-15);
        noStroke();
        fill(text_color);
        textAlign(RIGHT);
        text(txt, x+(w/9)*10, y+(h/4)*3);//+(w/7)*3
        break;
      default:
        if (overmousepointer && overmousepointer_anime)
          rect(x-2, y-2, w+4, h+4);
        rect(x, y, w, h);
        textSize(h-10);
        noStroke();
        fill(text_color);
        textAlign(CENTER);
        text(txt, x+w/2, y+(h/4)*3);
        break;
    }
    getmousepointer();
    popStyle();//デザイン関係の保存（色など）
  }
}
