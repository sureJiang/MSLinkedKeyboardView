//
//  ViewController.m
//  DecorationViewDemo
//
//  Created by J on 2017/6/17.
//  Copyright © 2017年 J. All rights reserved.
//

#import "ViewController.h"
#import "DataManager.h"

#import "FaceDecorationView.h"
#import "DecorationTool.h"
#import "FaceDecorationPageView.h"
#import "ItemCell.h"

@interface ViewController ()<FaceDecorationViewDelegate>
@property(nonatomic,strong)FaceDecorationView* decorcationView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
    [self loadData];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self showAnimate:nil];
}

//cell选中事件
- (void)collectionView:(UICollectionView*)colleview
            selectCell:(UICollectionViewCell*)cell
             indexPath:(NSIndexPath*)indexPath
             withModel:(id)cellModel{
    
    ItemCell* itemCell = (ItemCell*)cell;
    [itemCell sprintAnimation];
}


- (void)showAnimate:(UIButton *)sender {
    
    if(self.decorcationView.hidden == NO){
        return;
    }
    UIView* view = self.decorcationView;
    view.hidden = NO;
    view.transform = CGAffineTransformMakeTranslation(0, self.decorcationView.frame.size.height);
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        view.transform = CGAffineTransformIdentity;
    } completion:nil];
}


- (void)hideAnimate:(UIButton *)sender {
    
    UIView* view = self.decorcationView;
    
    if(view.hidden)return;
    
    view.hidden = NO;
    view.transform = CGAffineTransformIdentity;
    
    [UIView animateWithDuration:0.25 animations:^{
        view.transform = CGAffineTransformMakeTranslation(0, self.decorcationView.frame.size.height);
        
    }completion:^(BOOL finished) {
        self.decorcationView.hidden = YES;
    }];
}



- (void)loadData{
    NSDictionary* resultDic = [DataManager data];
    NSMutableArray* classes = [NSMutableArray array];
    NSMutableArray* items   = [NSMutableArray array];
    
    NSArray* class = [resultDic objectForKey:@"class" kindOfClass:[NSArray class]];
    for (NSDictionary* dic in class) {
        FaceDecorationClassItem* class = [[FaceDecorationClassItem alloc] initWithDic:dic];
        [classes addObject:class];
    }
    NSDictionary* itemsDic = [resultDic objectForKey:@"items" kindOfClass:[NSDictionary class]];
    
    for (FaceDecorationClassItem* class in classes) {
        
        NSArray* item = [itemsDic objectForKey:class.identifier kindOfClass:[NSArray class]];
        NSMutableArray* marr = [NSMutableArray array];
        for (NSDictionary* dic in item) {
            
            FaceDecorationItem* item = [[FaceDecorationItem alloc] initWithDic:dic];
            [marr addObject:item];
        }
        
        [items addObject:[DecorationTool getDecorationsArrayWithDecorations:marr]];
        
    }
    [self.decorcationView updateSelectedViewItems:classes];
    [self.decorcationView updatePageItems:items];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self hideAnimate:nil];
}

-(void)createUI{
    
    CGFloat width  =  (KScreenWidth-20*2-10)*0.5;
    CGFloat height = 40;
    UIButton* showButton = [UIButton buttonWithType:UIButtonTypeCustom];
    showButton.frame = CGRectMake(20, (KScreenHeight-30)*0.5, width, height);
    [showButton addTarget:self action:@selector(showAnimate:) forControlEvents:UIControlEventTouchUpInside];
    [showButton setTitle:@"show" forState:UIControlStateNormal];
    [showButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    showButton.backgroundColor = [UIColor darkGrayColor];
    showButton.layer.cornerRadius = 2;
    [self.view addSubview:showButton];
    
    UIButton* dismissButton = [UIButton buttonWithType:UIButtonTypeCustom];
    dismissButton.frame = CGRectMake(showButton.frame.origin.x+width+10, (KScreenHeight-30)*0.5, width, height);
    [dismissButton addTarget:self action:@selector(hideAnimate:) forControlEvents:UIControlEventTouchUpInside];
    [dismissButton setTitle:@"dismiss" forState:UIControlStateNormal];
    [dismissButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    dismissButton.backgroundColor = [UIColor darkGrayColor];
    dismissButton.layer.cornerRadius = 2;
    [self.view addSubview:dismissButton];
}

#pragma mark --lazy

- (FaceDecorationView *)decorcationView{
    if(!_decorcationView){
        _decorcationView = [FaceDecorationView new];
        CGSize size = [UIScreen mainScreen].bounds.size;
        _decorcationView.frame = CGRectMake(0, size.height - 250, size.width, 250);
        _decorcationView.pageCellDelegate = self;
        [self.view addSubview:self.decorcationView];
        
    }
    return _decorcationView;
}
@end
