//
//  NewVersionVC.m
//  HSFCircleMenuDemo
//
//  Created by 黄山锋 on 2018/7/6.
//  Copyright © 2018年 黄山锋. All rights reserved.
//

#import "NewVersionVC.h"

#import "HSFTool.h"
#import "HSFCircleMenu.h"
#import "HSFCircleMenuConfig.h"
#import "HSFSettingVC.h"

@interface NewVersionVC ()<HSFSettingVCDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIButton *bgBtn001;
@property (weak, nonatomic) IBOutlet UIButton *bgBtn002;
@property (weak, nonatomic) IBOutlet UIButton *bgBtn003;
@property (weak, nonatomic) IBOutlet UIButton *bgBtn004;
@property (weak, nonatomic) IBOutlet UIButton *bgBtn005;
@property (weak, nonatomic) IBOutlet UIButton *bgBtn006;
@property (weak, nonatomic) IBOutlet UIButton *bgBtn007;
@property (weak, nonatomic) IBOutlet UIButton *bgBtn008;
@property (weak, nonatomic) IBOutlet UIButton *bgBtn009;

@property (weak, nonatomic) IBOutlet UIButton *itemBtn001;
@property (weak, nonatomic) IBOutlet UIButton *itemBtn002;
@property (weak, nonatomic) IBOutlet UIButton *itemBtn003;
@property (weak, nonatomic) IBOutlet UIButton *itemBtn004;
@property (weak, nonatomic) IBOutlet UIButton *itemBtn005;
@property (weak, nonatomic) IBOutlet UIButton *itemBtn006;
@property (weak, nonatomic) IBOutlet UIButton *itemBtn007;
@property (weak, nonatomic) IBOutlet UIButton *itemBtn008;
@property (weak, nonatomic) IBOutlet UIButton *itemBtn009;



@property (nonatomic,strong) TYAlertController *alertC;
@property (nonatomic,strong) HSFCircleMenu *circleView;
@property (nonatomic,strong) HSFCircleMenuConfig *config;

@property (weak, nonatomic) IBOutlet UITextField *duringTF;
@property (weak, nonatomic) IBOutlet UITextField *repeatCountTF;


@end

@implementation NewVersionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"新版动画方式";
    self.duringTF.delegate = self;
    self.repeatCountTF.delegate = self;
    
    //默认
    
    self.bgBtn001.backgroundColor = [kRGBColor(255, 172, 47) colorWithAlphaComponent:0.5];
    self.bgBtn002.backgroundColor = kRGBColor(255, 172, 47);
    self.bgBtn003.backgroundColor = kRGBColor(255, 172, 47);
    self.bgBtn004.backgroundColor = kRGBColor(255, 172, 47);
    self.bgBtn005.backgroundColor = kRGBColor(255, 172, 47);
    self.bgBtn006.backgroundColor = kRGBColor(255, 172, 47);
    self.bgBtn007.backgroundColor = kRGBColor(255, 172, 47);
    self.bgBtn008.backgroundColor = kRGBColor(255, 172, 47);
    self.bgBtn009.backgroundColor = kRGBColor(255, 172, 47);
    
    
    self.itemBtn001.backgroundColor = [kRGBColor(77, 147, 225) colorWithAlphaComponent:0.5];
    self.itemBtn002.backgroundColor = kRGBColor(77, 147, 225);
    self.itemBtn003.backgroundColor = kRGBColor(77, 147, 225);
    self.itemBtn004.backgroundColor = kRGBColor(77, 147, 225);
    self.itemBtn005.backgroundColor = kRGBColor(77, 147, 225);
    self.itemBtn006.backgroundColor = kRGBColor(77, 147, 225);
    self.itemBtn007.backgroundColor = kRGBColor(77, 147, 225);
    self.itemBtn008.backgroundColor = kRGBColor(77, 147, 225);
    self.itemBtn009.backgroundColor = kRGBColor(77, 147, 225);
    
    self.config = [[HSFCircleMenuConfig alloc]init];
    self.config.icons = @[@"耳机", @"手柄", @"摇杆", @"风车", @"风筝", @"话筒", @"魔方", @"气球"];
    self.config.titles = @[@"耳机", @"手柄", @"摇杆", @"风车", @"风筝", @"话筒", @"魔方", @"气球"];
    self.config.bgImg = [UIImage imageNamed:@"bg002"];
    self.config.centerImg = [UIImage imageNamed:@"world"];
    self.config.centerImgSize = CGSizeMake(100.f, 100.f);
    self.config.useNewAnimationWay = YES;
    self.config.animation_item = HSFCircleItemAnimation_none;
    self.config.animation_bg = HSFCircleBgAnimation_none;
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




#pragma mark 点击bgBtn
- (IBAction)bgBtnACTION:(UIButton *)sender {
    self.bgBtn001.backgroundColor = kRGBColor(255, 172, 47);
    self.bgBtn002.backgroundColor = kRGBColor(255, 172, 47);
    self.bgBtn003.backgroundColor = kRGBColor(255, 172, 47);
    self.bgBtn004.backgroundColor = kRGBColor(255, 172, 47);
    self.bgBtn005.backgroundColor = kRGBColor(255, 172, 47);
    self.bgBtn006.backgroundColor = kRGBColor(255, 172, 47);
    self.bgBtn007.backgroundColor = kRGBColor(255, 172, 47);
    self.bgBtn008.backgroundColor = kRGBColor(255, 172, 47);
    self.bgBtn009.backgroundColor = kRGBColor(255, 172, 47);
    
    sender.backgroundColor = [kRGBColor(255, 172, 47) colorWithAlphaComponent:0.5];
    
    switch (sender.tag) {
        case 1:
        {
            self.config.animation_bg = HSFCircleBgAnimation_none;
        }
            break;
        case 2:
        {
            self.config.animation_bg = HSFCircleBgAnimation_bgCircleMove;
        }
            break;
        case 3:
        {
            self.config.animation_bg = HSFCircleBgAnimation_bgCircleOpen;
        }
            break;
        case 4:
        {
            self.config.animation_bg = HSFCircleBgAnimation_none;
        }
            break;
        case 5:
        {
            self.config.animation_bg = HSFCircleBgAnimation_none;
        }
            break;
        case 6:
        {
            self.config.animation_bg = HSFCircleBgAnimation_none;
        }
            break;
        case 7:
        {
            self.config.animation_bg = HSFCircleBgAnimation_none;
        }
            break;
        case 8:
        {
            self.config.animation_bg = HSFCircleBgAnimation_none;
        }
            break;
        case 9:
        {
            self.config.animation_bg = HSFCircleBgAnimation_none;
        }
            break;
            
        default:
            break;
    }
    [self createCircleMenuAlert];
}


#pragma mark 点击itemBtn
- (IBAction)itemBtnACTION:(UIButton *)sender {
    self.itemBtn001.backgroundColor = kRGBColor(77, 147, 225);
    self.itemBtn002.backgroundColor = kRGBColor(77, 147, 225);
    self.itemBtn003.backgroundColor = kRGBColor(77, 147, 225);
    self.itemBtn004.backgroundColor = kRGBColor(77, 147, 225);
    self.itemBtn005.backgroundColor = kRGBColor(77, 147, 225);
    self.itemBtn006.backgroundColor = kRGBColor(77, 147, 225);
    self.itemBtn007.backgroundColor = kRGBColor(77, 147, 225);
    self.itemBtn008.backgroundColor = kRGBColor(77, 147, 225);
    self.itemBtn009.backgroundColor = kRGBColor(77, 147, 225);
    
    sender.backgroundColor = [kRGBColor(77, 147, 225) colorWithAlphaComponent:0.5];
    
    switch (sender.tag) {
        case 1:
        {
            self.config.animation_item = HSFCircleItemAnimation_none;
        }
            break;
        case 2:
        {
            self.config.animation_item = HSFCircleItemAnimation_itemCircleMove;
        }
            break;
        case 3:
        {
            self.config.animation_item = HSFCircleItemAnimation_itemShoot;
        }
            break;
        case 4:
        {
            self.config.animation_item = HSFCircleItemAnimation_itemShootBy;
        }
            break;
        case 5:
        {
            self.config.animation_item = HSFCircleItemAnimation_none;
        }
            break;
        case 6:
        {
            self.config.animation_item = HSFCircleItemAnimation_none;
        }
            break;
        case 7:
        {
            self.config.animation_item = HSFCircleItemAnimation_none;
        }
            break;
        case 8:
        {
            self.config.animation_item = HSFCircleItemAnimation_none;
        }
            break;
        case 9:
        {
            self.config.animation_item = HSFCircleItemAnimation_none;
        }
            break;
            
        default:
            break;
    }
    [self createCircleMenuAlert];
}

#pragma mark 动画方向
- (IBAction)changeAnimationDirectionACTION:(UISegmentedControl *)sender {
    if (sender.selectedSegmentIndex == 0) {
        self.config.direction = HSFCircleDirection_clockwise;
    }else{
        self.config.direction = HSFCircleDirection_anticlockwise;
    }
    [self createCircleMenuAlert];
}

#pragma mark UITextFieldDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField == self.duringTF) {
        if (kStringIsEmpty(textField.text)) {
            self.config.during = 0.5f;
        }else{
            self.config.during = textField.text.floatValue;
        }
    }else{
        if (kStringIsEmpty(textField.text)) {
            self.config.repeatCount = 1;
        }else{
            self.config.repeatCount = textField.text.integerValue;
        }
    }
    [self createCircleMenuAlert];
}

#pragma mark 点击更多设置
- (IBAction)moreSettingACTION:(UIButton *)sender {
    HSFSettingVC *vc = [[HSFSettingVC alloc]init];
    vc.delegate = self;
    vc.config = self.config;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark HSFSettingVCDelegate
-(void)saveSettingWithConfig:(HSFCircleMenuConfig *)config{
    self.config = config;
    [self createCircleMenuAlert];
}

#pragma mark 点击show
- (IBAction)show:(id)sender {
    [self.circleView startAnimaiton];
    [self presentViewController:self.alertC animated:YES completion:nil];
}


#pragma mark 弹框
-(void)createCircleMenuAlert{
    //创建菜单
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
