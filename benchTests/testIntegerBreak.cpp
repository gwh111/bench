//
//  testIntegerBreak.cpp
//  benchTests
//
//  Created by gwh on 2023/2/1.
//

#include <stdio.h>

#include "Head.hpp"
#include "testVector.cpp"

class testIntegerBreak {
private:
    vector<int> memo;
    
    int max3(int a, int b, int c) {
        return max(a,max(b,c));
    }
    //递归 从大到小考虑
    int integerBreak(int n) {
        if (n == 1) {
            return 1;
        }
        if (memo[n] != -1) {
            return memo[n];
        }
        int res = -1;
        for (int i = 1; i < n; i++) {
            res = max3(res,i*(n-i),i*integerBreak(n-i));
        }
        memo[n] = res;
        return res;
    }
    
    //优化：动态规划 去递归 从小到大
    int integerBreak2(int n) {
        if (n == 1) {
            return 1;
        }
        
        vector<int>memo(n+1,-1);
        
        memo[1] = 1;
        for (int i = 2; i <= n; i++) {
            for (int m = 1; m <= i-1; m++) {
                memo[i] = max3(memo[i],m*(i-m),m*memo[i-m]);
            }
        }
        return memo[n];
    }
public:
    //将n分割，获得最大乘积
    //思想：取子问题的max，发现重叠子问题
    //优化：记忆化搜索
    int maxIntegerBreak(int n) {
        assert(n >= 2);
        memo = vector<int>(n,-1);
        return integerBreak(n);
    };
};
