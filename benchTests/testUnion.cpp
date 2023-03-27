//
//  testUnion.cpp
//  benchTests
//
//  Created by gwh on 2023/3/26.
//

#include <stdio.h>
#include "Head.hpp"

static int bbb = 1;
//并查集22

class Solution {
public:
    int Find(vector<int>& parent, int index) {
        if (parent[index] != index) {
            //找到根节点
            parent[index] = Find(parent, parent[index]);
        }
        return parent[index];
    }

    void Union(vector<int>& parent, int index1, int index2) {
        parent[Find(parent, index1)] = Find(parent, index2);
    }

    int findCircleNum(vector<vector<int>>& isConnected) {
        int cities = (int)isConnected.size();
        vector<int> parent(cities);
        //自己和自己连通=根节点
        for (int i = 0; i < cities; i++) {
            parent[i] = i;
        }
        for (int i = 0; i < cities; i++) {
            for (int j = i + 1; j < cities; j++) {
                if (isConnected[i][j] == 1) {
                    //找到连通直到找到 自己和自己连通
                    Union(parent, i, j);
                }
            }
        }
        int provinces = 0;
        for (int i = 0; i < cities; i++) {
            if (parent[i] == i) {
                //只有 自己和自己连通 的情况+1
                provinces++;
            }
        }
        return provinces;
    }
};

