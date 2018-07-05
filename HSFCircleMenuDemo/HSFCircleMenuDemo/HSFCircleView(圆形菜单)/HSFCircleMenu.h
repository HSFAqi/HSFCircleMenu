//
//  HSFCircleMenu.h
//  testDemo
//
//  Created by 黄山锋 on 2018/6/29.
//  Copyright © 2018年 黄山锋. All rights reserved.
//

#import <UIKit/UIKit.h>



@class HSFCircleMenuConfig;

@interface HSFCircleMenu : UIView

//config
@property (nonatomic,strong) HSFCircleMenuConfig *config;
//单击item回调
@property (nonatomic, copy) void (^HSFCircleMenuClickItemBlock)(NSInteger tag);



#pragma mark 初始化方法
+(instancetype)menuWithConfig:(HSFCircleMenuConfig *)config;



#pragma mark 方法
-(void)startAnimaiton;
-(void)puaseAnimation;


#pragma mark 设置背景图片bgImgView
-(void)setBgImg:(NSString *)imgName;
#pragma mark 设置中心图片centerImgView
-(void)setCenterImg:(NSString *)imgName size:(CGSize)size;





@end
