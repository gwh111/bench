//
//  testVector.cpp
//  benchTests
//
//  Created by gwh on 2023/1/28.
//

#include <stdio.h>
#include <iostream>
#include <vector>
#include <map>
#include <unordered_map>

using namespace std;

static void printvector_vi(vector<int> &v) {
    cout << "v=" << ' ';
    for (const auto &i:v) {
        cout << i << ' ';
    }
    cout << "v=end" << endl;
};

static void printvector_vvs(vector<vector<string>> &v) {
    cout << "v=" << ' ';
    for (const auto &i:v) {
        for (const auto &m:i) {
            cout << m << ' ';
            cout << "v=end1" << endl;
        }
        cout << "v=end2" << endl;
    }
    cout << "v=end" << endl;
};

static void arrToVector() {
//    const int arr_size = 5;
    int arr[] = {1,2,3,4,5};
    int arr_size = sizeof (arr) / sizeof (arr[0]);
    
    // 第一种方式
    vector<int> vec(arr, arr+arr_size); // 从array数组向vector向量复制元素
    for (int i=0; i<vec.size(); i++)
    {
        cout << "t=" << vec[i] << endl;
    }

    // 第二种方式
    vector<int> vec2;
    for (size_t i=0; i<arr_size; i++)
    {
        vec2.push_back(arr[i]); // 逐个复制
        cout << vec2[i] << " ";
    }
}

static void testvector() {
    
    int arr[10] = {1,2,3,4,5};
    vector<int> vt{1,2,3};
    cout << vt[0] << endl;

    //第一种打印
    for (auto it = vt.begin(); it != vt.end(); it++) {
//        vt.erase(it++);//迭代器失效问题
//        vt.insert(vt.begin()+1, 2, 1);
        cout << *it << endl;
    }
    
    //第二种打印
    for (int i = 0; i < vt.size(); i++) {
        cout << vt[i] << endl;
    }
    
    //第三种打印
    for (const auto &i:vt) {
        cout << i << ' ';
    }
    
    arrToVector();
}
