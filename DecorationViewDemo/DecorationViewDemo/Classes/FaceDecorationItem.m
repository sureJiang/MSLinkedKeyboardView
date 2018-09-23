//
//  FaceDecorationItem.m
//  MomoChat
//
//  Created by J on 16/8/19.
//  Copyright © 2016年  All rights reserved.
//

#import "FaceDecorationItem.h"

@implementation FaceDecorationItem

- (instancetype)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        self.imgUrlStr  = [dic objectForKey:@"image_url" kindOfClass:NSString.class];
    }
    return self;
}

@end


// 人脸装饰底部分类选择数据信息
@implementation FaceDecorationClassItem : NSObject


- (instancetype)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {

        self.identifier = [dic objectForKey:@"id" kindOfClass:NSString.class];
        self.imgUrlStr  = [dic objectForKey:@"image_url" kindOfClass:NSString.class];
        self.selectedImgUrlStr = [dic objectForKey:@"selected_image_url" kindOfClass:NSString.class];
}
    return self;
}

@end
