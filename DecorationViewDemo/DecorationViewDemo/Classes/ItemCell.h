//
//  ItemCell.h
//  MomoChat
//
//  Created by 姜自佳 on 2017/5/16.
//  Copyright © 2017年  All rights reserved.
//

#import <UIKit/UIKit.h>
@class FaceDecorationItem;
@interface ItemCell : UICollectionViewCell

@property(nonatomic,strong)FaceDecorationItem* item;
- (void)setIsSelected:(BOOL)isSelected;
- (void)sprintAnimation;
@end
