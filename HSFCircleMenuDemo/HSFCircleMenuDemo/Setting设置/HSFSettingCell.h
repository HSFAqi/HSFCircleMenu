//
//  HSFSettingCell.h
//  HSFCircleMenuDemo
//
//  Created by 黄山锋 on 2018/7/6.
//  Copyright © 2018年 黄山锋. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HSFCircleMenuConfig;

@interface HSFSettingCell : UITableViewCell


//color
@property (weak, nonatomic) IBOutlet UIButton *titleColorBtn;
@property (weak, nonatomic) IBOutlet UIButton *bgColorBtn;
@property (weak, nonatomic) IBOutlet UIButton *itemBgColorBtn;

@property (weak, nonatomic) IBOutlet UIView *titleColorView;
@property (weak, nonatomic) IBOutlet UIView *bgColorView;
@property (weak, nonatomic) IBOutlet UIView *itemBgColorView;

//图片
@property (weak, nonatomic) IBOutlet UIImageView *bgImgView;
@property (weak, nonatomic) IBOutlet UIImageView *centerImgView;



@property (nonatomic,strong) HSFCircleMenuConfig *config;



@end
