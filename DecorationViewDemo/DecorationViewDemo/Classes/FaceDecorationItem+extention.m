//
//  ItemCell+extention.m
//  MomoChat
//
//  Created by 姜自佳 on 2017/5/20.
//  Copyright © 2017年  All rights reserved.
//

#import "FaceDecorationItem+extention.h"
#import <objc/message.h>

static char* kIndexPathKey      = "indexPath";
static char* isPlaceholdItemKey = "isPlaceholdItem";

@implementation FaceDecorationItem (extention)

- (void)setIndexPath:(NSIndexPath *)indexPath{
    objc_setAssociatedObject(self, kIndexPathKey, indexPath, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSIndexPath *)indexPath{
    return objc_getAssociatedObject(self, kIndexPathKey);
}


- (void)setIsPlaceholdItem:(BOOL)isPlaceholdItem{
    objc_setAssociatedObject(self, isPlaceholdItemKey, @(isPlaceholdItem), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
 
}

- (BOOL )isPlaceholdItem{
    return [objc_getAssociatedObject(self, isPlaceholdItemKey) boolValue];
}

@end
