//
//  HSFCircleMenu.h
//  testDemo
//
//  Created by 黄山锋 on 2018/6/29.
//  Copyright © 2018年 黄山锋. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, HSFCircleDirection) {
    HSFCircleDirection_clockwise = 0,//顺时针
    HSFCircleDirection_anticlockwise//逆时针
};
typedef NS_ENUM(NSInteger, HSFCircleAnimation) {
    HSFCircleAnimation_none = 0,//无动画
    HSFCircleAnimation_bgCircleMove,//背景圆形动画
    HSFCircleAnimation_itemCircleMove,//item圆形动画
    HSFCircleAnimation_followMove,//背景+item跟随效果
    HSFCircleAnimation_circleOpen//圆形展开
    //待添加更多的动画特效。。。敬请期待
};

@class HSFCircleMenuConfig;

@interface HSFCircleMenu : UIView

//必须
@property (nonatomic,strong) NSArray *icons;//图标数组
@property (nonatomic,assign) CGFloat radius;//圆半径

//可选
@property (nonatomic,strong) NSArray *titles;//标题数组 （默认：@[]）
@property (nonatomic,strong) UIColor *bgColor;//背景色 （默认：[UIColor orangeColor]）
@property (nonatomic,assign) CGFloat space;//item距离圆周边的距离 （默认：10.f）
@property (nonatomic,assign) CGFloat itemW;//item宽度 宽=高 （默认：40.f）
@property (nonatomic,assign) HSFCircleDirection direction;//动画方向 （默认：顺时针）
@property (nonatomic,assign) NSInteger repeatCount;//动画次数 （默认：1）
@property (nonatomic,assign) CGFloat during;//动画时间 （默认：0.5f）
@property (nonatomic,assign) HSFCircleAnimation animation;//动画方式 （默认：无）


//单击item回调
@property (nonatomic, copy) void (^HSFCircleMenuClickItemBlock)(NSInteger tag);


/* 不推荐初始化方法：初始化后在对所有属性逐一赋值，最后setUp */
-(void)setUp;


//注意：如果只需要显示icon则titles可以不用设置，传@[]即可
#pragma mark 初始化方法(推荐)
/**
 默认none动画 + 顺时针 + during=0.5f + repeatCount=1 + space = 10.f + itemW=40.f + bgColor=orangeColor
 */
-(instancetype)initWithCenter:(CGPoint)center
                        icons:(NSArray *)icons
                       radius:(CGFloat)radius
                       titles:(NSArray *)titles;

/**
 默认none动画 + 顺时针 + during=0.5f + repeatCount=1 + space = 10.f + itemW=40.f
 */
-(instancetype)initWithCenter:(CGPoint)center
                        icons:(NSArray *)icons
                       radius:(CGFloat)radius
                       titles:(NSArray *)titles
                      bgColor:(UIColor *)bgColor;

/**
 默认none动画 + 顺时针 + during=0.5f + repeatCount=1 + space = 10.f
 */
-(instancetype)initWithCenter:(CGPoint)center
                        icons:(NSArray *)icons
                       radius:(CGFloat)radius
                       titles:(NSArray *)titles
                      bgColor:(UIColor *)bgColor
                        itemW:(CGFloat)itemW;

/**
 默认none动画 + 顺时针 + during=0.5f + repeatCount=1
 */
-(instancetype)initWithCenter:(CGPoint)center
                        icons:(NSArray *)icons
                       radius:(CGFloat)radius
                       titles:(NSArray *)titles
                      bgColor:(UIColor *)bgColor
                        itemW:(CGFloat)itemW
                        space:(CGFloat)space;

/**
 默认none动画 + 顺时针 + during=0.5f
 */
-(instancetype)initWithCenter:(CGPoint)center
                        icons:(NSArray *)icons
                       radius:(CGFloat)radius
                       titles:(NSArray *)titles
                      bgColor:(UIColor *)bgColor
                        itemW:(CGFloat)itemW
                        space:(CGFloat)space
                  repeatCount:(NSInteger)repeatCount;

/**
 默认none动画 + 顺时针
 */
-(instancetype)initWithCenter:(CGPoint)center
                        icons:(NSArray *)icons
                       radius:(CGFloat)radius
                       titles:(NSArray *)titles
                      bgColor:(UIColor *)bgColor
                        itemW:(CGFloat)itemW
                        space:(CGFloat)space
                  repeatCount:(NSInteger)repeatCount
                       during:(CGFloat)during;

/**
 默认none动画
 */
-(instancetype)initWithCenter:(CGPoint)center
                        icons:(NSArray *)icons
                       radius:(CGFloat)radius
                       titles:(NSArray *)titles
                      bgColor:(UIColor *)bgColor
                        itemW:(CGFloat)itemW
                        space:(CGFloat)space
                  repeatCount:(NSInteger)repeatCount
                       during:(CGFloat)during
                    direction:(HSFCircleDirection)direction;

/**
 指定初始化方法
 */
-(instancetype)initWithCenter:(CGPoint)center
                        icons:(NSArray *)icons
                       radius:(CGFloat)radius
                       titles:(NSArray *)titles
                      bgColor:(UIColor *)bgColor
                        itemW:(CGFloat)itemW
                        space:(CGFloat)space
                  repeatCount:(NSInteger)repeatCount
                       during:(CGFloat)during
                    direction:(HSFCircleDirection)direction
                    animation:(HSFCircleAnimation)animation;



#pragma mark 方法
-(void)startAnimaiton;
-(void)puaseAnimation;



#pragma mark 更改样式-重置
-(HSFCircleMenu *)reset;



@end
