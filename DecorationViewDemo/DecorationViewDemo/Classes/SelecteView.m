//
//  SelecteView.m
//  DEMO
//
//  Created by 姜自佳 on 2017/5/7.
//  Copyright © 2017年 JZJ. All rights reserved.
//

#import "SelecteView.h"
#import "FaceDecorationItem.h"

static const CGFloat itemWidth = 60;
static const CGFloat kBottomImageViewWidth = 27;//button.imageView 的大小

@interface SelecteView()
@property(nonatomic,strong) UIScrollView *selectScrollView;
@property(nonatomic,strong) NSArray      *emotions;
@property (nonatomic,strong)UIButton     *currentButton;// 记录选中按钮


@end
@implementation SelecteView

- (NSArray*)emotions{
    return _emotions;
}

- (NSInteger)currentIndex{
   return  [self.currentButton.superview.subviews indexOfObject:self.currentButton];
}

- (void)addItems:(NSArray<FaceDecorationClassItem*>*)emotions{
    if(!emotions.count){
        return;
    }
    [self.selectScrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.emotions = emotions;
    NSInteger count = emotions.count;
    UIScrollView* scrollView = self.selectScrollView;
    [self addSubview:scrollView];
    UIView *containerView= [UIView new];
    [scrollView addSubview:containerView];
    [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(scrollView);
        make.height.equalTo(scrollView);
    }];
    
    for (NSInteger i = 0; i<count; i++) {
        FaceDecorationClassItem* item = emotions[i];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button addTarget:self action:@selector(scrBtn:) forControlEvents:UIControlEventTouchUpInside];
        [button.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(kBottomImageViewWidth, kBottomImageViewWidth));
            make.centerX.centerY.equalTo(button);
        }];
        
        [button setImage:[UIImage imageNamed:item.imgUrlStr] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:item.selectedImgUrlStr] forState:UIControlStateSelected];
        UIView* lastButton = containerView.subviews.lastObject;
        [containerView addSubview:button];
        [button mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.height.equalTo(containerView);
            make.width.mas_equalTo(itemWidth);
            if(i==0){
                make.left.equalTo(containerView);
            }
            else if(lastButton){
                make.left.mas_equalTo(lastButton.mas_right);
            }
            if(i==count-1){
                make.right.equalTo(containerView);
            }
        }];
    }
    scrollView.contentSize = CGSizeMake(itemWidth*count, 0);
    [self selectItemWithIndex:0];
    [self topLineView];
}

- (void)selectItemWithIndex:(NSInteger)index{
    UIButton *button = self.selectScrollView.subviews.firstObject.subviews[index];
    if (self.currentButton == button) {
        return;
    }
    [self setContentOfset:button];
    button.selected = YES;
    self.currentButton = button;
}

-(void)scrBtn:(UIButton *)sender{
    [sender.imageView spingAnimation];
    if (self.currentButton == sender) {
        return;
    }
    
    [self setContentOfset:sender];
    self.currentButton.selected = NO;
    sender.selected = YES;
    self.currentButton = sender;
    if (self.clickCompeletionHandler) {
        self.clickCompeletionHandler(sender);
    }
    if([self.delegate respondsToSelector:@selector(clickCompeletionHandler:)]){
        [self.delegate clickCompeletionHandler:sender];
    }
}

//清除变脸
- (void)clearDecoration:(UIButton*)sender{
    [sender.imageView spingAnimation];
    if(self.clearDecorationBlock){
        self.clearDecorationBlock(sender);
    }
}


- (void)setContentOfset:(UIButton *)sender{
    UIScrollView* scrollView = self.selectScrollView;

    if ((sender.frame.origin.x >= scrollView.contentOffset.x) && CGRectGetMaxX(sender.frame)<= scrollView.contentOffset.x + scrollView.bounds.size.width){
        return;
    }
    CGFloat offsetX = 0;
    if (sender.frame.origin.x <= scrollView.contentOffset.x){
        offsetX = sender.frame.origin.x - scrollView.contentOffset.x;
    }
    else{
        offsetX = CGRectGetMaxX(sender.frame) - (scrollView.contentOffset.x + scrollView.bounds.size.width);
    }
    [UIView animateWithDuration:0.25 animations:^{
        CGPoint originOffSet = scrollView.contentOffset;
        originOffSet.x = originOffSet.x + offsetX;
        scrollView.contentOffset = originOffSet;
    }];
}

- (void)setCurrentButton:(UIButton *)currentButton{
    _currentButton.backgroundColor = currentButton.superview.backgroundColor;
    _currentButton = currentButton;
    currentButton.backgroundColor = unifiedColor;
}

- (void)setCurrentButtonIndex:(NSInteger)index {
     UIButton *button = self.selectScrollView.subviews.firstObject.subviews[index];
    if (self.currentButton == button) {
        return;
    }
    [self setContentOfset:button];
    self.currentButton.selected = NO;
    button.selected = YES;
    self.currentButton = button;
}


- (UIScrollView *)selectScrollView{
    if(!_selectScrollView){
        _selectScrollView = [UIScrollView  new];
        _selectScrollView.showsHorizontalScrollIndicator = NO;
        _selectScrollView.showsVerticalScrollIndicator = NO;
        [self addSubview:_selectScrollView];
        [_selectScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.left.height.equalTo(self);
        }];
    }
    return _selectScrollView;
}




- (UIView*)topLineView{//分割线view
    UIView* topLineView = [UIView new];//横线view
    topLineView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.1];
    [self addSubview:topLineView];
    [topLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.centerX.equalTo(self);
        make.top.equalTo(self.mas_top);
        make.height.equalTo(@0.5);
    }];
    return topLineView;
}


@end
