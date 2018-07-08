//
//  ColorSettingVC.h
//  HSFCircleMenuDemo
//
//  Created by 黄山锋 on 2018/7/6.
//  Copyright © 2018年 黄山锋. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ColorSettingVC : UIViewController

@property (nonatomic,strong) NSString *titleStr;
@property (copy, nonatomic) void(^curSelectColorBlock)(UIColor *color);

@end
