class SortTemplate {
  private int[] arr = new int[0];
  private int gI = 0;
  private int n;
  
  SortTemplate(int[] aarr) {
    n = aarr.length;
    arr = new int[n];
    for (int i = 0; i < n; i++)
      arr[i] = aarr[i];
  }
  
  private void swap(int x, int y) {
    int temp = arr[y];
    arr[y] = arr[x];
    arr[x] = temp;
  }
  
  public int[] fastsort() {
    return arr;
  }
  
  private void counterControl() {
    
  }
  
  public void updateGraph() {
    
  }
  
  public int[] getArray() {
    return arr;
  }
}
