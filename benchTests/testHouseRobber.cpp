//
//  testHouseRobber.cpp
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

    //考虑抢劫index……nums.size
    int tryRob(vector<int>&nums,int index) {
        
        if (index >= nums.size()) {
            return 0;
        }
        if (memo[index] != -1) {
            return memo[index];
        }
        
        int res = 0;
        for (int i = index; i < nums.size(); i++) {
            res = max(res,nums[i]+tryRob(nums, i+2));
        }
        memo[index] = res;
        return res;
    }
    
    int tryRob2(vector<int>&nums) {
        
        int n = (int)nums.size();
        if (n == 0) {
            return 0;
        }
        
        //memo[i]表示考虑抢劫nums[i...n-1]区间最大值
        vector<int>memo(n,-1);
        memo[n-1] = nums[n-1];
        for (int i = n-2; i >= 0; i--) {
            for (int m = i; m < n; m++) {
                memo[i] = max(memo[i],nums[m]+(m+2 < n? memo[m+2]:0));
            }
        }
        return memo[0];
    }
public:
    //nums每个房子里的价值，不能连续抢劫，计算最大值
    int rob(vector<int>&nums) {
        memo = vector<int>(nums.size(),-1);
        return tryRob(nums, 0);
    };
};
