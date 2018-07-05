//
//  HSFCircleMenuConfig.m
//  HSFKitDemo
//
//  Created by 黄山锋 on 2018/7/5.
//  Copyright © 2018年 黄山锋. All rights reserved.
//

#import "HSFCircleMenuConfig.h"

@implementation HSFCircleMenuConfig

-(instancetype)init{
    if (self = [super init]) {
        //设置默认值
        self.radius = 150.f;
        self.titles = @[];
        self.titleColor = [UIColor whiteColor];
        self.fontSize = 10.f;
        self.bgColor = [UIColor orangeColor];
        self.space = 10.f;
        self.itemW = 40.f;
        self.direction = HSFCircleDirection_clockwise;
        self.repeatCount = 1;
        self.during = 0.5f;
        self.animation = HSFCircleAnimation_none;
        self.isCircleLayout = NO;
    }
    return self;
}


@end
