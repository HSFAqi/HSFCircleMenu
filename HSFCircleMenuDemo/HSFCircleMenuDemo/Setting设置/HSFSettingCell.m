//
//  HSFSettingCell.m
//  HSFCircleMenuDemo
//
//  Created by 黄山锋 on 2018/7/6.
//  Copyright © 2018年 黄山锋. All rights reserved.
//

#import "HSFSettingCell.h"

//config
#import "HSFCircleMenuConfig.h"
//tool
#import "HSFTool.h"

@interface HSFSettingCell ()<UITextFieldDelegate>

@property (nonatomic,strong) NSArray *icons_origin;
@property (nonatomic,strong) NSArray *titles_origin;

@property (nonatomic,strong) NSMutableArray *icons;
@property (nonatomic,strong) NSMutableArray *titles;

//icons
@property (weak, nonatomic) IBOutlet UIImageView *icon01;
@property (weak, nonatomic) IBOutlet UIImageView *icon02;
@property (weak, nonatomic) IBOutlet UIImageView *icon03;
@property (weak, nonatomic) IBOutlet UIImageView *icon04;
@property (weak, nonatomic) IBOutlet UIImageView *icon05;
@property (weak, nonatomic) IBOutlet UIImageView *icon06;
@property (weak, nonatomic) IBOutlet UIImageView *icon07;
@property (weak, nonatomic) IBOutlet UIImageView *icon08;

//icons的角标
@property (nonatomic,strong) NSArray *corner0Arr;
@property (weak, nonatomic) IBOutlet UIImageView *corner01;
@property (weak, nonatomic) IBOutlet UIImageView *corner02;
@property (weak, nonatomic) IBOutlet UIImageView *corner03;
@property (weak, nonatomic) IBOutlet UIImageView *corner04;
@property (weak, nonatomic) IBOutlet UIImageView *corner05;
@property (weak, nonatomic) IBOutlet UIImageView *corner06;
@property (weak, nonatomic) IBOutlet UIImageView *corner07;
@property (weak, nonatomic) IBOutlet UIImageView *corner08;

//titles的角标
@property (nonatomic,strong) NSArray *corner1Arr;
@property (weak, nonatomic) IBOutlet UIImageView *corner11;
@property (weak, nonatomic) IBOutlet UIImageView *corner12;
@property (weak, nonatomic) IBOutlet UIImageView *corner13;
@property (weak, nonatomic) IBOutlet UIImageView *corner14;
@property (weak, nonatomic) IBOutlet UIImageView *corner15;
@property (weak, nonatomic) IBOutlet UIImageView *corner16;
@property (weak, nonatomic) IBOutlet UIImageView *corner17;
@property (weak, nonatomic) IBOutlet UIImageView *corner18;

@property (weak, nonatomic) IBOutlet UITextField *fontSizeTF;
@property (weak, nonatomic) IBOutlet UISlider *slider_radius;
@property (weak, nonatomic) IBOutlet UISlider *slider_space;
@property (weak, nonatomic) IBOutlet UISlider *slider_itemW;
@property (weak, nonatomic) IBOutlet UISwitch *layoutSW;



@end

@implementation HSFSettingCell

//赋值
-(void)setConfig:(HSFCircleMenuConfig *)config{
    _config = config;
    //初始化状态
    self.icons = config.icons.mutableCopy;
    self.titles = config.titles.mutableCopy;
    self.titleColorView.backgroundColor = config.titleColor;
    self.bgColorView.backgroundColor = config.bgColor;
    self.itemBgColorView.backgroundColor = config.itemBgColor;
    if (config.fontSize == 10.f) {
        
    }else{
        self.fontSizeTF.text = [NSString stringWithFormat:@"%.0f",config.fontSize];
    }
    self.slider_radius.value = config.radius;
    self.slider_space.value = config.space;
    self.slider_itemW.value = config.itemW;
    [self.layoutSW setOn:config.isCircleLayout];
    if (config.bgImg) {
        self.bgImgView.image = config.bgImg;
    }else{
        self.bgImgView.image = [UIImage imageNamed:@"添加图片"];
    }
    if (config.centerImg) {
        self.centerImgView.image = config.centerImg;
    }else{
        self.centerImgView.image = [UIImage imageNamed:@"添加图片"];
    }
}

-(void)setIcons:(NSMutableArray *)icons{
    _icons = icons;
    __block typeof(self) weakSelf = self;
    [icons enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIImageView *corner = weakSelf.corner0Arr[idx];
        if (kStringIsEmpty(obj)) {
            corner.hidden = YES;
        }else{
            corner.hidden = NO;
        }
    }];
}

-(void)setTitles:(NSMutableArray *)titles{
    _titles = titles;
    __block typeof(self) weakSelf = self;
    [titles enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIImageView *corner = weakSelf.corner1Arr[idx];
        if (kStringIsEmpty(obj)) {
            corner.hidden = YES;
        }else{
            corner.hidden = NO;
        }
    }];
}



- (void)awakeFromNib {
    [super awakeFromNib];
    
    //标准数组
    self.icons_origin = @[@"耳机", @"手柄", @"摇杆", @"风车", @"风筝", @"话筒", @"魔方", @"气球"];
    self.titles_origin = @[@"耳机", @"手柄", @"摇杆", @"风车", @"风筝", @"话筒", @"魔方", @"气球"];
    
    //角标
    self.corner0Arr = @[self.corner01, self.corner02, self.corner03, self.corner04, self.corner05, self.corner06, self.corner07, self.corner08];
    self.corner1Arr = @[self.corner11, self.corner12, self.corner13, self.corner14, self.corner15, self.corner16, self.corner17, self.corner18];
    
    //点击icon
    self.icon01.userInteractionEnabled = YES;
    self.icon02.userInteractionEnabled = YES;
    self.icon03.userInteractionEnabled = YES;
    self.icon04.userInteractionEnabled = YES;
    self.icon05.userInteractionEnabled = YES;
    self.icon06.userInteractionEnabled = YES;
    self.icon07.userInteractionEnabled = YES;
    self.icon08.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapIconACTION:)];
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapIconACTION:)];
    UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapIconACTION:)];
    UITapGestureRecognizer *tap4 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapIconACTION:)];
    UITapGestureRecognizer *tap5 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapIconACTION:)];
    UITapGestureRecognizer *tap6 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapIconACTION:)];
    UITapGestureRecognizer *tap7 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapIconACTION:)];
    UITapGestureRecognizer *tap8 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapIconACTION:)];
    
    [self.icon01 addGestureRecognizer:tap1];
    [self.icon02 addGestureRecognizer:tap2];
    [self.icon03 addGestureRecognizer:tap3];
    [self.icon04 addGestureRecognizer:tap4];
    [self.icon05 addGestureRecognizer:tap5];
    [self.icon06 addGestureRecognizer:tap6];
    [self.icon07 addGestureRecognizer:tap7];
    [self.icon08 addGestureRecognizer:tap8];
    
    self.fontSizeTF.delegate = self;
    
    
    
}
#pragma mark 点击图标
- (void)tapIconACTION:(UITapGestureRecognizer *)sender {
    UIImageView *view = (UIImageView *)sender.view;
    NSInteger index = view.tag-1;
    NSString *iconName = self.icons[index];
    UIImageView *corner = self.corner0Arr[index];
    if (kStringIsEmpty(iconName)) {
        [self.icons replaceObjectAtIndex:index withObject:self.icons_origin[index]];
        corner.hidden = NO;
    }else{
        [self.icons replaceObjectAtIndex:index withObject:@""];
        corner.hidden = YES;
    }
    self.config.icons = self.icons;
}

#pragma mark 点击标题
- (IBAction)clickTitleACTION:(UIButton *)sender {
    NSInteger index = sender.tag-1;
    NSString *iconName = self.titles[index];
    UIImageView *corner = self.corner1Arr[index];
    if (kStringIsEmpty(iconName)) {
        [self.titles replaceObjectAtIndex:index withObject:self.titles_origin[index]];
        corner.hidden = NO;
    }else{
        [self.titles replaceObjectAtIndex:index withObject:@""];
        corner.hidden = YES;
    }
    self.config.titles = self.titles;
}

#pragma mark UITextFieldDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField == self.fontSizeTF) {
        if (kStringIsEmpty(textField.text)) {
            self.config.fontSize = 10.f;
        }else{
            self.config.fontSize = textField.text.floatValue;
        }
    }
}

#pragma mark 设置半径
- (IBAction)settingRadiusACTION:(UISlider *)sender {
    self.config.radius = sender.value;
}

#pragma mark 设置space
- (IBAction)settingSpaceACTION:(UISlider *)sender {
    self.config.space = sender.value;
}

#pragma mark 设置itemW
- (IBAction)settingItemWACTION:(UISlider *)sender {
    self.config.itemW = sender.value;
}

#pragma mark 设置布局方式
- (IBAction)settingLayoutACTION:(UISwitch *)sender {
    self.config.isCircleLayout = sender.isOn;
}





- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
