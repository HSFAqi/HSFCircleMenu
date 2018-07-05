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

@interface ViewController ()

@property (nonatomic,strong) TYAlertController *alertC;
@property (nonatomic,strong) HSFCircleMenu *circleView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.circleView = [[HSFCircleMenu alloc]initWithCenter:self.view.center icons:@[@"风车", @"风筝", @"话筒", @"魔方", @"摇杆"] radius:150.f titles:@[]];
    
    //初始化好后，如果需要更改属性，需要reset
//    self.circleView.animation = HSFCircleAnimation_followMove;//更改动画样式
//    self.circleView.space = 30.f;
//    self.circleView = [self.circleView reset];
    
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
