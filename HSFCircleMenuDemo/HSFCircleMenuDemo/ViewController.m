//
//  ViewController.m
//  HSFCircleMenuDemo
//
//  Created by 黄山锋 on 2018/7/4.
//  Copyright © 2018年 黄山锋. All rights reserved.
//

#import "ViewController.h"

#import "HSFTool.h"
#import "HSFCircleMenu.h"
#import "HSFCircleMenuConfig.h"

@interface ViewController ()

@property (nonatomic,strong) TYAlertController *alertC;
@property (nonatomic,strong) HSFCircleMenu *circleView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //@[@"风车", @"风筝", @"话筒", @"魔方", @"摇杆"]
    HSFCircleMenuConfig *config = [[HSFCircleMenuConfig alloc]init];
    config.icons = @[@"风车", @"风筝", @"话筒", @"魔方", @"摇杆"];
    config.animation = HSFCircleAnimation_circleOpen;
    self.circleView = [HSFCircleMenu menuWithConfig:config];

    //弹框
    self.alertC = [TYAlertController alertControllerWithAlertView:self.circleView];
    self.alertC.backgoundTapDismissEnable = YES;
    
    //点击item
    __block typeof(self) weakSelf = self;
    self.circleView.HSFCircleMenuClickItemBlock = ^(NSInteger tag) {
        [weakSelf.alertC dismissViewControllerAnimated:YES completion:nil];
    };
    
}

- (IBAction)show:(id)sender {
    [self.circleView startAnimaiton];
    [self presentViewController:self.alertC animated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
