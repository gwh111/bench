//
//  testBag.cpp
//  benchTests
//
//  Created by gwh on 2023/2/1.
//

#include <stdio.h>

#include "Head.hpp"
#include "testVector.cpp"

class testBag {
private:
    vector<vector<int>> memo;

    //用[0...index]的物品，填充容积为C的背包最大值
    int bestValue(const vector<int> &w,const vector<int> &v,int index,int c) {
      
        if (index < 0||c <= 0) {
            return 0;
        }
        if (memo[index][c] != -1) {
            return memo[index][c];
        }
        int res = bestValue(w, v, index-1, c);
        if (c >= w[index]) {
            res = max(res,v[index]+bestValue(w, v, index-1, c-w[index]));
        }
        memo[index][c] = res;
        return res;
    };
    
    int bestValue2(const vector<int> &w,const vector<int> &v,int index,int c) {
        assert(w.size() == v.size());
        int n = (int)w.size();
        if (n == 0) {
            return 0;
        }
        
        vector<vector<int>>memo(n,vector<int>(c+1,-1));
    
        for (int m = 0; m <= c; m++) {
            memo[0][m] = (m >= w[0]?v[0]:0);
        }
        
        for (int i = 1; i < n; i++) {
            for (int m = 0; m < c; m++) {
                memo[i][m] = memo[i-1][m];
                if (m >= w[i]) {
                    memo[i][m] = max(memo[i][m],v[i]+memo[i-1][m-w[i]]);
                }
            }
        }
        
        return memo[n-1][c];
    };
    
    //求组合数
    //计算可以凑成总金额的硬币组合数
    int getCombination(vector<int>& w,int amout) {
        vector<int> dp(amout + 1, 0);//0-amout总价值有的组合数
        dp[0] = 1;
        for (int i = 0; i < dp.size(); i++) {
            for (const auto &coinw:w) {
                if (i - coinw < 0) {//硬币价值过大不需判断
                    continue;
                }
                dp[i] = dp[i]+dp[i-coinw];//当前金额选？不选
            }
        }
        return dp[amout];
    }
    
    //求数量
    //硬币数量无限，最少需要几枚硬币凑出这个金额？w每个硬币的值
    int getAmount(vector<int>& w,int amout) {
        vector<int> dp(amout + 1, -1);//0-amout总价值需要的数量
        dp[0] = 0;
        for (int i = 0; i < dp.size(); i++) {
            for (const auto &coinw:w) {
                if (i - coinw < 0) {//硬币价值过大不需判断
                    continue;
                }
                dp[i] = min(dp[i],dp[i-coinw]+1);//当前金额选？不选
            }
        }
        
        int result = dp[amout];
        if (result == -1) {
            //没有解
        }
        return result;
    }
    
    //求价值
    //01背包最多装多大价值的物品 v每个物品需要的空间 w每个物品的价值 V背包体积
    int getResult1(vector<int>& v, vector<int>& w, int V) {
        vector<int> dp(V + 1, 0);//装0-V体积时能到达的最大价值
        int n = (int)v.size();
        for (int i = 0; i < n; ++i) {
            for (int j = V; j >= v[i]; --j) {
                dp[j] = max(dp[j], dp[j - v[i]] + w[i]);
            }
        }
     
        return dp[V];
    }
     
    //求价值
    //01恰好装满背包的最大价值
    int getResult2(vector<int>& v, vector<int>& w, int V) {
        vector<int> dp(V + 1, -1);
        dp[0] = 0;
        int n = (int)v.size();
     
        for (int i = 0; i < n; ++i) {
            for (int j = V; j >= v[i]; --j) {
                if (dp[j - v[i]] >= 0) {
                    dp[j] = max(dp[j], dp[j - v[i]] + w[i]);
                }
            }
        }
     
        return dp[V] >= 0 ? dp[V] : 0;
    }
    
    //求能否
    //[1,5,11,5]能否分成两个和相等的子集？
    bool cansubdivide(vector<int>nums) {
        int sum = 0;
        int n = (int)nums.size();
        for (int i = 0; i < n; i++) {
            sum = sum + nums[i];
        }
        sum = sum/2;
        
        //前n个物品能否组成和为0-sum
        vector<vector<bool>> dp(n,vector<bool>(sum+1,false));
        dp[0][0] = true;
        for (int i = 1; i < n; i++) {
            for (int j = 1; j <= sum; j++) {
                if (j-nums[i] < 0) {
                    dp[i][j] = dp[i-1][j];//不能放
                } else {
                    dp[i][j] = dp[i-1][j]||dp[i-1][j-nums[i]];
                }
            }
        }
        
        return dp[n][sum];
    }
    
    void getResult3() {
        int n, m;
        const int N = 1000 + 10;
        int v[N], w[N], dp1[N], dp2[N];
        
        while(scanf("%d%d", &n, &m) != EOF){
            for(int i = 0; i < n; i++) scanf("%d%d", &w[i], &v[i]);
            fill(dp2, dp2 + m + 1, -INT_MAX);
            dp2[0] = 0;
            for(int i = 0; i < n; i++){
                for(int j = w[i]; j <= m; j++){
                    dp1[j] = max(dp1[j], dp1[j - w[i]] + v[i]);
                    dp2[j] = max(dp2[j], dp2[j - w[i]] + v[i]);
                }
            }
            printf("%d\n", dp1[m]);
            if(dp2[m] < 0) printf("0\n");
            else printf("%d\n", dp2[m]);
        }
        
    }
public:
    int knapsack01(const vector<int> &w,const vector<int> &v,int c) {
        int n = (int)w.size();
        memo = vector<vector<int>>(n,vector<int>(c+1,-1));//0-c的容量
        return bestValue(w,v,n-1,c);
    };
    
    
};
