//
//  testLIS.cpp
//  benchTests
//
//  Created by gwh on 2023/2/2.
//

#include <stdio.h>

#include "Head.hpp"
#include "testVector.cpp"

class testLIS {
private:

public:
    //求长度
    //最长递增子序列LIS
    int lengthOfLIS(vector<int>&nums) {
        if (nums.size() == 0) {
            return 0;
        }
        //memo[i]表示以nums[i]为结尾的最长上升子序列长度
        //不连续[2,5,3,7]->[2,3,7]
        vector<int> memo(nums.size(),1);
        for (int i = 1; i < nums.size(); i++) {
            for (int j = 0; j < i; j++) {
                if (nums[j] < nums[i]) {
                    memo[i] = max(memo[i],1+memo[j]);//当前第j个数字选？不选
                }
            }
        }
        int res = 1;
        for (int i = 0; i < memo.size(); i++) {
            res = max(res,memo[i]);
        }
        
        return res;
    };
    
    //求长度
    //最长递增子序列LIS
    int lengthOfLIS2(vector<int>&nums) {
        if (nums.size() == 0) {
            return 0;
        }
        //组成从大到小的数组，共多少组？空当接龙
        vector<vector<int>> dp(0,vector<int>(0,0));
        for (int i = 0; i < nums.size(); i++) {
            bool find = false;
            for (int j = 0; j < dp.size(); j++) {
                vector<int> v = dp[j];
                int size = (int)v.size();
                if (nums[i] < v[size-1]) {
                    v.push_back(nums[i]);
                    find = true;
                    break;
                }
            }
            if (!find) {
                vector<int> v = {1,nums[i]};
                dp.push_back(v);
            }
        }
        
        return (int)dp.size();
    }
    
    /*
     给你一个整数数组 nums ，请你找出一个具有最大和的连续子数组（子数组最少包含一个元素），返回其最大和。

     子数组 是数组中的一个连续部分。
     53. 连续最大子数组和
     */
    int maxSubArray(vector<int>& nums) {
        vector<int> memo(nums.size(),1);
        memo[0] = nums[0];
        int res = nums[0];
        for (int i = 1; i < nums.size(); i++) {
            if (memo[i-1] > 0) {//连续子数组，前面累加的值选？不选
                memo[i] = memo[i-1]+nums[i];
            } else {
                memo[i] = nums[i];//有负数，前面和小于0不如重新开始
            }
            res = max(res,memo[i]);
                    
        }
        return res;
    }
};
