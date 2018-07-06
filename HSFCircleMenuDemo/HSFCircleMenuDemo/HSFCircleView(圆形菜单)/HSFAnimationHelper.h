//
//  HSFAnimationHelper.h
//  HSFCircleMenuDemo
//
//  Created by 黄山锋 on 2018/7/5.
//  Copyright © 2018年 黄山锋. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

@class HSFCircleMenuConfig;

@interface HSFAnimationHelper : NSObject

@property (nonatomic,strong) HSFCircleMenuConfig *config;


/* 动画类型 */

#pragma mark HSFCircleBgAnimation

/**
 背景圆形动画--HSFCircleBgAnimation_bgCircleMove
 */
-(void)animation_bgCircleMove_for:(CALayer *)maskLayer;

/**
 中心圆形展开动画--HSFCircleBgAnimation_bgCircleOpen
 */
-(void)animation_bgCircleOpen_withOpenLayerArr:(NSArray *)openLayerArr;



#pragma mark HSFCircleItemAnimation
/**
 item圆形动画--HSFCircleItemAnimation_itemCircleMove
 */
-(void)animation_itemCircleMove_for:(CALayer *)layer;

/**
 item从中心向四周发射动画--HSFCircleItemAnimation_itemShoot
 */
-(void)animation_itemShoot_withItems:(NSArray *)items itemCenterPointArr:(NSArray *)itemCenterPointArr;

/**
 item从中心向四周依次发射动画--HSFCircleItemAnimation_itemShootBy
 */
-(void)animation_itemShootBy_withItems:(NSArray *)items itemCenterPointArr:(NSArray *)itemCenterPointArr;

/**
 复位-回到中心
 */
-(void)resetItemPositionWith:(NSArray *)items;






@end
