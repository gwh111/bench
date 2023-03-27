//
//  testTree.cpp
//  benchTests
//
//  Created by gwh on 2023/1/31.
//

#include <stdio.h>

#include "Head.hpp"

struct TreeNode {
    int val;
    TreeNode *left;
    TreeNode *right;
    //初始化方法1
//    TreeNode(int x) : val(x), left(NULL), right(NULL) {};
    //初始化方法2
    TreeNode(int val) {
     this->val = val;
     this->left = this->right = NULL;
    }
};

class Solution {
public:
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
    
    //反转二叉树
    TreeNode *invertTree(TreeNode *root) {
        
        if (root == NULL) {
            return NULL;
        }
//        TreeNode *t = TreeNode(5);
        
        invertTree(root->left);
        invertTree(root->right);
        swap(root->left, root->right);
        
        return root;
    };
    
    /*
     路径 被定义为一条从树中任意节点出发，沿父节点-子节点连接，达到任意节点的序列。同一个节点在一条路径序列中 至多出现一次 。该路径 至少包含一个 节点，且不一定经过根节点。

     路径和 是路径中各节点值的总和。

     给你一个二叉树的根节点 root ，返回其 最大路径和 。

     来源：力扣（LeetCode）
     链接：https://leetcode.cn/problems/binary-tree-maximum-path-sum
     124. 二叉树中的最大路径和
     */
    int maxPathSum(TreeNode* root, int &val)
    {
        if (root == nullptr) return 0;
        int left = maxPathSum(root->left, val);
        int right = maxPathSum(root->right, val);
        int lmr = root->val + max(0, left) + max(0, right);
        int ret = root->val + max(0, max(left, right));
        val = max(val, max(lmr, ret));
        return ret;
    }
    int maxPathSum(TreeNode* root)
    {
        int val = INT_MIN;
        maxPathSum(root, val);
        return val;
    }
    
    int maxSum = INT_MIN;
    int maxGain(TreeNode* node) {
        if (node == nullptr) {
            return 0;
        }
        
        // 递归计算左右子节点的最大贡献值
        // 只有在最大贡献值大于 0 时，才会选取对应子节点
        int leftGain = max(maxGain(node->left), 0);
        int rightGain = max(maxGain(node->right), 0);

        // 节点的最大路径和取决于该节点的值与该节点的左右子节点的最大贡献值
        int priceNewpath = node->val + leftGain + rightGain;

        // 更新答案
        maxSum = max(maxSum, priceNewpath);

        // 返回节点的最大贡献值
        return node->val + max(leftGain, rightGain);
    }
    
    //二叉树中和为某一值的路径(一)
    bool hasPathSum(TreeNode* root, int sum) {
        if (root == NULL) {
            return false;
        }
        sum = sum-root->val;
        if (sum == 0 && root->left == NULL && root->right == NULL) {
            return true;
        }
        bool left = hasPathSum(root->left, sum);
        bool right = hasPathSum(root->right, sum);
        if (left||right) {
            return true;
        }
        
        return false;
    }
    
    //前序遍历
    void preorder(vector<int> &res, TreeNode* root){
        if(root == NULL)
            return;
        res.push_back(root->val);
        preorder(res, root->left);
        preorder(res, root->right);
    }
    //中序遍历 二分搜索树结果从小到大
    void midorder(vector<int> &res, TreeNode* root){
        if(root == NULL)
            return;
        midorder(res, root->left);
        res.push_back(root->val);
        midorder(res, root->right);
    }
    //后序遍历
    void backorder(vector<int> &res, TreeNode* root){
        if(root == NULL)
            return;
        backorder(res, root->left);
        backorder(res, root->right);
        res.push_back(root->val);
    }
    //层序遍历 BFS 第一次逃出迷宫时就是最短路径
    /*
     [[1],
      [2,3],
      [4]]
     */
    vector<vector<int> > levelOrder(TreeNode* root) {
        // write code here
        vector<vector<int>> ans;
        if(root==nullptr)
            return ans;
        queue<TreeNode*> q;
        q.push(root);
        while(!q.empty()){
//            TreeNode* tmp=q.front();
//            q.pop();
//            cout << tmp->val << endl;
//            if(tmp->left)
//                q.push(tmp->left);
//            if(tmp->right)
//                q.push(tmp->right);
            
             //sz记住当前层的节点数量，方便确定执行该层的遍历次数。
            int sz=(int)q.size();
            vector<int> cur;
            while(sz--){
                TreeNode* tmp=q.front();
                q.pop();
                cur.push_back(tmp->val);
                if(tmp->left)
                    q.push(tmp->left);
                if(tmp->right)
                    q.push(tmp->right);
            }
            ans.push_back(cur);
        }
        return ans;
    }

    
    //是不是二叉搜索树？
    //二叉搜索树满足每个节点的左子树上的所有节点均小于当前节点且右子树上的所有节点均大于当前节点。
    long long pre=INT_MIN;
    bool isValidBST(TreeNode* root) {
        // write code here
        if(root==NULL){
            return true;
        }
        if(!isValidBST(root->left)){
            return false;
        }
        if(pre>root->val){
            return false;
        }
        pre=root->val;
        if(!isValidBST(root->right)){
            return false;
        }
        return true;
    }
    
    //是不是完全二叉树？
    //完全二叉树的定义：若二叉树的深度为 h，除第 h 层外，其它各层的结点数都达到最大个数，第 h 层所有的叶子结点都连续集中在最左边，这就是完全二叉树。（第 h 层可能包含 [1~2h] 个节点）
    bool isCompleteTree(TreeNode* root) {
        queue <TreeNode *> q;
        q.push(root);
        TreeNode *p;
        while(!q.empty()) {
            p = q.front();
            q.pop();
            if(p) {
                q.push(p->left);
                q.push(p->right);
            } else {
                while(!q.empty()) {
                    p = q.front();
                    q.pop();
                    if(p != NULL) return false;
                }
            }
        }
        return true;
    }
    
    
    //是不是平衡二叉树？在这里，我们只需要考虑其平衡性，不需要考虑其是不是排序二叉树
    //平衡二叉树（Balanced Binary Tree），具有以下性质：它是一棵空树或它的左右两个子树的高度差的绝对值不超过1，并且左右两个子树都是一棵平衡二叉树。
    bool IsBalanced_Solution(TreeNode* root) {
        if (!root)
            return true;
        int leftHeight = getHeight(root->left);
        int rightHeight = getHeight(root->right);
        if (abs(leftHeight - rightHeight) > 1)
            return false;
        return IsBalanced_Solution(root->left) && IsBalanced_Solution(root->right);
    }
    //求子树高度 最大深度
    int getHeight(TreeNode* root) {
        if (!root)
            return 0;
        if (!root->left && !root->right)
            return 1; // 叶子结点
        return 1 + max(getHeight(root->left), getHeight(root->right));
    }
    
    
    unordered_map<long long, int> prefix;

    
    
    int dfs(TreeNode *root, long long curr, int sum) {
        if (!root) {
            return 0;
        }

        int ret = 0;
        curr += root->val;
        if (prefix.count(curr - sum)) {
            ret = prefix[curr - sum];
        }

        prefix[curr]++;
        ret += dfs(root->left, curr, sum);
        ret += dfs(root->right, curr, sum);
        prefix[curr]--;

        return ret;
    }
    //给定一棵二叉树，其中每个节点都含有一个整数数值(该值或正或负)。设计一个算法，打印节点数值总和等于某个给定值的所有路径的数量。注意，路径不一定非得从二叉树的根节点或叶节点开始或结束，但是其方向必须向下(只能从父节点指向子节点方向)。
    int pathSum(TreeNode* root, int sum) {
        prefix[0] = 1;
        return dfs(root, 0, sum);
    }

    
};
