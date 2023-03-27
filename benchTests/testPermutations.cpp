//
//  testPermutations.cpp
//  benchTests
//
//  Created by gwh on 2023/1/31.
//

#include <stdio.h>

#include "Head.hpp"

namespace permutations {    //自定义命名空间spaceA
//    int aaa = 10;
}

class testPermutations {
private:
    vector<bool>used;
    vector<vector<int>>results;
    
    void generate(vector<int> &nums,int index, vector<int>&p) {
        if (index == nums.size()) {
            results.push_back(p);
            
            for (const auto &i:p) {
                cout << i << ' ';
            }
            cout << "index=" << index << endl;
            cout << "end" << endl;
            return;
        }
        for (int i = 0; i < nums.size(); i++) {
            if (!used[i]) {
                
//                if(i > 0 && nums[i - 1] == nums[i] && !used[i - 1])
//                //当前的元素num[i]与同一层的前一个元素num[i-1]相同且num[i-1]已经用过了
//                continue;
                
                p.push_back(nums[i]);
                used[i] = true;
                generate(nums, index+1, p);
                p.pop_back();
                used[i] = false;
            }
        }
    }
    
    void generate2(vector<int> &nums,int index, vector<int>&p) {
        if (nums.size() == 0) {
            results.push_back(p);
            
            for (const auto &i:p) {
                cout << i << ' ';
            }
            cout << "index2=" << index << endl;
            cout << "end" << endl;
        }
//        map<int,int> map_1;//去重缓存
        for (int i = 0; i < nums.size(); i++) {
            p.push_back(nums[i]);
            vector<int> v = nums;
            v.erase(v.begin()+i);
            generate2(v, index+1, p);
            p.pop_back();
        }
    }
public:
    //回溯
    //全排列 每次从0开始
    vector<vector<int>> permute(vector<int>&nums) {
        results.clear();
        if (nums.size() == 0) {
            return results;
        }
        
        used = vector<bool>(nums.size(),false);
        vector<int> p;
        generate(nums,0,p);
        generate2(nums,0,p);
        
        //有重复项数字的全排列[1,1,2]
        sort(nums.begin(), nums.end());
        
        return results;
    };
    
    const string letterMap[10] = {
      " ",
        "",
        "abc",
        "def",
    };
    vector<string> res;
    
    void findCombination(const string &digits,int index,const string &s) {
        if (index == digits.size()) {
            res.push_back(s);
            return;
        }
        char c = digits[index];
        
        assert(c>='0' && c<='9' && c!='1');
        string letters = letterMap[c-'0'];
        for (int i = 0; i < letters.size(); i++) {
            findCombination(digits, index+1, s+letters[i]);
        }
    }
    //诺基亚数字键盘
    vector<string> letterCombinations(string digits) {
        
        findCombination(digits, 0, "");
        return res;
    }
};

static void testpermutations() {
    
    vector<int> v{1,1,3};
    testPermutations().permute(v);
    
}
