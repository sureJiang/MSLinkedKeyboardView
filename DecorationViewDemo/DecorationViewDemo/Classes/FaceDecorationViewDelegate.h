//
//  FaceDecorationViewDelegate.h
//  MomoChat
//
//  Created by 姜自佳 on 2017/5/16.
//  Copyright © 2017年  All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FaceDecorationItem.h"
@protocol FaceDecorationViewDelegate <NSObject>

@optional
//cell 视图显示
- (void)collectionView:(UICollectionView*)colleview
             renderCell:(UICollectionViewCell*)cell
             withModel:(FaceDecorationItem*)cellModel
             atIndexPath:(NSIndexPath *)indexPath;


//cell选中事件
- (void)collectionView:(UICollectionView*)colleview
                  selectCell:(UICollectionViewCell*)cell
                  indexPath:(NSIndexPath*)indexPath
                  withModel:(FaceDecorationItem*)cellModel;

@end
