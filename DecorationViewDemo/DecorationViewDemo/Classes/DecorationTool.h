//
//  DecorationTool.h
//  DEMo
//
//  Created by 姜自佳 on 2017/5/12.
//  Copyright © 2017年 JZJ. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSInteger const kDecorationsRowCount;
extern NSInteger const kDecorationsColCount;
extern NSInteger const kMaxDecorationCount;
extern CGFloat   const kDecorationsRowHeight;

@interface DecorationTool : NSObject

+ (NSArray <NSMutableArray *> *)getDecorationsArrayWithDecorations:(NSArray*)decoration;
@end
