//
//  FaceDecorationPageView.h
//
//  Created by 姜自佳 on 2017/5/12.
//  Copyright © 2017年 JZJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FaceDecorationViewDelegate.h"

@interface FaceDecorationPageView : UICollectionView

- (void)setPageCellDelegate:(id<FaceDecorationViewDelegate>)pageCellDelegate;
@property(nonatomic,strong)NSArray* dataArray;
@property(nonatomic,copy)  void(^currentSectionBlock) (NSInteger currentSection,NSInteger allCount,NSInteger currentPageIndex);

- (instancetype)initWithItemSize:(CGSize)size;
@end

