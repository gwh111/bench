//
//  testSquare.cpp
//  benchTests
//
//  Created by gwh on 2023/1/31.
//

#include <stdio.h>

#include "Head.hpp"

//图
static int numSquares(int n) {
    assert(n > 0);
    
    queue<pair<int, int>>q;
    q.push(make_pair(n, 0));
    
    vector<bool>visited(n+1,false);
    visited[n] = true;
    
    while (!q.empty()) {
        int num = q.front().first;
        int step = q.front().second;
        q.pop();
        
        if (num == 0) {
            return step;
        }
        
        for (int i = 1; num-i*i >= 0; i++) {
            int s = num-i*i;
            if (!visited[s]) {
                q.push(make_pair(s, step++));
                visited[s] = true;
            }
        }
        
        throw invalid_argument("NO Solution.");
    }
    
    return 0;
}
