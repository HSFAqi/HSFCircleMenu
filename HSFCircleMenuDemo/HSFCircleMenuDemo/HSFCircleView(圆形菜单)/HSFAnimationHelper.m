//
//  HSFAnimationHelper.m
//  HSFCircleMenuDemo
//
//  Created by 黄山锋 on 2018/7/5.
//  Copyright © 2018年 黄山锋. All rights reserved.
//

#import "HSFAnimationHelper.h"

#import "HSFCircleMenuConfig.h"
#import "HSFTool.h"

@interface HSFAnimationHelper ()

@property (nonatomic,strong) NSArray *items;
@property (nonatomic,strong) NSArray *itemCenterPointArr;

@end

@implementation HSFAnimationHelper

/* 动画类型 */

#pragma mark HSFCircleBgAnimation
//HSFCircleBgAnimation_bgCircleMove
-(void)animation_bgCircleMove_for:(CALayer *)maskLayer{
    CABasicAnimation *animation_normal = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation_normal.fromValue = @0;
    animation_normal.toValue = @1;
    animation_normal.duration = self.config.during;
    animation_normal.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation_normal.repeatCount = self.config.repeatCount;
    animation_normal.removedOnCompletion = NO;
    animation_normal.fillMode = kCAFillModeForwards;
    [maskLayer addAnimation:animation_normal forKey:@"ani"];
}

//HSFCircleBgAnimation_bgCircleOpen
-(void)animation_bgCircleOpen_withOpenLayerArr:(NSArray *)openLayerArr{
    __block typeof(self) weakSelf = self;
    [openLayerArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CALayer *layer = (CALayer *)obj;
        //动画
        CABasicAnimation *animation_normal = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        if (kStringIsEmpty(weakSelf.config.bgImgName)) {
            animation_normal.fromValue = @0;
            animation_normal.toValue = @1;
        }else{
            animation_normal.fromValue = @1;
            animation_normal.toValue = @0;
        }
        animation_normal.duration = self.config.during;
        animation_normal.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        animation_normal.repeatCount = self.config.repeatCount;
        animation_normal.removedOnCompletion = NO;
        animation_normal.fillMode = kCAFillModeForwards;
        [layer addAnimation:animation_normal forKey:nil];
    }];
}



#pragma mark HSFCircleItemAnimation
//HSFCircleItemAnimation_itemCircleMove
-(void)animation_itemCircleMove_for:(CALayer *)layer{
    CABasicAnimation *animation_follow = [CABasicAnimation new];
    animation_follow.keyPath = @"transform.rotation.z";
    if (self.config.direction == HSFCircleDirection_clockwise) {
        animation_follow.fromValue = @(0);
        animation_follow.toValue = @(M_PI*2);
    }else{
        animation_follow.fromValue = @(0);
        animation_follow.toValue = @(-M_PI*2);
    }
    animation_follow.duration = self.config.during;
    animation_follow.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation_follow.repeatCount = self.config.repeatCount;
    animation_follow.removedOnCompletion = NO;
    animation_follow.fillMode = kCAFillModeForwards;
    [layer addAnimation:animation_follow forKey:@"rotation"];
}

//HSFCircleItemAnimation_itemShoot
-(void)animation_itemShoot_withItems:(NSArray *)items itemCenterPointArr:(NSArray *)itemCenterPointArr{
    self.items = items;
    self.itemCenterPointArr = itemCenterPointArr;
    //复位
    //[self resetItemPositionWith:items];
    //动画
    __block typeof(self) weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        for (int i = 0; i < items.count; i++) {
            NSValue *toValue = itemCenterPointArr[i];
            __block CGPoint toPoint = toValue.CGPointValue;
            __block UIView *item = items[i];
            
            //方法一：需要打开复位代码
//            [UIView animateWithDuration:weakSelf.config.during animations:^{
//                [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
//                item.frame = CGRectMake(toPoint.x-item.frame.size.width/2.f, toPoint.y-item.frame.size.height/2.f, item.frame.size.width, item.frame.size.height);
//            }];
            
            
            //方法二：
            CABasicAnimation *animation_normal = [CABasicAnimation animationWithKeyPath:@"position"];
            animation_normal.fromValue = [NSValue valueWithCGPoint:CGPointMake(weakSelf.config.radius, weakSelf.config.radius)];
            animation_normal.toValue = toValue;
            animation_normal.duration = self.config.during;
            animation_normal.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            animation_normal.repeatCount = self.config.repeatCount;
            animation_normal.removedOnCompletion = NO;
            animation_normal.fillMode = kCAFillModeForwards;
            [item.layer addAnimation:animation_normal forKey:@"ani"];
        }
    });
}

//HSFCircleItemAnimation_itemShootBy
-(void)animation_itemShootBy_withItems:(NSArray *)items itemCenterPointArr:(NSArray *)itemCenterPointArr{
    self.items = items;
    self.itemCenterPointArr = itemCenterPointArr;
    
    __block typeof(self) weakSelf = self;
    //复位
    //[self resetItemPositionWith:items];
    
    
    //    //方法一：需要打开复位代码
    //    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    //        [weakSelf itemShootBy:0];
    //    });
    
    //方法二：
    [items enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIView *item = (UIView *)obj;
        item.hidden = YES;
    }];
    for (int i = 0; i < items.count; i++) {
        NSValue *toValue = itemCenterPointArr[i];
        __block CGPoint toPoint = toValue.CGPointValue;
        __block UIView *item = items[i];
        
        CGFloat perDuring = self.config.during/items.count;
        //        CGFloat aheadDuring = perDuring/3.f;
        CGFloat aheadDuring = 0.f;
        CGFloat startTime = (perDuring*i-aheadDuring);
        if (i == 0) {
            startTime = 0.f;
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(startTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            item.hidden = NO;
            CABasicAnimation *animation_normal = [CABasicAnimation animationWithKeyPath:@"position"];
            animation_normal.fromValue = [NSValue valueWithCGPoint:CGPointMake(weakSelf.config.radius, weakSelf.config.radius)];
            animation_normal.toValue = toValue;
            animation_normal.duration = self.config.during;
            animation_normal.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
            animation_normal.repeatCount = self.config.repeatCount;
            animation_normal.removedOnCompletion = NO;
            animation_normal.fillMode = kCAFillModeForwards;
            [item.layer addAnimation:animation_normal forKey:@"ani"];
        });
    }
}
-(void)itemShootBy:(NSInteger)i {
    NSValue *toValue = self.itemCenterPointArr[i];
    __block CGPoint toPoint = toValue.CGPointValue;
    __block UIView *item = self.items[i];
    __block typeof(self) weakSelf = self;
    __block NSInteger index = i;
    [UIView animateWithDuration:self.config.during/self.items.count animations:^{
        //方法一：需要打开复位代码
        [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
        item.frame = CGRectMake(toPoint.x-item.frame.size.width/2.f, toPoint.y-item.frame.size.height/2.f, item.frame.size.width, item.frame.size.height);
    }completion:^(BOOL finished) {
        if (index < self.items.count-1) {
            index++;
            [weakSelf itemShootBy:index];
        }
    }];
}
//复位
-(void)resetItemPositionWith:(NSArray *)items{
    __block typeof(self) weakSelf = self;
    [items enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIView *item = (UIView *)obj;
        item.center = CGPointMake(weakSelf.config.radius, weakSelf.config.radius);
    }];
}


@end
