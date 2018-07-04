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


@interface HSFCircleMenu ()

//
@property (nonatomic,strong) CALayer *maskLayer;
@property (nonatomic,strong) NSMutableArray *items;

@end

@implementation HSFCircleMenu


#pragma mark 初始化方法
/**
 默认normal动画 + 顺时针 + during=0.5f + repeatCount=1 + space = 10.f + itemW=40.f + bgColor=orangeColor
 */
-(instancetype)initWithCenter:(CGPoint)center
                        icons:(NSArray *)icons
                       radius:(CGFloat)radius
                       titles:(NSArray *)titles{
    self = [self initWithCenter:center icons:icons radius:radius titles:titles bgColor:[UIColor orangeColor]];
    return self;
}

/**
 默认normal动画 + 顺时针 + during=0.5f + repeatCount=1 + space = 10.f + itemW=40.f
 */
-(instancetype)initWithCenter:(CGPoint)center
                        icons:(NSArray *)icons
                       radius:(CGFloat)radius
                       titles:(NSArray *)titles
                      bgColor:(UIColor *)bgColor{
    self = [self initWithCenter:center icons:icons radius:radius titles:titles bgColor:bgColor itemW:40.f];
    return self;
}

/**
 默认normal动画 + 顺时针 + during=0.5f + repeatCount=1 + space = 10.f
 */
-(instancetype)initWithCenter:(CGPoint)center
                        icons:(NSArray *)icons
                       radius:(CGFloat)radius
                       titles:(NSArray *)titles
                      bgColor:(UIColor *)bgColor
                        itemW:(CGFloat)itemW{
    self = [self initWithCenter:center icons:icons radius:radius titles:titles bgColor:bgColor itemW:itemW space:10.f];
    return self;
}

/**
 默认normal动画 + 顺时针 + during=0.5f + repeatCount=1
 */
-(instancetype)initWithCenter:(CGPoint)center
                        icons:(NSArray *)icons
                       radius:(CGFloat)radius
                       titles:(NSArray *)titles
                      bgColor:(UIColor *)bgColor
                        itemW:(CGFloat)itemW
                        space:(CGFloat)space{
    self = [self initWithCenter:center icons:icons radius:radius titles:titles bgColor:bgColor itemW:itemW space:space repeatCount:1];
    return self;
}

/**
 默认normal动画 + 顺时针 + during=0.5f
*/
-(instancetype)initWithCenter:(CGPoint)center
                        icons:(NSArray *)icons
                       radius:(CGFloat)radius
                       titles:(NSArray *)titles
                      bgColor:(UIColor *)bgColor
                        itemW:(CGFloat)itemW
                        space:(CGFloat)space
                  repeatCount:(NSInteger)repeatCount{
    self = [self initWithCenter:center icons:icons radius:radius titles:titles bgColor:bgColor itemW:itemW space:space repeatCount:repeatCount during:0.5];
    return self;
}

/**
 默认normal动画 + 顺时针
*/
-(instancetype)initWithCenter:(CGPoint)center
                        icons:(NSArray *)icons
                       radius:(CGFloat)radius
                       titles:(NSArray *)titles
                      bgColor:(UIColor *)bgColor
                        itemW:(CGFloat)itemW
                        space:(CGFloat)space
                  repeatCount:(NSInteger)repeatCount
                       during:(CGFloat)during{
    self = [self initWithCenter:center icons:icons radius:radius titles:titles bgColor:bgColor itemW:itemW space:space repeatCount:repeatCount during:during direction:HSFCircleDirection_clockwise];
    return self;
}

/**
 默认normal动画
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
                    direction:(HSFCircleDirection)direction{
    self = [self initWithCenter:center icons:icons radius:radius titles:titles bgColor:bgColor itemW:itemW space:space repeatCount:repeatCount during:during direction:direction animation:HSFCircleAnimation_normal];
    return self;
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
        _radius = radius;
        _bgColor = bgColor;
        _repeatCount = repeatCount;
        _during = during;
        _titles = titles;
        _icons = icons;
        _space = space;
        _itemW = itemW;
        _direction = direction;
        
        //遮罩
        [self setUp];
    }
    return self;
}

#pragma mark 不推荐初始化方法：初始化后在对所有属性逐一赋值，最后setUp
-(void)setUp{
    //添加item
    [self addItemBtns];
    
    //遮罩
    UIBezierPath *path;
    if (self.direction == HSFCircleDirection_clockwise) {//顺时针
        path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.radius, self.radius) radius:self.radius/2.f startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    }else{//逆时针
        path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.radius, self.radius) radius:self.radius/2.f startAngle:0 endAngle:M_PI * 2 clockwise:NO];
    }
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = path.CGPath;
    maskLayer.fillColor = [UIColor clearColor].CGColor;
    maskLayer.strokeColor = self.bgColor.CGColor;
    maskLayer.lineWidth = self.radius; //等于半径的2倍，以圆的边缘为中心，向圆内部伸展一个半径，向外伸展一个半径，所以看上去以为圆的半径是self高度的一半。
    self.layer.mask = maskLayer;
    self.maskLayer = maskLayer;
}

#pragma mark 添加item
-(void)addItemBtns{
    CGFloat w = self.itemW;
    CGFloat h = w;
    CGFloat space = self.space;
    NSInteger count = self.icons.count;
    CGFloat perAngle = 360.f/count;
    CGFloat radius_item = self.radius - w/2.f;
    CGFloat angle = 0.f;
    for (int i = 0; i < count; i++) {
        HSFCircleMenuItem *item;
        if (self.titles.count == self.icons.count) {
            item = [[HSFCircleMenuItem alloc]initWithTitle:self.titles[i] titleColor:[UIColor whiteColor] icon:self.icons[i]];
        }else{
            item = [[HSFCircleMenuItem alloc]initWithTitle:@"" titleColor:[UIColor whiteColor] icon:self.icons[i]];
        }
        if (self.direction == HSFCircleDirection_clockwise) {
            angle = -perAngle*i;
        }else{
            angle = perAngle*i;
        }
        CGPoint center_item = [self calcCircleCoordinateWithCenter:CGPointMake(self.radius, self.radius) andWithAngle:angle andWithRadius:(radius_item-space)];
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
#pragma mark 计算圆圈上点在IOS系统中的坐标
-(CGPoint)calcCircleCoordinateWithCenter:(CGPoint) center  andWithAngle : (CGFloat) angle andWithRadius: (CGFloat) radius{
    CGFloat x2 = radius*cosf(angle*M_PI/180.f);
    CGFloat y2 = radius*sinf(angle*M_PI/180.f);
    return CGPointMake(center.x+x2, center.y-y2);
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


#pragma mark 动画
-(void)startAnimaiton {
    self.backgroundColor = self.bgColor;
    self.hidden = NO;
    //开始执行扇形动画
    CABasicAnimation *animation_normal = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation_normal.fromValue = @0;
    animation_normal.toValue = @1;
    animation_normal.duration = self.during;
    animation_normal.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation_normal.repeatCount = _repeatCount;
    animation_normal.removedOnCompletion = NO;
    animation_normal.fillMode = kCAFillModeForwards;
    [_maskLayer addAnimation:animation_normal forKey:@"ani"];
    if (self.animation == HSFCircleAnimation_follow) {
        CABasicAnimation *animation_follow = [CABasicAnimation new];
        // 设置动画要改变的属性
        animation_follow.keyPath = @"transform.rotation.z";
        if (self.direction == HSFCircleDirection_clockwise) {
            animation_follow.fromValue = @(0);
            animation_follow.toValue = @(M_PI*2);
        }else{
            animation_follow.fromValue = @(0);
            animation_follow.toValue = @(-M_PI*2);
        }
        animation_follow.duration = self.during;
        animation_follow.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        animation_follow.repeatCount = _repeatCount;
        animation_follow.removedOnCompletion = NO;
        animation_follow.fillMode = kCAFillModeForwards;
        [self.layer addAnimation:animation_follow forKey:@"rotation"];
    }
}
-(void)puaseAnimation{
    self.backgroundColor = [UIColor clearColor];
    self.hidden = YES;
    [_maskLayer removeAllAnimations];
}


#pragma mark 懒加载
-(NSMutableArray *)items{
    if (!_items) {
        _items = [NSMutableArray array];
    }
    return _items;
}




@end
