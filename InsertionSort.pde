class InsertionSort extends SortTemplate {
  InsertionSort(int[] arg_arr) {
    super(arg_arr);
    super.I = 1;
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
  
  //----------------------普通の選択ソート----------------------//
  private int[] insertion_sort() {
    int n = super.arr.length;
    for (int i = 1; i < n; i++) {
      for (int j = 0; j < i; j++) {
        if (super.arr[i] < super.arr[j]) {
          shift(j, i);
        }
      }
    }
    
    return super.arr;
  }
  //----------------------普通の選択ソート----------------------//
  
  @Override
  public void updateGraph() {
    if (super.status == "sort") {
      //for (int j = 0; j < super.I; j++) {
      //  if (super.arr[super.I] < super.arr[j]) {
      //    shift(j, super.I);
      //  }
      //}
      if (super.arr[super.I] < super.arr[super.J]) {
          shift(super.J, super.I);
      }
      super.move_bar = super.J;
      if (super.J < super.I) {
        super.J++;
      }
      else if (super.I < super.n - 1) {
        super.I++;
        super.J = 0;
      }
      else {
        super.status = "end";
      }
    }
  }
  
  @Override
  public String debugsort() {
    int[] debug_arr = insertion_sort();
    return super.array_draw(debug_arr);
  }
}
