class QuickSort extends SortTemplate {
  QuickSort(int[] arg_arr) {
    super(arg_arr);
    println(super.array_draw(quick_sort()));
  }
  
  private void shift(int shift_point_lower, int shift_point_upper) {
    int l = shift_point_lower;
    int u = shift_point_upper;
    int temp = super.arr[u];
    
    for (int i = u; i > l; i--) {
      super.arr[i] = super.arr[i-1];
    }
    super.arr[l] = temp;
  }
  
  //----------------------普通のクイックソート----------------------//
  private int[] quick_sort() {
    int standard = super.arr[floor(super.arr.length/2)];
    
    
    return super.arr;
  }
  //----------------------普通のクイックソート----------------------//
  
  @Override
  public void updateGraph() {
    if (super.status == "sort") {
      for (int j = 0; j < super.I; j++) {
        if (super.arr[super.I] < super.arr[j]) {
          shift(j, super.I);
        }
      }
      if (super.I < super.n - 1)
        super.I++;
      else
        super.status = "end";
    }
  }
  
  @Override
  public String debugsort() {
    int[] debug_arr = quick_sort();
    return super.array_draw(debug_arr);
  }
}
