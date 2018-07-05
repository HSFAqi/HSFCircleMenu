//
//  HSFCircleMenuItem.m
//  HSFKitDemo
//
//  Created by 黄山锋 on 2018/7/3.
//  Copyright © 2018年 黄山锋. All rights reserved.
//

#import "HSFCircleMenuItem.h"

//tool
#import "HSFTool.h"

@interface HSFCircleMenuItem ()

@property (nonatomic,strong) UIImageView *iconView;
@property (nonatomic,strong) UILabel *titleLabel;

@end

@implementation HSFCircleMenuItem

//初始化方法
-(instancetype)initWithTitle:(NSString *)title titleColor:(UIColor *)titleColor fontSize:(CGFloat)fontSize icon:(NSString *)icon{
    if (self = [super init]) {
        self.title = title;
        self.titleColor = titleColor;
        self.fontSize = fontSize;
        self.icon = icon;
        if (!kStringIsEmpty(self.title)) {
            self.titleLabel.text = title;
            self.titleLabel.textColor = titleColor;
            self.titleLabel.font = [UIFont systemFontOfSize:fontSize];
            [self addSubview:self.titleLabel];
        }
        if (!kStringIsEmpty(self.icon)) {
            self.iconView.image = [UIImage imageNamed:icon];
            [self addSubview:self.iconView];
        }
        
        self.userInteractionEnabled = YES;
    }
    return self;
}


#pragma mark 添加约束
-(void)layoutSubviews{
    __block typeof(self) weakSelf = self;
    
    if ((!kStringIsEmpty(self.title)) && (!kStringIsEmpty(self.icon))) {
        [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(weakSelf);
        }];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.iconView.mas_bottom);
            make.height.mas_equalTo(20.f);
            make.left.right.bottom.equalTo(weakSelf);
        }];
    }
    else if ((kStringIsEmpty(self.title)) && (!kStringIsEmpty(self.icon))){
        [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.bottom.equalTo(weakSelf);
        }];
    }
    else if ((!kStringIsEmpty(self.title)) && (kStringIsEmpty(self.icon))){
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.bottom.equalTo(weakSelf);
        }];
    }
    //最后
    [super layoutSubviews];
}





#pragma mark 懒加载
-(UIImageView *)iconView{
    if (!_iconView) {
        _iconView = [[UIImageView alloc]init];
        _iconView.frame = CGRectZero;
        _iconView.contentMode = UIViewContentModeScaleAspectFit;
        _iconView.userInteractionEnabled = YES;
    }
    return _iconView;
}
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.frame = CGRectZero;
        _titleLabel.font = [UIFont systemFontOfSize:10];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

@end
