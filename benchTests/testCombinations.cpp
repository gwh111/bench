//
//  testCombinations.cpp
//  benchTests
//
//  Created by gwh on 2023/2/1.
//

#include <stdio.h>

#include "Head.hpp"
#include "testVector.cpp"

class testCombinations {
private:
    vector<vector<int>>results;
    //求C(n,k),从start开始
    void generate(int n, int k, int start, vector<int>&c) {
        if (c.size() == k) {
            results.push_back(c);
            printvector_vi(c);
            return;
        }
        
        auto max = n-(k-c.size())+1;//回溯法的剪枝
        for (int i = start; i <= max; i++) {
            c.push_back(i);
            generate(n, k, i+1, c);
            c.pop_back();
        }
    };
public:
    //回溯DFS
    //1-n中取k个数组合
    //[1,2] [2,1]算一个 所以从start开始
    vector<vector<int>>combine(int n, int k) {
        
        results.clear();
        if (n <= 0 || k <= 0 || k > n) {
            return results;
        }
        
        vector<int>c;
        generate(n, k, 1, c);//从1-n取，所以start=1
        
        return results;
    };
};

void testcombinations() {
    
//    vector<int> v{1,2,3};
    testCombinations().combine(5, 2);
    
}
