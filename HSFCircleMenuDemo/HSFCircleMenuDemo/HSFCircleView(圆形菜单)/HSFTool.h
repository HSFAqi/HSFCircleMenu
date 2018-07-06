//
//  HSFTool.h
//  HSFCircleMenuDemo
//
//  Created by 黄山锋 on 2018/7/4.
//  Copyright © 2018年 黄山锋. All rights reserved.
//

#ifndef HSFTool_h
#define HSFTool_h


//字符串是否为空
#define kStringIsEmpty(str) ([str isKindOfClass:[NSNull class]] || str == nil || [str length] < 1 ? YES : NO )
//颜色
#define kRGBColor(r, g, b)     [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define kRGBAColor(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(r)/255.0 blue:(r)/255.0 alpha:a]
#define kRandomColor  kRGBColor(arc4random_uniform(256)/255.0f,arc4random_uniform(256)/255.0f,arc4random_uniform(256)/255.0f)

#define kColorWithHex(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16)) / 255.0 green:((float)((rgbValue & 0xFF00) >> 8)) / 255.0 blue:((float)(rgbValue & 0xFF)) / 255.0 alpha:1.0]


/* 约束布局Masonry */
#import <Masonry/Masonry.h>
/* 提示View */
#import <TYAlertController/TYAlertController.h>
#import "UIView+TYAlertView.h"





#endif /* HSFTool_h */
