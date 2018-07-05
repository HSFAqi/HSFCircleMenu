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
@property (nonatomic,strong) HSFCircleMenuConfig *config;

//btns
@property (weak, nonatomic) IBOutlet UIButton *btn100;
@property (weak, nonatomic) IBOutlet UIButton *btn101;
@property (weak, nonatomic) IBOutlet UIButton *btn102;
@property (weak, nonatomic) IBOutlet UIButton *btn103;
@property (weak, nonatomic) IBOutlet UIButton *btn104;
@property (weak, nonatomic) IBOutlet UIButton *btn105;
@property (weak, nonatomic) IBOutlet UIButton *btn106;
@property (weak, nonatomic) IBOutlet UIButton *btn107;
@property (weak, nonatomic) IBOutlet UIButton *btn108;
@property (weak, nonatomic) IBOutlet UIButton *btn109;


@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.btn100.backgroundColor = [UIColor orangeColor];
    self.btn101.backgroundColor = [UIColor orangeColor];
    self.btn102.backgroundColor = [UIColor orangeColor];
    self.btn103.backgroundColor = [UIColor orangeColor];
    self.btn104.backgroundColor = [UIColor orangeColor];
    self.btn105.backgroundColor = [UIColor orangeColor];
    self.btn106.backgroundColor = [UIColor orangeColor];
    self.btn107.backgroundColor = [UIColor orangeColor];
    self.btn108.backgroundColor = [UIColor orangeColor];
    self.btn109.backgroundColor = [UIColor orangeColor];
    
    
    //@[@"风车", @"风筝", @"话筒", @"魔方", @"摇杆"]
    self.config = [[HSFCircleMenuConfig alloc]init];
    self.config.icons = @[@"风车", @"风筝", @"话筒", @"魔方", @"摇杆", @"气球"];
    self.config.titles = @[@"风车", @"风筝", @"话筒", @"魔方", @"摇杆", @"气球"];
    self.btn100.backgroundColor = [[UIColor orangeColor] colorWithAlphaComponent:0.5];
    self.circleView = [HSFCircleMenu menuWithConfig:self.config];

    //弹框
    self.alertC = [TYAlertController alertControllerWithAlertView:self.circleView];
    self.alertC.backgoundTapDismissEnable = YES;
    
    //点击item
    __block typeof(self) weakSelf = self;
    self.circleView.HSFCircleMenuClickItemBlock = ^(NSInteger tag) {
        [weakSelf.alertC dismissViewControllerAnimated:YES completion:nil];
    };
    
}

//更换动画方式
- (IBAction)changeAnimation:(UIButton *)sender {
    
    self.btn100.backgroundColor = [UIColor orangeColor];
    self.btn101.backgroundColor = [UIColor orangeColor];
    self.btn102.backgroundColor = [UIColor orangeColor];
    self.btn103.backgroundColor = [UIColor orangeColor];
    self.btn104.backgroundColor = [UIColor orangeColor];
    self.btn105.backgroundColor = [UIColor orangeColor];
    self.btn106.backgroundColor = [UIColor orangeColor];
    self.btn107.backgroundColor = [UIColor orangeColor];
    self.btn108.backgroundColor = [UIColor orangeColor];
    self.btn109.backgroundColor = [UIColor orangeColor];
    sender.backgroundColor = [[UIColor orangeColor] colorWithAlphaComponent:0.5];
    
    self.config = [[HSFCircleMenuConfig alloc]init];
    
    switch (sender.tag) {
        case 100:
        {
            self.config.animation = HSFCircleAnimation_none;
        }
            break;
        case 101:
        {
            self.config.animation = HSFCircleAnimation_bgCircleMove;
        }
            break;
        case 102:
        {
            self.config.animation = HSFCircleAnimation_itemCircleMove;
        }
            break;
        case 103:
        {
            self.config.animation = HSFCircleAnimation_followMove;
        }
            break;
        case 104:
        {
            self.config.animation = HSFCircleAnimation_bgCircleOpen;
        }
            break;
        case 105:
        {
            self.config.animation = HSFCircleAnimation_itemShoot;
        }
            break;
        case 106:
        {
            self.config.animation = HSFCircleAnimation_itemShootBy;
        }
            break;
        case 107:
        {
            self.config.animation = HSFCircleAnimation_none;
            
        }
            break;
        case 108:
        {
            self.config.animation = HSFCircleAnimation_none;
            
        }
            break;
        case 109:
        {
            self.config.animation = HSFCircleAnimation_none;
            
        }
            break;
            
        default:
            break;
    }
    self.config.icons = @[@"风车", @"风筝"];
    self.config.titles = @[@"风车", @"风筝", @"话筒", @"魔方", @"摇杆", @"气球"];
    self.config.direction = HSFCircleDirection_anticlockwise;
    self.config.isCircleLayout = YES;
    self.circleView = [HSFCircleMenu menuWithConfig:self.config];
    [self.circleView setCenterImg:@"world" size:CGSizeMake(100.f, 100.f)];
    [self.circleView setBgImg:@"bg002"];
    
    //弹框
    self.alertC = [TYAlertController alertControllerWithAlertView:self.circleView];
    self.alertC.backgoundTapDismissEnable = YES;
    
    //点击item
    __block typeof(self) weakSelf = self;
    self.circleView.HSFCircleMenuClickItemBlock = ^(NSInteger tag) {
        [weakSelf.alertC dismissViewControllerAnimated:YES completion:nil];
    };
}


//show
- (IBAction)show:(id)sender {
    [self.circleView startAnimaiton];
    [self presentViewController:self.alertC animated:YES completion:nil];
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
