//
//  ItemCell.m
//  MomoChat
//
//  Created by 姜自佳 on 2017/5/16.
//  Copyright © 2017年  All rights reserved.
//

#import "ItemCell.h"
#import "FaceDecorationItem.h"

@interface ItemCell()
@property(nonatomic,strong)UIButton *button;
@end

@implementation ItemCell
- (void)setItem:(FaceDecorationItem *)item{
    _item = item;

    UIImage* image = [UIImage imageNamed:item.imgUrlStr];
    [self.button setImage:image forState:UIControlStateNormal];
}

- (void)setIsSelected:(BOOL)isSelected{
    self.item.isSelected = isSelected;
}


- (void)sprintAnimation{
    [self.button.imageView spingAnimation];
}


#pragma mark --lazy
- (UIButton *)button{
    
    if(!_button){
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        _button.enabled = NO;
        _button.adjustsImageWhenDisabled = NO;
        
        [self.contentView addSubview:_button];
        UIView* superView = self.contentView;
        
        [_button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(superView);
        }];
        [_button.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(60, 60));
            make.center.mas_equalTo(superView);
        }];
    }
    return _button;
}


@end
