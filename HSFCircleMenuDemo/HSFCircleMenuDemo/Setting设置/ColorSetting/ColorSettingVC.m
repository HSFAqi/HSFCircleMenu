//
//  ColorSettingVC.m
//  HSFCircleMenuDemo
//
//  Created by 黄山锋 on 2018/7/6.
//  Copyright © 2018年 黄山锋. All rights reserved.
//

#import "ColorSettingVC.h"

#import "WSColorImageView.h"

@interface ColorSettingVC ()

@property (weak, nonatomic) IBOutlet UIView *selectColorView;
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;

@end

@implementation ColorSettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = self.titleStr;
    WSColorImageView *ws = [[WSColorImageView alloc]initWithFrame:CGRectMake(0.f, 0.f, self.view.frame.size.width-100, self.view.frame.size.width-100)];
    [self.selectColorView addSubview:ws];
    
    __block typeof(self) weakSelf = self;
    ws.currentColorBlock = ^(UIColor *color){
        weakSelf.saveBtn.backgroundColor = color;
    };
}
//点击保存
- (IBAction)saveACTION:(UIButton *)sender {
    if (self.curSelectColorBlock) {
        self.curSelectColorBlock(sender.backgroundColor);
    }
    [self.navigationController popViewControllerAnimated:YES];
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
