class SortTemplate {
  private int[] arr = new int[0];
  private int gI = 0;
  private int n;
  private String status = "sort";
  
  SortTemplate(int[] arg_arr) {
    gI = 0;
    n = arg_arr.length;
    arr = new int[n];
    for (int i = 0; i < n; i++)
      arr[i] = arg_arr[i];
  }
  
  private void swap(int x, int y) {
    int temp = arr[y];
    arr[y] = arr[x];
    arr[x] = temp;
  }
  
  private String array_draw(int[] draw_arr) {
    String str = "{";
    for (int i = 0; i < x.length; i++) {
      str += draw_arr[i] + (i == draw_arr.length - 1 ? "}" : ",");
    }
    return ("Array=" + str);
  }
  
  public String debugsort() {
    String s = "";
    return s;
  }
  
  private void counterControl() {
    
  }
  
  public void updateGraph() {
    
  }
  
  public int[] getArray() {
    return arr;
  }
}
