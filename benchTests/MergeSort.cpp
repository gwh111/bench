//
//  MergeSort.cpp
//  benchTests
//
//  Created by gwh on 2023/2/22.
//

#include <stdio.h>
#include "Head.hpp"
#include "testVector.cpp"

// 将arr[l...mid]和arr[mid+1...r]两部分进行归并
template<typename  T>
void __merge(T arr[], int l, int mid, int r){

    //* VS不支持动态长度数组, 即不能使用 T aux[r-l+1]的方式申请aux的空间
    //* 使用VS的同学, 请使用new的方式申请aux空间
    //* 使用new申请空间, 不要忘了在__merge函数的最后, delete掉申请的空间:)
    T aux[r-l+1];
    //T *aux = new T[r-l+1];
    for( int i = l ; i <= r; i ++ )
        aux[i-l] = arr[i];
    // 初始化，i指向左半部分的起始索引位置l；j指向右半部分起始索引位置mid+1
    int i = l, j = mid+1;
    for( int k = l ; k <= r; k ++ ){
        if( i > mid ){  // 如果左半部分元素已经全部处理完毕
            arr[k] = aux[j-l]; j ++;
        }
        else if( j > r ){  // 如果右半部分元素已经全部处理完毕
            arr[k] = aux[i-l]; i ++;
        }
        else if( aux[i-l] < aux[j-l] ) {  // 左半部分所指元素 < 右半部分所指元素
            arr[k] = aux[i-l]; i ++;
        }
        else{  // 左半部分所指元素 >= 右半部分所指元素
            arr[k] = aux[j-l]; j ++;
        }
    }
    //delete[] aux;
}

// 递归使用归并排序,对arr[l...r]的范围进行排序
template<typename T>
void __mergeSort(T arr[], int l, int r){
    if( l >= r )
        return;
    int mid = (l+r)/2;
    __mergeSort(arr, l, mid);
    __mergeSort(arr, mid+1, r);
    
//    if (arr[mid] > arr[mid+1]) {
        __merge(arr, l, mid, r);
//    }
}

template<typename T>
void mergeSort1(T arr[], int n){
    __mergeSort( arr , 0 , n-1 );
}

// 使用自底向上的归并排序算法
template <typename T>
void mergeSortBU(T arr[], int n){

    // Merge Sort Bottom Up 无优化版本
    //没有使用arr[n]，可以用于链表排序
//    for( int sz = 1; sz < n ; sz += sz )
//        for( int i = 0 ; i < n - sz ; i += sz+sz )
//            // 对 arr[i...i+sz-1] 和 arr[i+sz...i+2*sz-1] 进行归并
//            __merge(arr, i, i+sz-1, min(i+sz+sz-1,n-1) );


    // Merge Sort Bottom Up 优化
    // 对于小数组, 使用插入排序优化
    for( int i = 0 ; i < n ; i += 16 )
        insertionSort(arr,i,min(i+15,n-1));

    for( int sz = 16; sz < n ; sz += sz )
        for( int i = 0 ; i < n - sz ; i += sz+sz )
            // 对于arr[mid] <= arr[mid+1]的情况,不进行merge
            if( arr[i+sz-1] > arr[i+sz] )
                __merge(arr, i, i+sz-1, min(i+sz+sz-1,n-1) );

    // Merge Sort BU 也是一个O(nlogn)复杂度的算法，虽然只使用两重for循环
    // 所以，Merge Sort BU也可以在1秒之内轻松处理100万数量级的数据
    // 注意：不要轻易根据循环层数来判断算法的复杂度，Merge Sort BU就是一个反例
    // 关于这部分陷阱，推荐看我的《玩转算法面试》课程，第二章：《面试中的复杂度分析》：）

}

void testmergeSort1() {
    printf("\ntestLinkList start\n");

    int arr[] = {3,2,3,4,5};
    int n = sizeof(arr)/sizeof((arr[0]));
    mergeSort1(arr, n);
    for (int i = 0; i < n; i++) {
        printf("meger=%d",arr[i]);
    }
    
}
