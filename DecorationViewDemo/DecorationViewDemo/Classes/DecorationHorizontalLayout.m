//
//  DecorationHorizontalLayout.m
//  DEMo
//
//  Created by 姜自佳 on 2017/5/20.
//  Copyright © 2017年 JZJ. All rights reserved.
//

#import "DecorationHorizontalLayout.h"

@interface   DecorationHorizontalLayout()<UICollectionViewDelegateFlowLayout>
@end

@implementation DecorationHorizontalLayout

- (void)prepareLayout{
    [super prepareLayout];
    
    NSInteger sections = [self.collectionView numberOfSections];
    for (int i = 0; i < sections; i++){
        NSMutableArray * tmpArray = [NSMutableArray array];
        NSUInteger count = [self.collectionView numberOfItemsInSection:i];
        
        for (NSUInteger j = 0; j<count; j++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:j inSection:i];
            UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:indexPath];
            [tmpArray addObjectSafe:attributes];
        }
    }
}


- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSUInteger item = indexPath.item;
    NSUInteger x;
    NSUInteger y;
    [self targetPositionWithItem:item resultX:&x resultY:&y];
    NSUInteger item2 = [self originItemAtX:x y:y];
    NSIndexPath *theNewIndexPath = [NSIndexPath indexPathForItem:item2 inSection:indexPath.section];
    UICollectionViewLayoutAttributes *theNewAttr = [super layoutAttributesForItemAtIndexPath:theNewIndexPath];
    theNewAttr.indexPath = indexPath;
    return theNewAttr;
}


- (void)targetPositionWithItem:(NSUInteger)item
                       resultX:(NSUInteger *)x
                       resultY:(NSUInteger *)y{
    if (!self.itemCountPerRow || !self.rowCount) {
        return;
    }
    
    NSUInteger page = item/(self.itemCountPerRow*self.rowCount);
    
    NSUInteger theX = item % self.itemCountPerRow + page * self.itemCountPerRow;
    NSUInteger theY = item / self.itemCountPerRow - page * self.rowCount;
    if (x != NULL) {
        *x = theX;
    }
    if (y != NULL) {
        *y = theY;
    }
}

- (NSUInteger)originItemAtX:(NSUInteger)x
                          y:(NSUInteger)y{
    NSUInteger item = x * self.rowCount + y;
    return item;
}

@end
