//
//  RbExt.h
//  RbExt
//
//  Created by 박 창진 on 2017. 1. 15..
//  Copyright © 2017년 박 창진. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Ruby/Ruby.h>


@interface RbExt : NSObject

@end


void Init_RbExt();
void DbgString(char *szDbgString);
int Sum(int nStart, int nEnd);
