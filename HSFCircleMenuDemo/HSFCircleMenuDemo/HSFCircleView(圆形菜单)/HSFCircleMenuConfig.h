//
//  HSFCircleMenuConfig.h
//  HSFKitDemo
//
//  Created by 黄山锋 on 2018/7/5.
//  Copyright © 2018年 黄山锋. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, HSFCircleDirection) {
    HSFCircleDirection_clockwise = 0,//顺时针
    HSFCircleDirection_anticlockwise//逆时针
};


//>>>>>>>>>>>>>>>>>>>>第一版：bg和item动画组合到了一起<<<<<<<<<<<<<<<<<<<<<<<<

typedef NS_ENUM(NSInteger, HSFCircleAnimation) {
    HSFCircleAnimation_none = 0,//无动画
    HSFCircleAnimation_bgCircleMove,//背景圆形动画
    HSFCircleAnimation_itemCircleMove,//item圆形动画
    HSFCircleAnimation_followMove,//背景+item跟随动画
    HSFCircleAnimation_bgCircleOpen,//圆形展开动画
    HSFCircleAnimation_itemShoot,//item从中心向四周发射动画
    HSFCircleAnimation_itemShootBy//item从中心向四周依次发射动画
    //待添加更多的动画特效。。。敬请期待
};



//>>>>>>>>>>>>>>>>>>>>第二版：bg 和 item 的动画拆分开了<<<<<<<<<<<<<<<<<<<<<<<<

typedef NS_ENUM(NSInteger, HSFCircleBgAnimation) {
    HSFCircleBgAnimation_none = 0,//无动画
    HSFCircleBgAnimation_bgCircleMove,//背景圆形动画
    HSFCircleBgAnimation_bgCircleOpen,//中心圆形展开动画
    //待添加更多的动画特效。。。敬请期待
};
typedef NS_ENUM(NSInteger, HSFCircleItemAnimation) {
    HSFCircleItemAnimation_none = 0,//无动画
    HSFCircleItemAnimation_itemCircleMove,//item圆形动画
    HSFCircleItemAnimation_itemShoot,//item从中心向四周发射动画
    HSFCircleItemAnimation_itemShootBy//item从中心向四周依次发射动画
    //待添加更多的动画特效。。。敬请期待
};



@interface HSFCircleMenuConfig : NSObject

/**
 必须
 */
@property (nonatomic,strong) NSArray *icons;//图标数组

/**
 可选
 */
//appearance相关
@property (nonatomic,assign) CGFloat radius;//圆半径 （默认：150.f）
@property (nonatomic,strong) NSArray *titles;//标题数组 （默认：@[]）
@property (nonatomic,strong) UIColor *titleColor;//标题颜色 （默认：白色）
@property (nonatomic,assign) CGFloat fontSize;//标题字体大小 (默认：10)
@property (nonatomic,strong) UIColor *bgColor;//背景色 （默认：[UIColor orangeColor]）
@property (nonatomic,assign) CGFloat space;//item距离圆周边的距离 （默认：10.f）
@property (nonatomic,assign) CGFloat itemW;//item宽度 宽=高 （默认：40.f）
@property (nonatomic,strong) UIColor *itemBgColor;//item背景色 （默认：白色+alpha=0.5）
@property (nonatomic,assign) BOOL isCircleLayout;//是否基于圆周布局 （默认：否）
@property (nonatomic,strong) NSString *bgImgName;//背景图
@property (nonatomic,strong) NSString *centerImgName;//中心图
@property (nonatomic,assign) CGSize centerImgSize;//中心图大小 （默认：CGSizeMake(80.f, 80.f)）

//动画相关
@property (nonatomic,assign) HSFCircleDirection direction;//动画方向 （默认：顺时针）
@property (nonatomic,assign) NSInteger repeatCount;//动画次数 （默认：1）
@property (nonatomic,assign) CGFloat during;//动画时间 （默认：0.5f）
@property (nonatomic,assign) HSFCircleAnimation animation;//动画方式 （默认：无）
@property (nonatomic,assign) HSFCircleItemAnimation animation_item;//item动画方式 （默认：无）
@property (nonatomic,assign) HSFCircleBgAnimation animation_bg;//bg动画方式 （默认：无）
@property (nonatomic,assign) BOOL useNewAnimationWay;//是否使用新版动画方式（第二版：bg 和 item 的动画拆分开了）默认：是


/**
 *注意：
 *当使用新版动画方式（第二版：bg 和 item 的动画拆分开了）时，设置animation_item和animation_bg这两个属性可以随意自定义动画效果，此时animation属性无效
 *同理，当使用旧版动画方式（第一版：bg和item动画组合到了一起）时，设置animation可以自定义动画效果，animation_item和animation_bg这两个属性无效
 */


//待开发。。。敬请期待
//@property (nonatomic,assign) CGFloat startAngle;//开始角度
//@property (nonatomic,assign) CGFloat endAngle;//结束角度




@end
