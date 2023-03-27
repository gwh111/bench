//
//  QuickSort.cpp
//  benchTests
//
//  Created by gwh on 2023/1/23.
//

#include "Head.hpp"

#include <stdio.h>

#include <iostream>
#include <vector>

using namespace::std;

void sort(int arr[], int begin, int end) {
    if (begin >= end) return;
    int left = begin;
    int right = end;
    int temp = arr[left];
 
    while (left < right) {
        //从后往前找比他小的放前面，从前往后找比它大的放后面
        //以第一个数为基准，必须先从后往前走，再从前往后走
        
        while (left < right && arr[right] >= temp) {
            right--;
        }  //跳出此循环，代表right找到了比temp小的数字，所以此时arr[left]=arr[right]
        if (left < right) {
            arr[left] = arr[right];
        }
        
        while (left < right && arr[left] <= temp) {
            left++;
        }
        if (left < right) {
            arr[right] = arr[left];
        }
        
        if (left == right) {
            arr[left] = temp;
        }
    }
    sort(arr, begin, left - 1);
    sort(arr, left + 1, end);

}

void testQuickSort(){
    int nums[5] = {1,6,4,5,2};
    sort(nums, 0, 5);
    
    for (int i = 0; i < 5; i++) {
        printf("q:%d",nums[i]);
    }
}

namespace quickSort {
    

    //双路快排
    // 对arr[l...r]部分进行partition操作
    // 返回p, 使得arr[l...p-1] < arr[p] ; arr[p+1...r] > arr[p]
    template <typename T>
    int _partition(T arr[], int l, int r){

        // 随机在arr[l...r]的范围中, 选择一个数值作为标定点pivot
        swap( arr[l] , arr[rand()%(r-l+1)+l] );

        T v = arr[l];
        int j = l;
        for( int i = l + 1 ; i <= r ; i ++ )
            if( arr[i] < v ){
                j ++;
                swap( arr[j] , arr[i] );
            }

        swap( arr[l] , arr[j]);

        return j;
    }

    // 双路快速排序的partition
    // 返回p, 使得arr[l...p-1] <= arr[p] ; arr[p+1...r] >= arr[p]
    // 双路快排处理的元素正好等于arr[p]的时候要注意，详见下面的注释：）
    template <typename T>
    int _partition2(T arr[], int l, int r){

        // 随机在arr[l...r]的范围中, 选择一个数值作为标定点pivot
        swap( arr[l] , arr[rand()%(r-l+1)+l] );
        T v = arr[l];

        // arr[l+1...i) <= v; arr(j...r] >= v
        int i = l+1, j = r;
        while( true ){
            // 注意这里的边界, arr[i] < v, 不能是arr[i] <= v
            // 思考一下为什么?
            while( i <= r && arr[i] < v )
                i ++;

            // 注意这里的边界, arr[j] > v, 不能是arr[j] >= v
            // 思考一下为什么?
            while( j >= l+1 && arr[j] > v )
                j --;

            // 对于上面的两个边界的设定, 有的同学在课程的问答区有很好的回答:)
            // 大家可以参考: http://coding.imooc.com/learn/questiondetail/4920.html

            if( i > j )
                break;

            swap( arr[i] , arr[j] );
            i ++;
            j --;
        }

        swap( arr[l] , arr[j]);

        return j;
    }

    // 对arr[l...r]部分进行快速排序
    template <typename T>
    void _quickSort(T arr[], int l, int r){

        // 对于小规模数组, 使用插入排序进行优化
        if( r - l <= 15 ){
            insertionSort(arr,l,r);
            return;
        }

        // 调用双路快速排序的partition
        int p = _partition2(arr, l, r);
        _quickSort(arr, l, p-1 );
        _quickSort(arr, p+1, r);
    }

    template <typename T>
    void quickSort(T arr[], int n){

        srand(time(NULL));
        _quickSort(arr, 0, n-1);
    }


    // 递归的三路快速排序算法
    template <typename T>
    void __quickSort3Ways(T arr[], int l, int r){

        // 对于小规模数组, 使用插入排序进行优化
        if( r - l <= 15 ){
            insertionSort(arr,l,r);
            return;
        }

        // 随机在arr[l...r]的范围中, 选择一个数值作为标定点pivot
        swap( arr[l], arr[rand()%(r-l+1)+l ] );

        T v = arr[l];

        int lt = l;     // arr[l+1...lt] < v
        int gt = r + 1; // arr[gt...r] > v
        int i = l+1;    // arr[lt+1...i) == v
        while( i < gt ){
            if( arr[i] < v ){
                swap( arr[i], arr[lt+1]);
                i ++;
                lt ++;
            }
            else if( arr[i] > v ){
                swap( arr[i], arr[gt-1]);
                gt --;
            }
            else{ // arr[i] == v
                i ++;
            }
        }

        swap( arr[l] , arr[lt] );

        __quickSort3Ways(arr, l, lt-1);
        __quickSort3Ways(arr, gt, r);
    }

    template <typename T>
    void quickSort3Ways(T arr[], int n){

        srand(time(NULL));
        __quickSort3Ways( arr, 0, n-1);
    }
}




