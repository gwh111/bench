//
//  testTransform.cpp
//  benchTests
//
//  Created by gwh on 2023/1/30.
//

#include <stdio.h>

#include "Head.hpp"

static void testTransform() {

    int ones[] = {1,2,3};
    int twos[] = {10,20,30};
    int results[5];
    transform(ones, ones+5, twos, results, plus<int>());
    for_each(results, results+5,
    [](int a)->void {
        cout << a << endl;
    });
}
