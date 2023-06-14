class SelectSort extends SortTemplate {
  int A = 0, B = 0;
  SelectSort(int[] arg_arr) {
    super(arg_arr);
    // println(super.array_draw(select_sort()));
  }
  
  private int findmin(int[] arr, int standard) {
    int min = standard;
    for (int i = standard; i < arr.length; i++) {
      if (arr[i] < arr[min]) {
        min = i;
      }
    }
    
    return min;
  }
  
  //----------------------普通の選択ソート----------------------//
  private int[] select_sort() {
    int a=0,b=0;
    for(int i=0; i < super.n; i++){//大事なとこである
      b = i;
      for(int j = 1+i; j < super.n; j++){
        if(super.arr[j] < super.arr[b]){
          b = j;
        }
      }
      a = super.arr[i];
      super.arr[i] = super.arr[b];
      super.arr[b] = a;
    }
    
    return super.arr;
  }
  //----------------------普通の選択ソート----------------------//
  
  @Override
  public void updateGraph() {
    if (super.status == "sort") {
      //int a = 0, b = 0;
      //b = super.I;
      //for(int j = 1+super.I; j < super.n; j++){
      //  if(super.arr[j] < super.arr[b]){
      //    b = j;
      //  }
      //}
      //a = super.arr[super.I];
      //super.arr[super.I] = super.arr[b];
      //super.arr[b] = a;
      
      if(super.arr[super.J] < super.arr[B]){
        B = super.J;
      }
      super.move_bar = B;
      
      if (super.J < super.n-1) {
        super.J++;
        super.move_bar_2 = super.J;
      }
      else {
        A = super.arr[super.I];
        super.arr[super.I] = super.arr[B];
        super.arr[B] = A;
        
        super.arr_check[super.I] = true;
        super.I++;
        super.J = 1 + super.I;
        B = super.I;
      }
      if (!(super.I < super.n-1))
        super.endSort();
    }
  }
  
  @Override
  public String debugsort() {
    int[] debug_arr = select_sort();
    return super.array_draw(debug_arr);
  }
}
