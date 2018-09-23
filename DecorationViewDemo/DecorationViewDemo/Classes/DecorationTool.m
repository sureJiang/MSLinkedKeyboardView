//
//  DecorationTool.m
//  DEMo
//
//  Created by 姜自佳 on 2017/5/12.
//  Copyright © 2017年 JZJ. All rights reserved.
//

#import "DecorationTool.h"
#import "FaceDecorationItem.h"
#import "FaceDecorationItem+extention.h"

NSInteger const kDecorationsRowCount  = 2;    // 行数
NSInteger const kDecorationsColCount  = 4;    // 列数
NSInteger const kMaxDecorationCount   = kDecorationsColCount*kDecorationsRowCount;  // 每一页最多展示个数
CGFloat   const kDecorationsRowHeight = 90.;  // 行高

@implementation DecorationTool

+ (NSArray <NSMutableArray *> *)getDecorationsArrayWithDecorations:(NSArray*)decoration {
    
    NSMutableArray* marr = [NSMutableArray arrayWithArray:decoration];
    NSInteger count =  ceil(decoration.count*1.0/kMaxDecorationCount)*kMaxDecorationCount - decoration.count;
    for (NSInteger i = 0; i<count; i++) {
        FaceDecorationItem* item = [FaceDecorationItem new];
        item.isPlaceholdItem = YES;
        [marr addObject:item];
    }
    return marr;
}


@end
