//
//  DataManager.m
//  DecorationViewDemo
//
//  Created by 姜自佳 on 2017/5/24.
//  Copyright © 2017年 JZJ. All rights reserved.
//

#import "DataManager.h"

@implementation DataManager

+ (NSDictionary*)data{
    NSString *path    = [[NSBundle mainBundle] pathForResource:@"json.json" ofType:nil];
    NSData *jsonData  = [NSData dataWithContentsOfFile:path];
    NSDictionary* dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:nil];
    NSDictionary* resultDic =[dic objectForKey:@"data" kindOfClass:[NSDictionary class]];
    return resultDic;
}
@end
