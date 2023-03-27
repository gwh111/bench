//
//  testFloodFill.cpp
//  benchTests
//
//  Created by gwh on 2023/2/1.
//

#include <stdio.h>

#include "Head.hpp"

class testFloodFill {
    vector<vector<int>> ori = {{0,1},{1,0},{-1,0},{-1,1}};
    vector<vector<bool>> visited;
    int maxx;
    int maxy;
    
    void dfs(vector<vector<char>> &grid, int x, int y) {
        visited[x][y] = true;
        for (int i = 0; i < 4; i++) {
            int newx = x + ori[i][0];
            int newy = y + ori[i][1];
            if (newx >= maxx || newx < 0) {
                return;
            }
            if (newy >= maxy || newy < 0) {
                return;
            }
            if (visited[newx][newy]) {
                return;
            }
            if (grid[newx][newy] == '1') {
                dfs(grid, newx, newy);
            }
        }
    }
private:
    //地图里有几个岛，上下左右都是海算一个岛
    int numIslands(vector<vector<char>>grid) {
     
        maxx = (int)grid.size();
        if (maxx == 0) {
            return 0;
        }
        maxy = (int)grid[0].size();
        
        visited = vector<vector<bool>>(maxx,vector<bool>(maxy,false));
        
        int res = 0;
        for (int i = 0; i < maxx; i++) {
            for (int m = 0; m < maxy; m++) {
                if (grid[i][m] == '1' && !visited[i][m] == true) {
                    res++;
                    dfs(grid, i, m);
                }
            }
        }
        
        return 0;
    }
};
