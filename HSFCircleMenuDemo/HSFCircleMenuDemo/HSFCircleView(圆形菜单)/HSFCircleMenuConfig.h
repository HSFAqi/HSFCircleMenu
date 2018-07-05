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

@interface HSFCircleMenuConfig : NSObject

//必须
@property (nonatomic,strong) NSArray *icons;//图标数组

//可选
@property (nonatomic,assign) CGFloat radius;//圆半径
@property (nonatomic,strong) NSArray *titles;//标题数组 （默认：@[]）
@property (nonatomic,strong) UIColor *bgColor;//背景色 （默认：[UIColor orangeColor]）
@property (nonatomic,assign) CGFloat space;//item距离圆周边的距离 （默认：10.f）
@property (nonatomic,assign) CGFloat itemW;//item宽度 宽=高 （默认：40.f）
@property (nonatomic,assign) HSFCircleDirection direction;//动画方向 （默认：顺时针）
@property (nonatomic,assign) NSInteger repeatCount;//动画次数 （默认：1）
@property (nonatomic,assign) CGFloat during;//动画时间 （默认：0.5f）
@property (nonatomic,assign) HSFCircleAnimation animation;//动画方式 （默认：无）


//待开发。。。敬请期待
//@property (nonatomic,assign) CGFloat startAngle;//开始角度
//@property (nonatomic,assign) CGFloat endAngle;//结束角度




@end
