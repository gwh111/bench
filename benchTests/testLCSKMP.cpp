//
//  testLCS.cpp
//  benchTests
//
//  Created by gwh on 2023/2/6.
//

#include <stdio.h>
#include "Head.hpp"

/*
 最长公共子序列
 给定两个字符串 text1 和 text2，返回这两个字符串的最长 公共子序列 的长度。如果不存在 公共子序列 ，返回 0 。

 一个字符串的 子序列 是指这样一个新的字符串：它是由原字符串在不改变字符的相对顺序的情况下删除某些字符（也可以不删除任何字符）后组成的新字符串。

 例如，"ace" 是 "abcde" 的子序列，但 "aec" 不是 "abcde" 的子序列。
 两个字符串的 公共子序列 是这两个字符串所共同拥有的子序列。

 来源：力扣（LeetCode）
 链接：https://leetcode.cn/problems/longest-common-subsequence
 1143. 最长公共子序列
 */

class testLCS {
public:
    int longestCommonSubsequence(string text1, string text2) {
            vector<vector<int>> dp(text1.size() + 1, vector<int>(text2.size() + 1, 0));
        
        //或数组初始化
//            int dp[text1.size()+1][text2.size()+1];
//            memset(dp,0,sizeof(dp));
            for (int i = 1; i <= text1.size(); i++) {
                for (int j = 1; j <= text2.size(); j++) {
                    if (text1[i-1] == text2[j-1]) {
                        dp[i][j] = dp[i-1][j-1]+1;
                    } else {
                        dp[i][j] = max(dp[i-1][j],dp[i][j-1]);
                    }
                }
            }
            
            return dp[text1.size()][text2.size()];
        }
    
    int KMP2(const string &pat,const string &text) {
        
        int m = (int)pat.length();
        int n = (int)text.length();
        
        int next[m];//准备子串快进数组
        next[0] = -1;

        int i = 0;
        int k = -1;
        while (i < m - 1) {
           if (k == -1 || pat[i] == pat[k]) {
               i++;
               k++;
               next[i] = k;
           } else {
               k = next[k];
           }
            printf("pat=%s i=%d k=%d next=%d\n",pat.c_str(),i,k,next[i]);
        }
        
        int a = 0;//子串
        int b = 0;//文本
        while (a < m && b < n) {
            if (a == -1 || pat[a] == text[b]) {
                a++;
                b++;
            } else {
                a = next[a];//快进
            }
        }
        int res = -1;
        if (a == m) {
            res = b-a;
            printf("a=%d b=%d res=%d\n",a,b,res);
        }
        
        return res;
    }
    
    int KMP(const string &pat,const string &text) {
        int m = (int)pat.length();
        int n = (int)text.length();
        
        int dp[m][256];
        int shadow = 0;
        for (int i = 0; i < m; i++) {
            for (int j = 0; j < 256; j++) {
                if (pat[i] == j) {
                    dp[i][j] = i+1;//如果字母相等，往后移一位
                } else {
                    dp[i][j] = dp[shadow][j];//否则回到影子位置
                }
                shadow = dp[shadow][pat[i]];//更新影子状态
            }
        }
        
        int start = 0;//初始状态
        for (int i = 0; i < n; i++) {//从text中找pat
            start = dp[start][text[i]];//匹配到第几个了
            if (start == m) {//匹配结束
                return i-m+1;
            }
        }
        
        //匹配失败
        return -1;
    }
};
