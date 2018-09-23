//
//  FaceDecorationPageView.m
//
//  Created by 姜自佳 on 2017/5/12.
//  Copyright © 2017年 JZJ. All rights reserved.
//

#import "FaceDecorationPageView.h"
#import "FaceDecorationItem.h"
#import "ItemCell.h"
#import "FaceDecorationItem+extention.h"
#import "DecorationHorizontalLayout.h"
#import "DecorationTool.h"


@interface FaceDecorationPageView()<UICollectionViewDelegate,
                                    UICollectionViewDataSource>
@property (nonatomic, weak) id<FaceDecorationViewDelegate> pageCellDelegate;

@end
@implementation FaceDecorationPageView



- (instancetype)initWithItemSize:(CGSize)size {
    
    DecorationHorizontalLayout* flow = [DecorationHorizontalLayout new];
    flow.itemCountPerRow = kDecorationsColCount;
    flow.rowCount = kDecorationsRowCount;
    flow.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flow.minimumLineSpacing = 0;
    flow.minimumInteritemSpacing = 0;
    flow.itemSize = CGSizeMake([UIScreen mainScreen].bounds.size.width*1.0/kDecorationsColCount, 90);

    self = [super initWithFrame:CGRectZero collectionViewLayout:flow];
    if (self) {
        
        [self registerClass:[ItemCell class] forCellWithReuseIdentifier:NSStringFromClass([ItemCell class])];
        self.backgroundColor = [UIColor clearColor];
        self.pagingEnabled = YES;
        self.dataSource = self;
        self.delegate = self;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;

    }
    return self;
}




- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    NSArray *sortedIndexPaths = [self.indexPathsForVisibleItems sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2];
    }];
    
    NSIndexPath* indexPath = sortedIndexPaths.lastObject;
    NSInteger section = indexPath.section;

    NSArray* sectionArray = [self.dataArray objectAtIndexSafe:section];
    NSInteger count = sectionArray.count/kMaxDecorationCount;

    if(self.currentSectionBlock){
        self.currentSectionBlock(section, count,indexPath.item/kMaxDecorationCount);
    }
}




#pragma mark - UICollectionViewDataSource UICollectionViewDelegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.dataArray.count;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSArray* arr = self.dataArray[section];
    return arr.count;
}


- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
   
    FaceDecorationItem* item = [self itemOfRow:indexPath];
    ItemCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([ItemCell class]) forIndexPath:indexPath];
    [cell setItem:item];
    if([self.pageCellDelegate respondsToSelector:@selector(collectionView:renderCell:withModel:atIndexPath:) ]){
        [self.pageCellDelegate collectionView:collectionView renderCell:cell withModel:item atIndexPath:indexPath];
    }
    return cell;
    
}

- (FaceDecorationItem*)itemOfRow:(NSIndexPath*)indexPath{
    NSArray* arr = [self.dataArray objectAtIndexSafe:indexPath.section];
    FaceDecorationItem* item = [arr objectAtIndexSafe:indexPath.item];
    return item;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ItemCell* cell = (ItemCell*)[collectionView cellForItemAtIndexPath:indexPath];
    FaceDecorationItem* itemModel = [self itemOfRow:indexPath];
    cell.item = itemModel;
    if([self.pageCellDelegate respondsToSelector:@selector(collectionView:selectCell:indexPath:withModel:) ]){
        [self.pageCellDelegate collectionView:collectionView selectCell:cell indexPath:indexPath withModel:itemModel];
    }
}

- (void)setPageCellDelegate:(id<FaceDecorationViewDelegate>)pageCellDelegate{
    _pageCellDelegate = pageCellDelegate;
}
@end
