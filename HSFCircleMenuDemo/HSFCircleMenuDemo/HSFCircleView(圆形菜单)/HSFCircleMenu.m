//
//  HSFCircleMenu.m
//  testDemo
//
//  Created by 黄山锋 on 2018/6/29.
//  Copyright © 2018年 黄山锋. All rights reserved.
//

#import "HSFCircleMenu.h"

//item
#import "HSFCircleMenuItem.h"
//tool
#import "HSFTool.h"
//config
#import "HSFCircleMenuConfig.h"


@interface HSFCircleMenu ()

//辅助
@property (nonatomic,strong) CALayer *maskLayer;
@property (nonatomic,strong) NSMutableArray *openLayerArr;//HSFCircleAnimation_circleOpen时才会用到
@property (nonatomic,strong) NSMutableArray *items;

@end

@implementation HSFCircleMenu


#pragma mark 初始化方法
+(instancetype)menuWithConfig:(HSFCircleMenuConfig *)config{
    HSFCircleMenu *menu = [[HSFCircleMenu alloc]init];
    menu.config = config;
    //设置self的frame和center
    menu.backgroundColor = [UIColor clearColor];
    menu.hidden = YES;
    menu.frame = CGRectMake(0, 0, config.radius * 2, config.radius * 2);
    menu.center = CGPointMake(config.radius, config.radius);
  
    //setUp
    [menu setUp];
    
    return menu;
}
/**
 指定初始化方法
 */
-(instancetype)initWithCenter:(CGPoint)center
                        icons:(NSArray *)icons
                       radius:(CGFloat)radius
                       titles:(NSArray *)titles
                      bgColor:(UIColor *)bgColor
                        itemW:(CGFloat)itemW
                        space:(CGFloat)space
                  repeatCount:(NSInteger)repeatCount
                       during:(CGFloat)during
                    direction:(HSFCircleDirection)direction
                    animation:(HSFCircleAnimation)animation{
    if (self = [super init]) {
        //设置self的frame和center
        self.backgroundColor = [UIColor clearColor];
        self.hidden = YES;
        self.frame = CGRectMake(0, 0, radius * 2, radius * 2);
        self.center = center;
        
        //赋值
        self.config.radius = radius;
        self.config.bgColor = bgColor;
        self.config.repeatCount = repeatCount;
        self.config.during = during;
        self.config.titles = titles;
        self.config.icons = icons;
        self.config.space = space;
        self.config.itemW = itemW;
        self.config.direction = direction;
        self.config.animation = animation;
        
        //遮罩
        [self setUp];
    }
    return self;
}

#pragma mark 不推荐初始化方法：初始化后在对所有属性逐一赋值，最后setUp
-(void)setUp{
    //仅用于HSFCircleAnimation_circleOpen
    if (self.config.animation == HSFCircleAnimation_circleOpen) {
        if (self.openLayerArr.count > 0) {
            [self.openLayerArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [obj removeFromSuperlayer];
            }];
        }
        
        NSInteger count = self.config.icons.count;
        CGFloat perAngle = (M_PI * 2)/count;
        CGFloat startAngel = -perAngle/2.f;
        NSMutableArray *layerArr = [NSMutableArray array];
        for (int i = 0; i < count; i++) {
            UIBezierPath *path_layer;
            if (self.config.direction == HSFCircleDirection_clockwise) {//顺时针
                path_layer = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.config.radius, self.config.radius) radius:self.config.radius/2.f startAngle:perAngle*i+startAngel endAngle:perAngle*(i+1.1)+startAngel clockwise:YES];
            }else{//逆时针
                path_layer = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.config.radius, self.config.radius) radius:self.config.radius/2.f startAngle:perAngle*i+startAngel endAngle:perAngle*(i+1.1)+startAngel clockwise:NO];
            }
            CAShapeLayer *layer = [CAShapeLayer layer];
            layer.path = path_layer.CGPath;
            layer.fillColor = [UIColor clearColor].CGColor;
            layer.strokeColor = self.config.bgColor.CGColor;
            layer.lineWidth = self.config.radius;
            [layerArr addObject:layer];
            [self.layer addSublayer:layer];
        }
        self.openLayerArr = layerArr.mutableCopy;
    }
    
    //添加item
    [self addItemBtns];
    
    //遮罩
    UIBezierPath *path;
    if (self.config.direction == HSFCircleDirection_clockwise) {//顺时针
        path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.config.radius, self.config.radius) radius:self.config.radius/2.f startAngle:-M_PI/2.f endAngle:M_PI * 3/2 clockwise:YES];
    }else{//逆时针
        path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.config.radius, self.config.radius) radius:self.config.radius/2.f startAngle:M_PI * 3/2 endAngle:-M_PI/2.f clockwise:NO];
    }
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = path.CGPath;
    maskLayer.fillColor = [UIColor clearColor].CGColor;
    maskLayer.strokeColor = self.config.bgColor.CGColor;
    maskLayer.lineWidth = self.config.radius;
    self.layer.mask = maskLayer;
    self.maskLayer = maskLayer;
}

#pragma mark 添加item
-(void)addItemBtns{
    CGFloat w = self.config.itemW;
    CGFloat h = w;
    CGFloat space = self.config.space;
    NSInteger count = self.config.icons.count;
    CGFloat perAngle = 360.f/count;
    CGFloat radius_item = self.config.radius - w/2.f;
    CGFloat angle = 0.f;
    for (int i = 0; i < count; i++) {
        HSFCircleMenuItem *item;
        if (self.config.titles.count == self.config.icons.count) {
            item = [[HSFCircleMenuItem alloc]initWithTitle:self.config.titles[i] titleColor:[UIColor whiteColor] icon:self.config.icons[i]];
        }else{
            item = [[HSFCircleMenuItem alloc]initWithTitle:@"" titleColor:[UIColor whiteColor] icon:self.config.icons[i]];
        }
        if (self.config.direction == HSFCircleDirection_clockwise) {
            angle = -perAngle*i + 90.f;
        }else{
            angle = perAngle*i + 90.f;
        }
        CGPoint center_item = [self calcCircleCoordinateWithCenter:CGPointMake(self.config.radius, self.config.radius) andWithAngle:angle andWithRadius:(radius_item-space)];
        item.frame = CGRectMake(0, 0, w, h);
        item.center = center_item;
        //圆角
        item.layer.masksToBounds = YES;
        item.layer.cornerRadius = w/2.f;
        //item背景色
        item.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
        //添加
        [self addSubview:item];
        //添加点击事件
        [item setTag:(100+i)];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapItemACTION:)];
        [item addGestureRecognizer:tap];
    }
}


#pragma mark 点击item
-(void)tapItemACTION:(UITapGestureRecognizer *)sender{
    UIView *tapView = sender.view;
    NSInteger tag = tapView.tag;
    NSLog(@"tag==%ld",tag);
    if (self.HSFCircleMenuClickItemBlock) {
        self.HSFCircleMenuClickItemBlock(tag);
    }
}


#pragma mark 更改样式-重置
-(HSFCircleMenu *)reset{
    HSFCircleMenu *menu = [HSFCircleMenu menuWithConfig:self.config];
    return menu;
}


#pragma mark 动画
-(void)startAnimaiton {
    self.backgroundColor = self.config.bgColor;
    self.hidden = NO;
    //开始执行动画
    if (self.config.animation == HSFCircleAnimation_bgCircleMove) {
        [self animationACTION_bgCircleMove];
    }
    else if (self.config.animation == HSFCircleAnimation_itemCircleMove) {
        [self animationACTION_itemCircleMove];
    }
    else if (self.config.animation == HSFCircleAnimation_followMove) {
        [self animationACTION_bgCircleMove];
        [self animationACTION_itemCircleMove];
    }
    else if (self.config.animation == HSFCircleAnimation_circleOpen) {
        [self animationACTION_circleOpen];
    }
}

#pragma mark 动画类型
-(void)animationACTION_bgCircleMove{
    CABasicAnimation *animation_normal = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation_normal.fromValue = @0;
    animation_normal.toValue = @1;
    animation_normal.duration = self.config.during;
    animation_normal.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation_normal.repeatCount = self.config.repeatCount;
    animation_normal.removedOnCompletion = NO;
    animation_normal.fillMode = kCAFillModeForwards;
    [self.maskLayer addAnimation:animation_normal forKey:@"ani"];
}
-(void)animationACTION_itemCircleMove{
    CABasicAnimation *animation_follow = [CABasicAnimation new];
    animation_follow.keyPath = @"transform.rotation.z";
    if (self.config.direction == HSFCircleDirection_clockwise) {
        animation_follow.fromValue = @(0);
        animation_follow.toValue = @(M_PI*2);
    }else{
        animation_follow.fromValue = @(0);
        animation_follow.toValue = @(-M_PI*2);
    }
    animation_follow.duration = self.config.during;
    animation_follow.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation_follow.repeatCount = self.config.repeatCount;
    animation_follow.removedOnCompletion = NO;
    animation_follow.fillMode = kCAFillModeForwards;
    [self.layer addAnimation:animation_follow forKey:@"rotation"];
}
-(void)animationACTION_circleOpen{
    self.backgroundColor = [UIColor clearColor];
    [self.openLayerArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CALayer *layer = (CALayer *)obj;
        //动画
        CABasicAnimation *animation_normal = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        animation_normal.fromValue = @0;
        animation_normal.toValue = @1;
        animation_normal.duration = self.config.during;
        animation_normal.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        animation_normal.repeatCount = self.config.repeatCount;
        animation_normal.removedOnCompletion = NO;
        animation_normal.fillMode = kCAFillModeForwards;
        [layer addAnimation:animation_normal forKey:nil];
    }];
}


//停止动画
-(void)puaseAnimation{
    self.backgroundColor = [UIColor clearColor];
    self.hidden = YES;
    [self.maskLayer removeAllAnimations];
}



#pragma mark 辅助方法
//计算圆圈上点在IOS系统中的坐标
-(CGPoint)calcCircleCoordinateWithCenter:(CGPoint) center  andWithAngle : (CGFloat) angle andWithRadius: (CGFloat) radius{
    CGFloat x2 = radius*cosf(angle*M_PI/180.f);
    CGFloat y2 = radius*sinf(angle*M_PI/180.f);
    return CGPointMake(center.x+x2, center.y-y2);
}


#pragma mark 懒加载
-(NSMutableArray *)items{
    if (!_items) {
        _items = [NSMutableArray array];
    }
    return _items;
}
-(NSMutableArray *)openLayerArr{
    if (!_openLayerArr) {
        _openLayerArr = [NSMutableArray array];
    }
    return _openLayerArr;
}



@end
