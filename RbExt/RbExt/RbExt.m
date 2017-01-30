//
//  RbExt.m
//  RbExt
//
//  Created by 박 창진 on 2017. 1. 15..
//  Copyright © 2017년 박 창진. All rights reserved.
//

#import "RbExt.h"


@implementation RbExt

@end

void Init_RbExt()
{
    NSLog(@"Init_RbExt\n");
}


void DbgString(char *szDbgString)
{
    NSLog(@"%s", szDbgString);
}


int Sum(int nStart, int nEnd)
{
    int nSum = 0;
    
    if (nStart <= nEnd)
    {
        for (int nIndex = nStart; nIndex <= nEnd; nIndex++) nSum += nIndex;
    }
    else
    {
        for (int nIndex = nEnd; nIndex <= nStart; nIndex++) nSum += nIndex;
    }
    
    return nSum;
}
