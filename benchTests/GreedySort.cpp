//
//  GreedySort.cpp
//  benchTests
//
//  Created by gwh on 2023/1/23.
//

//#include "GreedySort.hpp"

#include <iostream>
#include <vector>
#include <algorithm>

/*
 Dijkstra 算法
 用途：用于求图中指定两点之间的最短路径，或者是指定一点到其它所有点之间的最短路径。实质上是贪心算法。
 1. 将图上的初始点看作一个集合S，其它点看作另一个集合
 2. 根据初始点，求出其它点到初始点的距离d[i] （若相邻，则d[i]为边权值；若不相邻，则d[i]为无限大）
 3. 选取最小的d[i]（记为d[x]），并将此d[i]边对应的点（记为x）加入集合S
 （实际上，加入集合的这个点的d[x]值就是它到初始点的最短距离）
 4. 再根据x，更新跟 x 相邻点 y 的d[y]值：d[y] = min{ d[y], d[x] + 边权值w[x][y] }，因为可能把距离调小，所以这个更新操作叫做松弛操作。
 （仔细想想，为啥只更新跟x相邻点的d[y]，而不是更新所有跟集合 s 相邻点的 d 值？ 因为第三步只更新并确定了x点到初始点的最短距离，集合内其它点是之前加入的，也经历过第 4 步，所以与 x 没有相邻的点的 d 值是已经更新过的了，不会受到影响）
 5. 重复3，4两步，直到目标点也加入了集合，此时目标点所对应的d[i]即为最短路径长度。
 */

using namespace::std;

//g小朋友需要的最小值 s每个饼干的大小值
int greedySort(vector<int>& g,vector<int>& s) {
    
    sort(g.begin(), g.end(), greater<int>());
    sort(s.begin(), s.end(), greater<int>());
    //从大到小排序
    
    int res = 0;
    int si = 0, gi = 0;//si能给的，gi想要的
    while (si < s.size() && gi < g.size()) {
        if (s[si] >= g[gi]) {
            res++;
            si++;
            gi++;
        } else {
            gi++;
        }
    }
    
    return res;
}

/*
 n 个孩子站成一排。给你一个整数数组 ratings 表示每个孩子的评分。

 你需要按照以下要求，给这些孩子分发糖果：

 每个孩子至少分配到 1 个糖果。
 相邻两个孩子评分更高的孩子会获得更多的糖果。
 请你给每个孩子分发糖果，计算并返回需要准备的 最少糖果数目 。

 来源：力扣（LeetCode）
 链接：https://leetcode.cn/problems/candy
 135. 分发糖果
 */
int candy(vector<int>& ratings) {
    int res = 0;
    vector<int> s(ratings.size(),1);
    for (int i = 1; i < ratings.size(); i++) {
        if (ratings[i] > ratings[i-1]) {
            s[i] = s[i-1]+1;
        }
    }
    res = s[ratings.size()-1];
    for (int i = ratings.size()-2; i >= 0; i--) {
        if (ratings[i] > ratings[i+1]) {
            s[i] = max(s[i],s[i+1]+1);
        }
        res = res+s[i];
    }
    return res;
}
