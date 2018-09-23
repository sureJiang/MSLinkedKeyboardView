//
//  FaceDecorationItem.h
//  MomoChat
//
//  Created by J on 16/8/19.
//  Copyright © 2016年  All rights reserved.
//

#import <UIKit/UIKit.h>
// 人脸装饰数据信息
@interface FaceDecorationItem : NSObject
@property (nonatomic,   copy) NSString *imgUrlStr;
@property (nonatomic, assign) BOOL      isSelected;

- (instancetype)initWithDic:(NSDictionary *)dic;
@end


// 人脸装饰底部分类选择数据信息
@interface FaceDecorationClassItem : NSObject
- (instancetype)initWithDic:(NSDictionary *)dic;

@property (nonatomic, copy) NSString *imgUrlStr;
@property (nonatomic, copy) NSString *selectedImgUrlStr;
@property (nonatomic, copy) NSString *identifier;

@end

