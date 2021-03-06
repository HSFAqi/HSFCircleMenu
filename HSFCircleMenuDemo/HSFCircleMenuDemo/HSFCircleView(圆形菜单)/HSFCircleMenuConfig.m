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
        self.itemBgColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
        self.isCircleLayout = NO;
        self.bgImg = nil;
        self.centerImg = nil;
        self.centerImgSize = CGSizeMake(80.f, 80.f);
        self.direction = HSFCircleDirection_clockwise;
        self.repeatCount = 1;
        self.during = 0.5f;
        self.animation = HSFCircleAnimation_none;
        self.animation_item = HSFCircleItemAnimation_none;
        self.animation_bg = HSFCircleBgAnimation_none;
        self.useNewAnimationWay = YES;
    }
    return self;
}


@end
