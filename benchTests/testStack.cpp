//
//  testStack.cpp
//  benchTests
//
//  Created by gwh on 2023/1/31.
//

#include <stdio.h>

#include "Head.hpp"
#include "testBTree.cpp"

struct Command {
    string s;
    TreeNode *node;
    Command(string s, TreeNode *node):s(s),node(node){};
};

class testStack {
private:
    stack<int> stack1;
    stack<int> stack2;
    
    stack<int> s;
public:
    //两个栈实现队列
    void push(int node) {
        stack1.push(node);
    }
 
    int pop() {
        int n;
        if (stack2.empty()) {
            while (stack1.empty() == false) {
                stack2.push(stack1.top());
                stack1.pop();
            }
        }
        n = stack2.top();
        stack2.pop();
        return n;
    }
    
    //min
    int min() {
        int m = s.top();
        vector<int> v;
        while(!s.empty()){
            v.push_back(s.top());
            if(m > s.top()){
                m = s.top();
            }
            s.pop();
        }
        reverse(v.begin(), v.end());
        for(int i : v){
            s.push(i);
        }
        return m;
    }
    
    //有效括号序列
    stack<char> str;
    bool isValid(string s) {
        for(int i = 0;i < s.size();i++){
            if(str.empty()||(s[i]-1 != str.top()&&s[i]-2!=str.top())) str.push(s[i]);//'['与']'之间相差2,'('与')'之间相差1，'{'与'}'之间相差2
            else str.pop();
        }
        return str.empty();
    }
    
    
};
