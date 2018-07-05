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


/* 约束布局Masonry */
#import <Masonry/Masonry.h>
/* 提示View */
#import <TYAlertController/TYAlertController.h>
#import "UIView+TYAlertView.h"





#endif /* HSFTool_h */
