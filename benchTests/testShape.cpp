//
//  testShape.cpp
//  benchTests
//
//  Created by gwh on 2023/1/30.
//

#include <stdio.h>

#include "Head.hpp"

class Shape {
public:
    virtual double Area() const {return 0;}//子类方法不一致
    void SetColor(int color) {_color = color;}
    void Display() {
        cout << Area() <<endl;
    }
private:
    int _color;
};

class Square:public Shape {
public:
    Square(int len):_len(len) {}
    double Area() const {
        return _len*_len;
    }
private:
    double _len;
};
