//
//  SortHeap.cpp
//  benchTests
//
//  Created by gwh on 2023/1/20.
//

//#include "HeapSort.hpp"

#include <iostream>
#include <vector>

using namespace::std;


class HeapSort {
    public:

    static void sort() {
//        heapSort();
    }
    
    static void sort2() {
        int arr[] = { 3,2,1,5,6,4};
        vector<int> v(arr, arr + sizeof(arr) / sizeof(arr[0]));
        
//        vector<int> result;
        v = headSort(v);
        
        for (const auto &i:v) {
            cout << i << ' ';
        }
        cout <<endl;
        
    }
    
    static void heapAdjust(vector<int> &list, int parent, int length){
        int temp = list[parent];                    // temp保存当前父节点
        int child = 2 * parent + 1;                    // 先获得左孩子
     
        while (child < length){
            // 如果有右孩子结点，并且右孩子结点的值大于左孩子结点，则选取右孩子结点
            if (child + 1 < length && list[child] > list[child + 1]){
                child++;
            }
     
            if (temp <= list[child]){
                break;
            }
     
            // 把孩子结点的值赋给父结点
            list[parent] = list[child];
     
            // 选取孩子结点的左孩子结点,继续向下筛选
            parent = child;
            child = 2 * parent + 1;
        }
        //2
//        while (2 * parent+1 < length){
//        }
        list[parent] = temp;
    }
     
    /*
     1. 将无需序列构建成一个堆，根据升序降序需求选择大顶堆或小顶堆;
     2. 将堆顶元素与末尾元素交换，将最大元素"沉"到数组末端;
     3. 重新调整结构，使其满足堆定义，然后继续交换堆顶元素与当前末尾元素，反复执行调整+交换步骤，直到整个序列有序。
     */
    static vector<int> headSort(vector<int> list){
        int length = list.size();
        // 循环建立初始堆
        for (int i = length / 2 - 1; i >= 0; i--){
            //最后一个非叶子节点开始
            heapAdjust(list, i, length);
        }
     
        // 进行n-1次循环，完成排序
        for (int i = length - 1; i > 0; i--){
            // 最后一个元素和第一元素进行交换
            int temp = list[i];
            list[i] = list[0];
            list[0] = temp;
            //2
//            swap(list[0], list[i]);
     
            // 筛选 R[0] 结点，得到i-1个结点的堆
            heapAdjust(list, 0, i);
            cout << "第" << length - i << "趟排序:";
            for (int i = 0; i < list.size(); i++){
                cout << list[i] << " ";
            }
            cout << endl;
        }
        return list;
    }
    
};

static void heapSort() {
//    printf("\n");
//
//    vector<int> v = {3, 2, 1, 5, 6, 4};
//    make_heap(v.begin(), v.end(), greater<int>());
//    sort_heap(v.begin(), v.end(), greater<int>());
//
//    cout <<endl<< "now sorted:   ";
//    for (const auto &i:v) {
//        cout << i << ' ';
//    }
//    cout <<endl;
//
//    printf("\n\n");
    
    HeapSort::sort2();
}


