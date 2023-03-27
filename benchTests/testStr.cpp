//
//  testStr.cpp
//  benchTests
//
//  Created by gwh on 2023/1/29.
//

#include <stdio.h>

#include "Head.hpp"

using namespace::std;

class testStr {
    
    
public:
    //比如"Hello World"变形后就变成了"wORLD hELLO"。
    string trans(string s, int n) {
        if(n==0)
            return s;
        string res;
        for(int i = 0; i < n; i++){
            //大小写转换
            if (s[i] <= 'Z' && s[i] >= 'A')
                res += s[i] - 'A' + 'a';
            else if(s[i] >= 'a' && s[i] <= 'z')
                res += s[i] - 'a' + 'A';
            else
                //空格直接复制
                res+=s[i];
        }
        //翻转整个字符串
        reverse(res.begin(), res.end());
        for (int i = 0; i < n; i++){
            int j = i;
            //以空格为界，二次翻转
            while(j < n && res[j] != ' ')
                j++;
            reverse(res.begin() + i, res.begin() + j);
            i = j;
        }
        return res;
    }
    
    //最长公共前缀
    string longestCommonPrefix(vector<string>& strs) {
        int n = strs.size();
        //空字符串数组
        if(n == 0)
            return "";
        //遍历第一个字符串的长度
        for(int i = 0; i < strs[0].length(); i++){
            char temp = strs[0][i];
            //遍历后续的字符串
            for(int j = 1; j < n; j++)
                //比较每个字符串该位置是否和第一个相同
                if(i == strs[j].length() || strs[j][i] != temp)
                    //不相同则结束
                    return strs[0].substr(0, i);
        }
        //后续字符串有整个字一个字符串的前缀
        return strs[0];
    }
    
    //大数加法
    string solve(string s, string t) {
        // write code here
        int len1=s.size();
        int len2=t.size();
        // 首先要保证两个数的位数要保持一致
        while(len1<len2){
            s="0"+s;
            len1++;
        }
        while(len1>len2){
            t="0"+t;
            len2++;
        }
        string ans;
        int carry=0;  // 定义一个变量作为进位位
        for(int i=len1-1;i>=0;i--){
            int tmp=(s[i]-'0'+t[i]-'0'+carry);
            ans+=char(tmp%10+'0');
            carry=tmp/10;  // 不断更新进位位
        }
        // 最后还需要特判进位位
        if(carry){
            ans+=(carry+'0');
        }
        reverse(ans.begin(),ans.end());
        return ans;
    }
    
    //判断是否为回文字符串
    bool judge(string str){
        // write code here
        int start=0, end=str.size()-1;
        while(start<end)
        {
            if(str[start]==str[end])
            {
                start++;
                end--;
            }
            else
            {
                return false;
            }
        }
        return true;
    }
};

void teststr() {
//    const char *s1 = "abc";
//    const char *s2 = "abcd";
    
//    int l = strlen(s1);
//    int c = strcmp(s1, s2);
//
//    char *s3 = "abc";
//    char *s4 = "abcd";
//    strcpy(s3, s4);//复制s4到s3
//    strncpy(s3, s4, 2);//复制s4前2个到s3
//
//    strcat(s3, s4);//s4拼接到s3后
//
//    char *s = strchr(s3, '4');//！字符！第一次出现的位置
//
//    auto wa = shared_ptr<int>(new int(20));
    
}

/*
 给你一个字符串 s 和一个字符规律 p，请你来实现一个支持 '.' 和 '*' 的正则表达式匹配。

 '.' 匹配任意单个字符
 '*' 匹配零个或多个前面的那一个元素
 所谓匹配，是要涵盖 整个 字符串 s的，而不是部分字符串。

 来源：力扣（LeetCode）
 链接：https://leetcode.cn/problems/regular-expression-matching
 10. 正则表达式匹配
 */
bool isMatch(string s, string p) {
        int lens=s.size();
        int lenp=p.size();
        vector<vector<bool>> dp(lens+1,vector<bool>(lenp+1,false));//因为包含了空字串的情况
        //初始化
        dp[0][0]=true;//两个空字串
        for(int j=1;j<lenp+1;j++)//找出s为空 但p因为* 为空的情况
        {
            if(p[j]=='*')
            {
                dp[0][j+1]=dp[0][j-1];
            }
        }
        //更新
        for(int i=1;i<lens+1;i++)
        {
            for(int j=1;j<lenp+1;j++)
            {
                if(s[i-1]==p[j-1]||p[j-1]=='.')//情况1：符合，直接更新
                {
                    dp[i][j]=dp[i-1][j-1];
                }
                else if(p[j-1]=='*')//情况2：考虑*的情况
                {
                    if(s[i-1]==p[j-2]||p[j-2]=='.')
                    {
                        dp[i][j]=dp[i][j-2]||dp[i-1][j-2]||dp[i-1][j];//分别是  重复0次；重复一次；重复两次及以上！！！
                    }
                    else//s[i-1] p[j-2]不匹配  *需要重复0次
                    {
                        dp[i][j]=dp[i][j-2];
                    }
                }
            }
        }
        return dp[lens][lenp];
    }
