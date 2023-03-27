//
//  testFib.cpp
//  benchTests
//
//  Created by gwh on 2023/1/29.
//

#include <stdio.h>
#include "Head.hpp"

//斐波那契数列
//记忆化搜索
int g_a[1000];

int Fib4(int n) {
    
    assert(n >= 0);
    g_a[0] = 0;
    g_a[1] = 1;
    for (int i = 2; i < n; i++) {
        if (g_a[i] == 0) {
            g_a[i] = g_a[i-1]+g_a[i-2];
        }
    }
    
    return g_a[n];
}

int Fib42(int n) {
    
    assert(n >= 0);
    int dp[50];
    dp[0] = 1;
    dp[1] = 1;
    for (int i = 2; i <= n; i++) {
        dp[i] = dp[i-1]+dp[i-2];
    }
    
    return dp[n];
}

int Fib43(int n) {
    
    assert(n >= 0);
    int a = 1;
    int b = 1;
    int c = 1;
    for (int i = 2; i <= n; i++) {
        c = a+b;
        a = b;
        b = c;
    }
    
    return c;
}
