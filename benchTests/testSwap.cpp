//
//  testSwap.cpp
//  benchTests
//
//  Created by gwh on 2023/1/29.
//

#include "Head.hpp"

using namespace std;

static void swap(int &a, int &b) {
    int temp = a;
    a = b;
    b = temp;
}

static void swap2(int *a, int *b) {
    int temp = *a;
    *a = *b;
    *b = temp;
}

static void swap3() {
    
}

static void testswap() {
    
    int a = 0, b = 4;
    
    swap(a,b);
    swap2(&a,&b);
    
    
}
