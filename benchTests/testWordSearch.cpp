//
//  testWordSearch.cpp
//  benchTests
//
//  Created by gwh on 2023/2/1.
//

#include <stdio.h>

#include "Head.hpp"

class testWordSearch {
    vector<vector<int>> ori = {{0,1},{1,0},{-1,0},{0,1}};
    vector<vector<int>> visited;
    int maxx;
    int maxy;
private:
    bool searchWord(const vector<vector<char>>&board, const string &word,int index,int startx,int starty) {
        
        if (index == word.size()-1) {
            return board[startx][starty] == word[index];
        }
        
        if (board[startx][starty] == word[index]) {
            for (int i = 0; i < 4; i++) {
                int newx = startx + ori[i][0];
                int newy = starty + ori[i][1];
                if (newx >= maxx || newx < 0) {
                    return false;
                }
                if (newy >= maxy || newy < 0) {
                    return false;
                }
                if (visited[newx][newy]) {
                    return false;
                }
                if (searchWord(board, word, index+1, newx, newy)) {
                    visited[newx][newy] = 1;
                    return true;
                }
            }
        }
        
        return false;
    }
    
    
    //螺旋矩阵
    vector<int> spiralOrder(vector<vector<int> > &matrix) {
        vector<int> res;
        int n = matrix.size();
        //先排除特殊情况
        if(n == 0)
            return res;
        //左边界
        int left = 0;
        //右边界
        int right = matrix[0].size() - 1;
        //上边界
        int up = 0;
        //下边界
        int down = n - 1;
        //直到边界重合
        while(left <= right && up <= down){
            //上边界的从左到右
            for(int i = left; i <= right; i++)
                res.push_back(matrix[up][i]);
            //上边界向下
            up++;
            if(up > down)
                break;
            //右边界的从上到下
            for(int i = up; i <= down; i++)
                res.push_back(matrix[i][right]);
            //右边界向左
            right--;
            if(left > right)
                break;
            //下边界的从右到左
            for(int i = right; i >= left; i--)
                res.push_back(matrix[down][i]);
            //下边界向上
            down--;
            if(up > down)
                break;
            //左边界的从下到上
            for(int i = down; i >= up; i--)
                res.push_back(matrix[i][left]);
            //左边界向右
            left++;
            if(left > right)
                break;
        }
        return res;
    }
    
    //顺时针旋转矩阵 先进行对角线的交换，再翻转
    vector<vector<int> > rotateMatrix(vector<vector<int> > mat, int n) {
        // write code here
        for (int i=0;i<n;++i){
            for (int j=0;j<i;++j){
                swap(mat[i][j],mat[j][i]);//先交换
            }
        }
        for (int i=0;i<n;++i)
            reverse(mat[i].begin(),mat[i].end());//再将内部元素翻转
        return mat;
    }
public:
    //查找word匹配的路径
    bool exits(vector<vector<char>>&board, string word) {
        maxx = int(board.size());
        assert(board.size() > 0);
        maxy = int(board[0].size());
        
        visited = vector<vector<int>>(maxx,vector<int>(maxy,1));
        
        for (int i = 0; i < board.size(); i++) {
            for (int m = 0; m < board[i].size(); m++) {
                if (searchWord(board, word, 0, i, m)) {
                    return true;
                }
            }
        }
        return false;
    }
};

void testwordsearch() {
    
}
