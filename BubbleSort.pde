class BubbleSort extends SortTemplate {
  BubbleSort(int[] arg_arr) {
    super(arg_arr);
    // println(super.array_draw(bubble_sort()));
  }
  
  //----------------------普通のバブルソート----------------------//
  private int[] bubble_sort() {
    for(int j = 0; j < super.arr.length-1; j++){//一番大事なとこ
      for(int i = 0; i < super.arr.length-1 - j; i++){
        if(super.arr[i] > super.arr[i+1]){
          super.swap(i, i+1);
        }
      }
    }
    
    return super.arr;
  }
  //----------------------普通のバブルソート----------------------//
  
  @Override
  public void updateGraph() {
    if (super.status == "sort") {
      //for (int j = 0; j < super.arr.length -1 - super.I; j++) {
      //  if (super.arr[j] > super.arr[j+1]) {
      //    shift(j, j+1);
      //  }
      //}
      if (super.arr.length > 1) {
        if (super.arr[super.J] > super.arr[super.J+1]) {
          super.swap(super.J, super.J+1);
        }
        if (super.J < super.n - 2 - super.I) {
          super.J++;
        }
        else {
          super.I++;
          super.J = 0;
        }
      }
      super.move_bar = super.J;
      if (!(super.I < super.n - 1))
        super.status = "end";
    }
  }
  
  @Override
  public String debugsort() {
    int[] debug_arr = bubble_sort();
    return super.array_draw(debug_arr);
  }
}
