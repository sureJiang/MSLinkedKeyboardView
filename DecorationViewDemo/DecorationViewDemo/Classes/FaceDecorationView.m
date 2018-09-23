//
//  ExpressionEecorationController.m
//  DEMo
//
//  Created by 姜自佳 on 2017/5/11.
//  Copyright © 2017年 JZJ. All rights reserved.
//

#import "FaceDecorationView.h"
#import "FaceDecorationPageView.h"
#import "SelecteView.h"
#import "DecorationTool.h"
#import "FaceDecorationItem.h"
#import "DecorationTool.h"

@interface FaceDecorationView ()


@property (nonatomic,strong) FaceDecorationPageView *decorationPageView;
@property (nonatomic,strong) UIPageControl          *pageControl;
@property (nonatomic,strong) SelecteView            *bottomClassSelecteView;
@property (nonatomic,strong) UIVisualEffectView     *effectView;
@property (nonatomic,assign) NSInteger               currentSelectedSection;
@property (nonatomic,  copy) dispatch_block_t        cleanDecoration ;
@end

@implementation FaceDecorationView

- (instancetype)initWithSelectedBlock:(dispatch_block_t)cleanDecoration{
    if(self = [super init]){
        self.cleanDecoration = cleanDecoration;
    }
    return self;
}


- (void)didMoveToSuperview{
    [self prepareView];
}



- (void)updateSelectedViewItems:(NSArray*)array{
    [self.bottomClassSelecteView addItems:array];
}

- (void)updatePageItems:(NSArray*)array{
    self.decorationPageView.dataArray = array;
    [self.decorationPageView reloadData];
    NSArray* arr = [array objectAtIndexSafe:0];
    self.pageControl.numberOfPages = [arr count]/kMaxDecorationCount;
}


- (void)prepareView {
   
    self.effectView.translatesAutoresizingMaskIntoConstraints = NO;
    self.bottomClassSelecteView.translatesAutoresizingMaskIntoConstraints = NO;
    self.decorationPageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.pageControl.translatesAutoresizingMaskIntoConstraints = NO;

    NSDictionary* views = NSDictionaryOfVariableBindings(_effectView,_bottomClassSelecteView,_decorationPageView,_pageControl);
    
    NSString *vfl1 = @"V:|-0-[_decorationPageView]-0-[_pageControl(20)]-0-[_bottomClassSelecteView(50)]-0-|";
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:vfl1 options:0 metrics:nil views:views]];
    
    
    NSString *decorationPageView = @"H:|-0-[_decorationPageView]-0-|";
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:decorationPageView options:0 metrics:nil views:views]];
    
    
    NSString *pageControl = @"H:|-0-[_pageControl]-0-|";
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:pageControl options:0 metrics:nil views:views]];

    NSString *bottomClassSelecteView = @"H:|-0-[_bottomClassSelecteView]-0-|";
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:bottomClassSelecteView options:0 metrics:nil views:views]];

    
    NSString *effectView = @"H:|-0-[_effectView]-0-|";
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:effectView options:0 metrics:nil views:views]];

    
    
    NSLayoutConstraint* constraint =  [NSLayoutConstraint constraintWithItem:self.decorationPageView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
    [self addConstraints:@[constraint]];
    
    
    NSLayoutConstraint* pageControlconstrain =  [NSLayoutConstraint constraintWithItem:self.pageControl attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
    [self addConstraints:@[pageControlconstrain]];
    
    
    NSLayoutConstraint* bottomClassSelecteViewConstraint =  [NSLayoutConstraint constraintWithItem:self.bottomClassSelecteView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
    [self addConstraints:@[bottomClassSelecteViewConstraint]];
    

   
  
    NSLayoutConstraint* effectViewTop =  [NSLayoutConstraint constraintWithItem:self.effectView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
    [self addConstraints:@[effectViewTop]];
    
    
    NSLayoutConstraint* effectViewBottom =  [NSLayoutConstraint constraintWithItem:self.effectView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:50];
    [self addConstraints:@[effectViewBottom]];
    
}

- (SelecteView *)bottomClassSelecteView{
    if(!_bottomClassSelecteView){
        _bottomClassSelecteView = [SelecteView new];
        [self addSubview:_bottomClassSelecteView];
        WEAKSelf
        //点击某个分类
        [_bottomClassSelecteView setClickCompeletionHandler:^(UIButton *button){            
            NSInteger index = [button.superview.subviews indexOfObject:button];
            [weakSelf updatePageControl:button];
            
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:index];
            [UIView performWithoutAnimation:^{
                [weakSelf.decorationPageView reloadItemsAtIndexPaths:@[indexPath]];
            }];
            [weakSelf.decorationPageView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
           }];
        
        
        //滚动到某个分类
        [_bottomClassSelecteView setScrollToSetSelectedIndexHandler:^(UIButton *button,BOOL isDeCending){
            [weakSelf updatePageControl:button];
        }];
        
        //清除变脸
        [_bottomClassSelecteView setClearDecorationBlock:^(UIButton *button){
            if(weakSelf.cleanDecoration){
                weakSelf.cleanDecoration();
            }

        }];
    }
    return _bottomClassSelecteView;
}

- (void)updatePageControl:(UIButton*)sender{
    WEAKSelf
    NSInteger index = [sender.superview.subviews indexOfObject:sender];
    weakSelf.currentSelectedSection = index;
    NSArray* arr = [weakSelf.decorationPageView.dataArray objectAtIndexSafe:index];
    weakSelf.pageControl.numberOfPages =  arr.count/kMaxDecorationCount;
    weakSelf.pageControl.currentPage = 0;
}


#pragma mark - lazy

- (FaceDecorationPageView *)decorationPageView {
    
    if (_decorationPageView == nil) {
        CGSize itemSize = CGSizeMake([UIScreen mainScreen].bounds.size.width/kDecorationsColCount, kDecorationsRowHeight);
        _decorationPageView = [[FaceDecorationPageView alloc] initWithItemSize:itemSize];
        _decorationPageView.pageCellDelegate = self.pageCellDelegate;
        
        WEAKSelf
        [_decorationPageView setCurrentSectionBlock:^(NSInteger currentSection,NSInteger allCount,NSInteger currentPageIndex){
            
            weakSelf.pageControl.numberOfPages  = allCount;
            weakSelf.pageControl.currentPage    = currentPageIndex;
            if (weakSelf.currentSelectedSection == currentSection) {
                return;
            }
            weakSelf.currentSelectedSection = currentSection;
                // 设置选中按钮
            [weakSelf.bottomClassSelecteView setCurrentButtonIndex:currentSection];
        }];
        [self addSubview:_decorationPageView];
    }
    return _decorationPageView;
}


- (UIPageControl *)pageControl {
    
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.currentPage = 0;
        _pageControl.pageIndicatorTintColor        = pagecontrolIndicatorColor;
        _pageControl.currentPageIndicatorTintColor = pagecontrolCurrentColor;
        [self addSubview:_pageControl];
    }
    return _pageControl;
}


- (UIVisualEffectView *)effectView{
    if(!_effectView){
        _effectView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
        _effectView.backgroundColor = unifiedColor;
        [self addSubview:_effectView];
    }
    return _effectView;
}

- (UICollectionView *)collectionView{
    return self.decorationPageView;
}

@end
