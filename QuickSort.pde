class QuickSort extends SortTemplate {
  int len = super.arr.length;
  int low, high, pos;
  int lowPar, highPar, pivot;
  ArrayList<Integer> stack_low = new ArrayList<Integer>();
  ArrayList<Integer> stack_high = new ArrayList<Integer>();
  
  QuickSort(int[] arg_arr) {
    super(arg_arr);
    stack_low.add(0);
    stack_high.add(len - 1);
  }
  
  //----------------------普通のクイックソート----------------------//
  private int upper_search(int nowpos, int pivot, int right) {
    if (nowpos == pivot)
      return pivot;
    int pivot_val = super.arr[pivot];
    for (int i = nowpos; i <= right; i++)
      if (pivot_val <= super.arr[i])
        return i;
        
    return pivot;
  }
  private int lower_search(int nowpos, int pivot, int left) {
    if (nowpos == pivot)
      return pivot;
    int pivot_val = super.arr[pivot];
    for (int i = nowpos; i >= left; i--)
      if (pivot_val >= super.arr[i])
        return i;
        
    return pivot;
  }
  
  private int[] quick_sort(int left, int right) {
    int len = right - left + 1;
    int pivot = floor(len/2) + left;
    int str_upper = left;
    int str_lower = right;
    
    if (left < right) {
      //System.out.println("pivot:" + super.arr[pivot] + ", left:" + left + ", right:" + right + ", " + super.array_draw(super.arr));
      while (true) {
        str_upper = upper_search(str_upper, pivot, right); //<>//
        str_lower = lower_search(str_lower, pivot, left); //<>//
        if (str_lower <= str_upper)
          break;
        else {
          if (str_lower == pivot) {
            pivot = str_upper; //<>//
          }
          else if (str_upper == pivot) {
            pivot = str_lower; //<>//
          }
          super.swap(str_lower, str_upper); //<>//
          str_lower = str_lower > pivot ? str_lower - 1 : pivot;
          str_upper = str_upper < pivot ? str_upper + 1 : pivot;
        }
      }
      quick_sort(left, pivot - 1);
      quick_sort(pivot + 1, right);
    }
    
    return super.arr;
  }
  //----------------------普通のクイックソート----------------------//
  
  //----------------------再起処理をしないクイックソート----------------------//
  private int partition(int low, int high) {
    int i = low;
    int j = high;
    //int pivot = high;
    int pivot = floor((high + low) / 2);
    while (i < j) {
      while (super.arr[i] < super.arr[pivot]) {
        i++;
      }
        //println(j);
      while (super.arr[j] > super.arr[pivot]) {
        j--;
      }
      if (i <= j) {
        println("swap"+i+","+j);
        //println("pivot1:"+pivot);
        super.swap(i, j);
        if (pivot == i) { pivot = j; }
        else if (pivot == j)  { j--; pivot = i; }
        else { i++; }
        //println("pivot2:"+pivot);
        println(super.array_draw(super.arr));
      }
    }
    
    //if (super.arr[i] > super.arr[pivot]) {
    //    println("Xswap"+i+","+j);
    //  if (pivot == i) pivot = high;
    //  else if (pivot == high) pivot = i;
    //  super.swap(i, high);
    //  println(super.array_draw(super.arr));
    //}
    
    return pivot;
  }
  
  private int[] quick_sort_noreturn() {
    int len = super.arr.length;
    ArrayList<Integer> stack_low = new ArrayList<Integer>();
    ArrayList<Integer> stack_high = new ArrayList<Integer>();
    stack_low.add(0);
    stack_high.add(len - 1);
    
    while (stack_low.size() > 0) {
      int low = stack_low.get(stack_low.size() - 1);
      stack_low.remove(stack_low.size() - 1);
      int high = stack_high.get(stack_high.size() - 1);
      stack_high.remove(stack_high.size() - 1);
      //System.out.println("low:" + low);
      //System.out.println("high:" + high);
      if (low < high) {
        int pos = partition(low, high);
        System.out.println("pos:" + pos);
        if (pos - low < high - pos) {
          stack_low.add(pos+1);
          stack_high.add(high);
          stack_low.add(low);
          stack_high.add(pos-1);
        }
        else {
          stack_low.add(low);
          stack_high.add(pos-1);
          stack_low.add(pos+1);
          stack_high.add(high);
        }
        //println(super.array_draw(super.arr));
      }
    }
    
    return super.arr;
  }
  //----------------------再起処理をしないクイックソート----------------------//
  
  @Override
  public void updateGraph() {
    if (super.status == "sort")
      if (stack_low.size() > 0) {
        low = stack_low.get(stack_low.size() - 1);
        stack_low.remove(stack_low.size() - 1);
        high = stack_high.get(stack_high.size() - 1);
        stack_high.remove(stack_high.size() - 1);
        if (low < high) {
          lowPar = low;
          highPar = high;
          int max = highPar;
          int min = lowPar;
          int cen = floor((highPar + lowPar) / 2);
          if (min < max && max < cen || cen < max && max < min) pivot = max;
          else if (max < min && min < cen || cen < min && min < max) pivot = min;
          else pivot = cen;
          //pivot = floor((highPar + lowPar) / 2);
          super.status = "partition";
        }
      }
      else {
        super.endSort();
      }
    else if (super.status == "partition") {
      super.move_bar = lowPar;
      super.move_bar_2 = highPar;
      if (highPar - lowPar < 3) {
        super.arr_check[high] = true;
        super.arr_check[low] = true;
        super.arr_check[pivot] = true;
      }
      if (lowPar < highPar) {
        while (super.arr[lowPar] < super.arr[pivot]) {
          lowPar++;
        }
          //println(j);
        while (super.arr[highPar] > super.arr[pivot]) {
          highPar--;
        }
        if (lowPar <= highPar) {
          super.swap(lowPar, highPar);
          if (pivot == lowPar) { pivot = highPar; }
          else if (pivot == highPar)  { highPar--; pivot = lowPar; }
          else { lowPar++; }
        }
      }
      else {
        super.status = "sort";
        pos = pivot;
        if (pos - low < high - pos) {
          stack_low.add(pos+1);
          stack_high.add(high);
          stack_low.add(low);
          stack_high.add(pos-1);
        }
        else {
          stack_low.add(low);
          stack_high.add(pos-1);
          stack_low.add(pos+1);
          stack_high.add(high);
        }
      }
    }
  }
  
  @Override
  public String debugsort() {
    println(super.array_draw(super.arr));
    int[] debug_arr = quick_sort_noreturn();
    return super.array_draw(debug_arr);
  }
}
