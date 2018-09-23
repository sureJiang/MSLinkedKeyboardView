//
//  ExpressionEecorationController.h
//  DEMo
//
//  Created by 姜自佳 on 2017/5/11.
//  Copyright © 2017年 JZJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FaceDecorationViewDelegate.h"


@class FaceDecorationPageView;
@interface FaceDecorationView : UIView

- (instancetype)initWithSelectedBlock:(dispatch_block_t)block;
- (void)updateSelectedViewItems:(NSArray*)array;//分类选择
- (void)updatePageItems:(NSArray*)array;//变脸数据
- (FaceDecorationPageView*)collectionView;
@property (nonatomic, weak) id<FaceDecorationViewDelegate> pageCellDelegate;

@end
