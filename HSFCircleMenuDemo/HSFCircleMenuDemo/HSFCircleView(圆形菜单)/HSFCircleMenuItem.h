//
//  HSFCircleMenuItem.h
//  HSFKitDemo
//
//  Created by 黄山锋 on 2018/7/3.
//  Copyright © 2018年 黄山锋. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface HSFCircleMenuItem : UIView

@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) UIColor *titleColor;
@property (nonatomic,assign) CGFloat fontSize;
@property (nonatomic,strong) NSString *icon;


//初始化方法
-(instancetype)initWithTitle:(NSString *)title titleColor:(UIColor *)titleColor fontSize:(CGFloat)fontSize icon:(NSString *)icon;




@end
