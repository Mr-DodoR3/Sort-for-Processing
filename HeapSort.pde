class HeapSort extends SortTemplate {  
  HeapSort(int[] arg_arr) {
    super(arg_arr);
    super.I = super.n - 1;
    super.status = "build";
  }
  
  private boolean check_heap(int n) {
    for (int i = n - 1; i >= 0; i--) {
      if ((2*i+1) < n) {
        int p = 1;
        if ((2*i+2) < n)
          p = super.arr[2*i+1] > super.arr[2*i+2] ? 1 : 2;
        if (super.arr[i] < super.arr[2*i+p])
          return false;
      }
    }
    return true;
  }

  private int[] shift_down(int i, int n) {
    int p = 1;
    if ((2*i+2) < n) {
      p = super.arr[2*i+1] > super.arr[2*i+2] ? 1 : 2;
    }
    if (super.arr[i] < super.arr[2*i+p]) {
      int temp = super.arr[2*i+p];
      super.arr[2*i+p] = super.arr[i];
      super.arr[i] = temp;
    }
    
    return super.arr;
  }
  
  //----------------------普通のヒープソート----------------------//
  private int[] heap_build() {
    int n = super.arr.length;
    while(!check_heap(n)) {
      for (int i = n - 1; i >= 0; i--) {
        if ((2*i+1) < n)
          super.arr = shift_down(i, n);
      }
    }
    return super.arr;
  }
  private int[] heap_build(int n_set) {
    int n = n_set;
    while(!check_heap(n)) {
      for (int i = n - 1; i >= 0; i--) {
        if ((2*i+1) < n)
          super.arr = shift_down(i, n);
      }
    }
    return super.arr;
  }
  
  private int[] heap_sort() {
    int n = super.arr.length;
    for (int i = n - 1; i > 0; i--) {
      int temp = super.arr[0];
      super.arr[0] = super.arr[i];
      super.arr[i] = temp;
      super.arr = heap_build(i);
    }
    
    return super.arr;
  }
  //----------------------普通のヒープソート----------------------//
  
  @Override
  public void updateGraph() {
    if (super.status == "build") {
      if (check_heap(super.n)) {
        super.status = "sort";
        super.I = super.n - 1;
      }
      else {
        if ((2*super.I+1) < super.n)
          super.arr = shift_down(super.I, super.n);
        super.I--;
        if (super.I < 0)
          super.I = super.n - 1;
      }
    }
    else if (super.status == "sort") {
      super.swap(0, super.I);
      super.arr = heap_build(super.I);
      super.I--;
      if (super.I <= 0)
        super.status = "end";
    }
  }
  
  @Override
  public String debugsort() {
    int[] debug_arr = heap_sort();
    return super.array_draw(debug_arr);
  }
}
