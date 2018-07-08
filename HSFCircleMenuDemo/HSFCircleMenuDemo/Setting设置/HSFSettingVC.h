//
//  HSFSettingVC.h
//  HSFCircleMenuDemo
//
//  Created by 黄山锋 on 2018/7/6.
//  Copyright © 2018年 黄山锋. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HSFCircleMenuConfig;

@protocol HSFSettingVCDelegate <NSObject>
@optional
-(void)saveSettingWithConfig:(HSFCircleMenuConfig *)config;
@end

@interface HSFSettingVC : UIViewController

@property (nonatomic,strong) HSFCircleMenuConfig *config;
@property (nonatomic,weak) id<HSFSettingVCDelegate> delegate;

@end
