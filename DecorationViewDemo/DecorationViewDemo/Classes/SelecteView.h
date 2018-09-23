//
//  SelecteView.h
//  DEMO
//
//  Created by 姜自佳 on 2017/5/7.
//  Copyright © 2017年 JZJ. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FaceDecorationClassItem;
@protocol SelecteViewDelegate <NSObject>

- (void)clickCompeletionHandler:(UIButton *)button;
//联动调用
- (void)scrollToSetSelectedIndexHandler:(UIButton *)button isDeCending:(BOOL)isDeCending;

@end
@interface SelecteView : UIView
- (NSArray*)emotions;
- (void)addItems:(NSArray<FaceDecorationClassItem*>*)emotions;


// 点击按钮回调
@property (copy,  nonatomic) void(^clickCompeletionHandler)(UIButton *button);
////联动调用
@property (copy,  nonatomic) void(^scrollToSetSelectedIndexHandler)(UIButton *button,BOOL isDeCending);
@property (copy,  nonatomic) void(^clearDecorationBlock)(UIButton *button);
@property (assign,nonatomic) BOOL isDeCending;
@property (assign,nonatomic) id <SelecteViewDelegate> delegate;

// 联动设置当前选中按钮
- (void)setCurrentButtonIndex:(NSInteger)index;
- (NSInteger)currentIndex;
@end
