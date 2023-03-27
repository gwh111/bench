//
//  testPriorityQueue.cpp
//  benchTests
//
//  Created by gwh on 2023/1/31.
//

#include <stdio.h>

#include "Head.hpp"

bool myCmp(int a, int b) {
    return a%10 > b%10;
}

static int testpriorityqueue() {
    
    srand(time(NULL));
    
    //第一种 最大堆
    priority_queue<int> pq;
    //第二种 从小最大 最小堆
    priority_queue<int , vector<int>, greater<int>> pq2;
    //第三组 自定义
    priority_queue<int , vector<int>, function<bool(int,int)>> pq3(myCmp);
    
    for (int i = 0; i < 10; i++) {
        pq.push(arc4random()%i);
    }
    
    while (!pq.empty()) {
        cout << pq.top() << " ";
        pq.pop();
    }
    
    cout << endl << endl;
    
    
    return 0;
};
