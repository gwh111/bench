//
//  testCPP.m
//  bench
//
//  Created by gwh on 2023/2/9.
//

#import <UIKit/UIKit.h>
#import "test.h"

#include <iostream>
#include <vector>
#include <list>
#include <queue>
#include <stack>

#include <map>
#include <unordered_map>

#include <string.h>

#include <algorithm>
#include <functional>


@implementation test

using namespace::std;

struct TreeNode {
int val;
TreeNode *left;
TreeNode *right;
//    TreeNode() : val(0), left(nullptr), right(nullptr) {
//
//    }
TreeNode(int x) : val(x), left(nullptr), right(nullptr) {

}
};

//template<typename T>

class testCPP {
    public:
//    int n;    //表示数组长度
    //递归法构建二叉树
    TreeNode *creatTree(vector<int> nums, int index, int n) {
        //判断是否为空
        if (nums[index] == '#')
            return NULL;

        //创建新结点
        TreeNode *root = new TreeNode(nums[index]);
//        root->data = nums[index];

        //设置左右指针
        if (index * 2 <= n)
            root->left = creatTree(nums, index * 2, n);    //找到左孩子
        else
            root->left = NULL;
        if (index * 2 + 1 <= n)
            root->right = creatTree(nums, index * 2 + 1, n);    //找到右孩子
        else
            root->right = NULL;

        return root;
    }

    //非递归构建二叉树（利用栈）—— 前序遍历
    void stackCreatTree(vector<int> nums) {
        int n = nums.size();
        stack<int> s;
        int index;    //记录遍历到第几个元素
        s.push(1);    //推入根结点，开始遍历
        while (!s.empty()) {
            index = s.top();
            s.pop();
            cout << nums[index] << " ";
            //先推入右孩子
            if (index * 2 + 1 < n && nums[index * 2 + 1] != '#')
                s.push(index * 2 + 1);
            //再推入左孩子，因为是栈结构，先进后出，而且前序遍历需要优先访问所有左子树，故只有一直放在栈顶才能先访问
            if (index * 2 < n && nums[index * 2] != '#')
                s.push(index * 2);
        }
        cout << endl;
    }
    
    void testset() {
//        memset(dp,0,sizeof(dp));
        vector<int>res{10,0};
//        if (testMap.count(key) == 0)
//        cout << "no this key" << endl;
        map<string,string> testMap;
        testMap["key"];
        if (testMap.find("key") == testMap.end())
            cout << "no this key" << endl;
        /*
         第一行输入一个正整数 n ，表示数组 cost 的长度。
         第二行输入 n 个正整数，表示数组 cost 的值。
         */
        int num, value;
        cin >> num;
        vector<int> vec(num+5);
        for(int i = 3; i < num+3; i++){
            cin >> value;
            vec[i] = value;
        }
//        vec.size();
//        插入
//        res.insert(res.begin()+minindex,value);
        
        //读取第二行
        string a;
        getline(cin,a);

        //空格分割
        string line;
        vector<string> v;
        int pos = 0;
        int pos2 = 0;
        int len = line.length();
        while (pos < len) {
            pos2 = line.find(" ",pos);
            if (pos2 == -1) {
                pos2 = len;
            }
            string ns = line.substr(pos,pos2-pos);
            v.push_back(ns);
            pos = pos2+1;
        }
        //string->int
        string str = "13";
        int n = atoi(str.c_str());
        //int->string
        int m = 0;
        string s = to_string(m);
        
        string s2 = "";
        int num2 = 100;
        while (num2) {
            s2+= '0'+num2%10;
            num2 = num2/10;
        }
//        reverse(s2);
        
        
    }
    
    void printvector_vi(vector<int> &v) {
        cout << "v=" << ' ';
        for (const auto &i:v) {
            cout << i << ' ';
        }
        cout << "v=end" << endl;
    };

    void printvector_vvs(vector<vector<string>> &v) {
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
    
    
    
    void sort2(int index, NSMutableArray *list, NSMutableArray *temp) {
        if (temp.count >= list.count) {
            NSString *res = @"";
//            res->isa;
            for (int i = 0; i < temp.count; i++) {
                res = [NSString stringWithFormat:@"%@%@",res,temp[i]];
            }
            printf("res=%@", res);
            return;
        }
        for (int i = 0; i < list.count; i++) {
            [temp addObject:list[i]];
            NSMutableArray *nlist = list.mutableCopy;
            [nlist removeObjectAtIndex:i];
//            [self sort2:index+1 index:nlist temp:temp];
            sort2(index+1, nlist, temp);
            [temp removeLastObject];
        }
    };
//    void test() {
//
//        char *s;
//        NSString *str = @"";
//        if (s == " ") {
//            str = [NSString stringWithFormat:@"%@%s",str,s];
//        }
//        NSMutableArray *list = [[NSMutableArray alloc]init];
//        [list addObject:str];
//
//        NSLog(@"%@",list);
//
//        NSString *res = @"";
//        {
//            NSMutableArray *list = @[@"20",@"01"].mutableCopy;
//            NSMutableArray *temp = NSMutableArray.alloc.init;
////            [self sort:list index:0 temp:temp];
//        }
//
//    };
    
    
    
    void test() {

    }
    
//    TreeNode(int x, TreeNode *left, TreeNode *right) : val(x), left(left), right(right) {
//
//    }
//    };
    
    vector<vector<int>> levelOrder(TreeNode* root) {
        
        
        
        vector<vector<int>> res;
        if (root == nullptr) {
            return res;
        }
        
        queue<TreeNode*> q;
        q.push(root);
        
        while(!q.empty()) {
            
            int l = (int)q.size();
            
            vector<int> sum;
            
            while (l > 0) {
                l--;
                
//                TreeNode *node = q.pop();
                TreeNode *node = q.front();
                printf("%d,",node->val);
                q.pop();
                
                sum.push_back(node->val);
                if (node->left) {
                    q.push(node->left);
                }
                if (node->right) {
                    q.push(node->right);
                }
                
                
            }
            printf("\n");
            res.push_back(sum);
        }
        
//        cout << '[' << endl;
//        for(int i = 0; i <res.size(); i++) {
//            vector<int>sum = res[i];
//            cout << '[' << endl;
//            for(const auto &l:sum) {
//                cout << l << endl;
//            }
//            cout << "]" << endl;
//            if (i < res.size()-1) {
//                cout << "," << endl;
//            }
//        }
//        cout << ']' << endl;
        
        return res;
    }
    
};







+ (void)test {
    printf("test start\n");
    
    int v1 = 0;
    int v2 = v1;
    
    v2++;
    printf("%d",v1);
    
//    testCPP t;
//    t.test();
    map<char, int>map1;
    map1['a'] = 1;
    map1['b'] = 2;

    cout << map1['a'] << endl; // 返回1
    cout << map1['c'] << endl; // 返回0 // 这里相当于存入了['c',0]到map1中
    
    if (map1['c'] == 0) {
        printf("1no c");
    }
    if (map1.find('c') == map1.end()) {
        printf("2no c"); // cout 后不执行
    }
    if (map1.count('c') == 0) {
        printf("3no c"); // cout 后不执行
    }
    
    testCPP test;
    test.test();
    
    TreeNode *t = new TreeNode(3);
    
    TreeNode *t1 = new TreeNode(9);
    t->left = t1;
    
    TreeNode *t2 = new TreeNode(20);
    t2->left = new TreeNode(15);
    t2->right = new TreeNode(7);
    
    t->right = t2;
    
    vector<int> nums = { '#', 1, 2, 3, 4, 5, '#', 6, '#', '#', 7, 8 };
    
    TreeNode *root = test.creatTree(nums, 1, (int)nums.size());
    
    test.levelOrder(root);
//    printf(nums);
    
    
    printf("test end\n");
}


#include <map>

#include <iostream>
#include <sstream>
#include <vector>

bool next(vector<vector<char>> &vs, int as_x, int as_y) {
    
    return 1;
}
int solution(vector<int> &A) {
    // Implement your solution here
    string s = "123";
    
//    char ch = s.at(0);
//    string c = ch;
    
    stringstream ss(s);
    vector<string> tokens;
    while (ss.good()) {
        string substr;
        getline(ss, substr, ' ');
        
        if (!substr.empty()) {
            tokens.push_back(substr);
        }
    }
    
    for (const auto& token : tokens) {
        cout << token << endl;
    }
    
    
    vector<int> v;
    map<int,int> m;
    v.push_back(1);
    m[v[0]] = 2;
    if (m.find(1) == m.end()) {
        printf("yes");
    }
    for (auto it = m.begin(); it != m.end(); ++it) {
        std::cout << it->first << ": " << it->second << std::endl;
    }
    
    printf("%d",m[200]);
    // for (int i = 0; i < (int)A.size(); i++) {
    //     cout << A[i] << endl;
    // }
    // string str = "13";
    // int n = atoi(str.c_str());
    // //int->string
    // int m = 0;
    // string s = to_string(m);
    return 0;
}

@end
