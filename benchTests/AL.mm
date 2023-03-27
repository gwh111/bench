//
//  AL.m
//  bench
//
//  Created by gwh on 2023/1/19.
//

#import <XCTest/XCTest.h>
#import "AL.h"

#include <iostream>
#include <vector>
#include <map>
#include <unordered_map>

#include "HeapSort.cpp"
//#include "testVector.cpp"
#include "testLinkList.cpp"
#include "testPermutations.cpp"
//#include "testCombinations.cpp"

#include "testLCSKMP.cpp"

#define MAXSIZE 10000

using namespace std;

typedef struct {
    int r[MAXSIZE+1];//r[0]哨兵
    int length;//表长度
}SQList;

void swap(SQList *L, int i, int j) {
    int temp = L->r[i];
    L->r[i] = L->r[j];
    L->r[j] = temp;
}

void print(SQList *L) {
    int i;
    for (i = 1; i <= L->length; i++) {
        printf("%d",L->r[i]);
    }
    printf("\n");
}

vector<int> twoSum(vector<int>& numbers, int target) {
    
    return {0};
};

void useMap() {
    
    map<int,int> list1;
    map<int,string> list2 =
    {{1,"java教程"},{2,"c++教程"},{3,"python教程"}};
    map<int,string> list3 =
        {pair<int,string> (1,"java教程"),pair<int,string> (2,"c++教程")};
  
    //两种方式添加元素
    list1.insert(pair<int,int> (1,15));
    list1.insert({2,13});
     
    //遍历整个list1
    for (auto iter = list1.begin(); iter != list1.end(); ++iter) {
        cout << iter->first << "  " << iter->second << endl;
    }
    
    //删除
    list1.erase(1);
    
    //修改
    list1[1] = 5;
    
    //其他
    map<string,int> map_1;
    map_1.clear();                //清除所有元素
    map_1.empty();                //如果为空返回1，负责返回0
    map_1.size();                 //返回容器的元素个数
    map_1.max_size();               //返回容器可以容纳的最大元素
     
    //可以用过迭代器与first，second访问元素
    string a = map_1.begin()->first;         //结果为容器的第一个元素的key值
    int b = map_1.begin()->second;         //结果为容器的第一个元素的value值
};

static int addTwo(int a, int b) {
    assert(a > 0);
    return a+b;
};

bool MySort(int a, int b) {
    return a > b;
}

void Display(int a) {
    cout << a << " ";
}

static void sort() {
    int num[10] = {6,5,9,1,2,8,7,3,4,0};
    sort(num,num+10,greater<int>());
    
    //第一种输出
    for(int i=0; i<10; i++){
        cout<<num[i]<<" ";
    }
    //第二种输出
    for_each(num, num+10, Display);
}

void test() {
    int res = 1;
    vector<int> v = {8, 6, 2, 1, 5, 10};
    string s = "12b";
    if (s[2] == 'b') {
        printf("bbb");
    }
    if (s[2] == 98) {
        printf("98");
    }
    
    
    printf("%d",s[2]);
}

int _main() {
    
    int v = addTwo(3, 4);
    printf("aaaaaaa%d",v);
    
    
    return 0;
}


@implementation AL

// 稳定 有没有改变相同元素的位置

/*
 冒泡排序 O(n2) 稳定
 [iOS开发中会用到的排序实现](https://www.jianshu.com/p/039ba9ad2a87)
 根据序列中两个元素的比较结果来对换这两个记录在序列中的位置，将键值较大的记录向序列的尾部移动，键值较小的记录向序列的前部移动。因此，每一趟都将较小的元素移到前面，较大的元素自然就逐渐沉到最后面了，也就是说，最大的元素最后才能确定，这就是冒泡。冒泡排序是一种稳定的排序算法。
 */
/*
 冒泡排序算法的改进
 1．设置一标志性变量pos,用于记录每趟排序中最后一次进行交换的位置。由于pos位置之后的记录均已交换到位,故在进行下一趟排序时只要扫描到pos位置即可。
 2．传统冒泡排序中每一趟排序操作只能找到一个最大值或最小值,我们考虑利用在每趟排序中进行正向和反向两遍冒泡的方法一次可以得到两个最终值(最大者和最小者) , 从而使排序趟数几乎减少了一半。
 */
+ (void)testBubbleSort {
    NSMutableArray *dataArr = [NSMutableArray arrayWithObjects:@1,@19,@2,@65,@876,@0,@63,@-1,@87,@100,@-5,@100,@333, nil];
    int flag = YES;
    for (int i = 0; i < dataArr.count && flag; ++i) {
        flag = NO;
        //遍历数组的每一个`索引`（不包括最后一个,因为比较的是j+1）
        for (int j = 0; j < dataArr.count-1; ++j) {
            //根据索引的`相邻两位`进行`比较`
            if ([dataArr[j] integerValue] > [dataArr[j+1] integerValue]) {
                [dataArr exchangeObjectAtIndex:j withObjectAtIndex:j+1];
                flag = YES;
            }
        }
    }
    NSLog(@"冒泡排序%@",dataArr);
}

/*
 选择排序 O(n2) 不稳定
 依次比较数组中前一个元素跟后一个元素的大小，来找到并记录最小的那个元素的下标，再与第一个元素交换。
 */
+ (void)testSelectSort {
    NSMutableArray *dataArr = [NSMutableArray arrayWithObjects:@1,@19,@2,@65,@876,@0,@63,@-1,@87,@100,@-5,@100,@333, nil];
    for (int i = 0; i< dataArr.count; i++) {
        int minIndex = i;
        for (int j = i + 1; j < dataArr.count; j++) {
            if (dataArr[j] < dataArr[minIndex]) {
                minIndex = j;
            }
        }
        [dataArr exchangeObjectAtIndex:i withObjectAtIndex:minIndex];
    }
}

/*
 直接插入排序 O(n2) 稳定
 当插入第i(i>=1)个元素时，前面的V[0],...,V[i-1]个元素已经有序。这时，将第i个元素和前i-1个元素V[i-1],...,V[0]依次比较，找到插入的位置即将V[i]插入，同时原来位置上的元素向后顺移。
 从第一个元素开始，认为该元素已经是排好序的。取下一个元素，在已经排好序的元素序列中从后向前扫描。如果已经排好序的序列中元素大于新元素，则将该元素往右移动一个位置。重复上一步骤，直到已排好序的元素小于或等于新元素。在当前位置插入新元素。重复"取下一个元素，在已经排好序的元素序列中从后向前扫描"过程。
 选择排序的内循环是遍历一组未排过序的数组。
 插入排序的内循环是遍历一组已排过序的数组。
 */
+ (void)testInsertSort {
    NSMutableArray *dataArr = [NSMutableArray arrayWithObjects:@1,@19,@2,@65,@876,@0,@63,@-1,@87,@100,@-5,@100, nil];
    // 时间复杂度O(n^2)
    // 控件复杂度O(1)
    // 稳定性： 稳定
    // 内部排序
    for (int i = 0; i < dataArr.count; i++) {
        for (int j = i; j > 0; j--) {
            if ([dataArr[j] intValue] < [dataArr[j - 1] intValue]) {
                [dataArr exchangeObjectAtIndex:j withObjectAtIndex:j-1];
            }
        }
    }
    NSLog(@"直接插入排序结果----%@",dataArr);
}

/*
 希尔排序 O(n1.5) O(n) ~ O(n^2)
 假设待排序的元素共 N 个元素，首先取一个整数 i<n 作为间隔，将全部元素分为间隔为 i 的 i 个子序列并对每个子序列进行直接插入排序。然后缩小间隔 i ，重复上述操作，直至 i 缩小为1，此时所有的元素位于同一个序列且有序。由于刚开始时 i 较大， 每个子序列元素较少，排序速度较快。后期 i 变小，每个子序列元素较多，但大部分元素有序，所以排序速度仍然较快。一般 i 取 i/2。 希尔排序是一种不稳定的排序算法。
 */
+ (void)testSellSort {
    NSMutableArray *dataArr = [NSMutableArray arrayWithObjects:@1,@19,@2,@65,@876,@0,@63,@-1,@87,@100,@-5,@100,@333, nil];
    //时间复杂度：O(n) ~ O(n^2)
    //空间复杂度：O(1)
    //稳定性：不稳定
    //内部排序
    int n = (int)dataArr.count;
    for (int gap = n / 2; gap > 0; gap /= 2){
        for (int i = gap; i < n; i++){
            for (int j = i - gap; j >= 0 && [dataArr[j] intValue] > [dataArr[j + gap] intValue]; j -= gap){
                [dataArr exchangeObjectAtIndex:j withObjectAtIndex:(j + gap)];
            }
        }
    }
    NSLog(@"----%@", dataArr);
}

+ (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    printf("\ntestExample start\n");
    // 显示C++编译器版本
    cout << __cplusplus << endl;
    
    _main();
    
    heapSort();
    
    test();
    
//    testvector();
    
//    arrToVector();
    
//    quickSort:sort();
    void testQuickSort();
    testQuickSort();
    
    testLinkList();
    
    //方法1：创建头文件
    testpermutations();
    
    //方法2：调用前声明函数
    void testcombinations();
    testcombinations();
    
    void testnqueens();
    testnqueens();
    
    testLCS c;
    c.KMP2("abcabc","cbaabc");
    
    void testmergeSort1();
    testmergeSort1();
    
    char ch;
    cin >> ch;
    cout << ch << endl;
    
    printf("\ntestExample end\n");
}

@end
