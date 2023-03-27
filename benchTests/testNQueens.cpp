//
//  testNQueens.cpp
//  benchTests
//
//  Created by gwh on 2023/2/1.
//

#include <stdio.h>

#include "Head.hpp"
#include "testVector.cpp"

class testNQueens {
private:
    vector<vector<string>> res;
    vector<bool> col;
    vector<bool> dia1;
    vector<bool> dia2;
    
    void putQueen(int n, int column, vector<int> &row) {
        if (column == n) {
            res.push_back(generateBoard(n,row));
            return;
        }
        
        for (int i = 0; i < n; i++) {
            int d1 = column+i;
            int d2 = column-i+n-1;
            if (!col[i] && !dia1[d1] && !dia2[d2]) {
                row.push_back(i);
                col[i] = true;
                dia1[d1] = true;
                dia2[d2] = true;
                putQueen(n, column+1, row);
                col[i] = false;
                dia1[d1] = false;
                dia2[d2] = false;
                row.pop_back();
            }
        }
    }
    
    vector<string>generateBoard(int n, vector<int> &row) {
        assert(row.size() == n);
        
//        string s = "13";
//        s[1] = 'b';
        vector<string>board(n,string(n,'.'));
        for (int i = 0; i < n; i++) {
            board[i][row[i]] = 'Q';
        }
        return board;
    }
    
public:
    vector<vector<string>> solveNQueens(int n) {
        
        res.clear();
        
        col = vector<bool>(n,false);
        dia1 = vector<bool>(2*n-1,false);
        dia2 = vector<bool>(2*n-1,false);
        
        vector<int> row;
        putQueen(n, 0, row);
        return res;
    }
};

void testnqueens() {
    
    int n = 5;
    vector<vector<string>> res = testNQueens().solveNQueens(n);
    printvector_vvs(res);
}
