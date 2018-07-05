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




//辅助
@property (nonatomic,strong) CALayer *maskLayer;
@property (nonatomic,strong) NSMutableArray *openLayerArr;//HSFCircleAnimation_circleOpen时才会用到
@property (nonatomic,strong) NSMutableArray *items;

@end

@implementation HSFCircleMenu


#pragma mark 初始化方法
/**
 默认none动画 + 顺时针 + during=0.5f + repeatCount=1 + space = 10.f + itemW=40.f + bgColor=orangeColor
 */
-(instancetype)initWithCenter:(CGPoint)center
                        icons:(NSArray *)icons
                       radius:(CGFloat)radius
                       titles:(NSArray *)titles{
    self = [self initWithCenter:center icons:icons radius:radius titles:titles bgColor:[UIColor orangeColor]];
    return self;
}

/**
 默认none动画 + 顺时针 + during=0.5f + repeatCount=1 + space = 10.f + itemW=40.f
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
 默认none动画 + 顺时针 + during=0.5f + repeatCount=1 + space = 10.f
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
 默认none动画 + 顺时针 + during=0.5f + repeatCount=1
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
 默认none动画 + 顺时针 + during=0.5f
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
 默认none动画 + 顺时针
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
 默认none动画
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
    self = [self initWithCenter:center icons:icons radius:radius titles:titles bgColor:bgColor itemW:itemW space:space repeatCount:repeatCount during:during direction:direction animation:HSFCircleAnimation_none];
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
        self.radius = radius;
        self.bgColor = bgColor;
        self.repeatCount = repeatCount;
        self.during = during;
        self.titles = titles;
        self.icons = icons;
        self.space = space;
        self.itemW = itemW;
        self.direction = direction;
        self.animation = animation;
        
        //遮罩
        [self setUp];
    }
    return self;
}

#pragma mark 不推荐初始化方法：初始化后在对所有属性逐一赋值，最后setUp
-(void)setUp{
    //仅用于HSFCircleAnimation_circleOpen
    if (self.animation == HSFCircleAnimation_circleOpen) {
        if (self.openLayerArr.count > 0) {
            [self.openLayerArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [obj removeFromSuperlayer];
            }];
        }
        
        NSInteger count = self.icons.count;
        CGFloat perAngle = (M_PI * 2)/count;
        NSMutableArray *layerArr = [NSMutableArray array];
        for (int i = 0; i < count; i++) {
            UIBezierPath *path_layer;
            if (self.direction == HSFCircleDirection_clockwise) {//顺时针
                path_layer = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.radius, self.radius) radius:self.radius/2.f startAngle:perAngle*i endAngle:perAngle*(i+1.1) clockwise:YES];
            }else{//逆时针
                path_layer = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.radius, self.radius) radius:self.radius/2.f startAngle:perAngle*i endAngle:perAngle*(i+1.1) clockwise:NO];
            }
            CAShapeLayer *layer = [CAShapeLayer layer];
            layer.path = path_layer.CGPath;
            layer.fillColor = [UIColor clearColor].CGColor;
            layer.strokeColor = self.bgColor.CGColor;
            layer.lineWidth = self.radius;
            [layerArr addObject:layer];
            [self.layer addSublayer:layer];
        }
        self.openLayerArr = layerArr.mutableCopy;
    }
    
    //添加item
    [self addItemBtns];
    
    //遮罩
    UIBezierPath *path;
    if (self.direction == HSFCircleDirection_clockwise) {//顺时针
        path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.radius, self.radius) radius:self.radius/2.f startAngle:-M_PI/2.f endAngle:M_PI * 3/2 clockwise:YES];
    }else{//逆时针
        path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.radius, self.radius) radius:self.radius/2.f startAngle:M_PI * 3/2 endAngle:-M_PI/2.f clockwise:NO];
    }
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = path.CGPath;
    maskLayer.fillColor = [UIColor clearColor].CGColor;
    maskLayer.strokeColor = self.bgColor.CGColor;
    maskLayer.lineWidth = self.radius;
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
            angle = -perAngle*i + 90.f;
        }else{
            angle = perAngle*i + 90.f;
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
    
    //必须
    NSArray *icons = self.icons;//图标数组
    CGFloat radius = self.radius;//圆半径
    
    //可选
    NSArray *titles = self.titles;//标题数组 （默认：@[]）
    UIColor *bgColor = self.bgColor;//背景色 （默认：[UIColor orangeColor]）
    CGFloat space = self.space;//item距离圆周边的距离 （默认：10.f）
    CGFloat itemW = self.itemW;//item宽度 宽=高 （默认：40.f）
    HSFCircleDirection direction = self.direction;//动画方向 （默认：顺时针）
    NSInteger repeatCount = self.repeatCount;//动画次数 （默认：1）
    CGFloat during = self.during;//动画时间 （默认：0.5f）
    HSFCircleAnimation animation = self.animation;//动画方式 （默认：无）
    
    
    HSFCircleMenu *menu = [[HSFCircleMenu alloc]initWithCenter:CGPointMake(radius, radius) icons:icons radius:radius titles:titles bgColor:bgColor itemW:itemW space:space repeatCount:repeatCount during:during direction:direction animation:animation];
    return menu;
}


#pragma mark 动画
-(void)startAnimaiton {
    self.backgroundColor = self.bgColor;
    self.hidden = NO;
    //开始执行动画
    if (self.animation == HSFCircleAnimation_bgCircleMove) {
        [self animationACTION_bgCircleMove];
    }
    else if (self.animation == HSFCircleAnimation_itemCircleMove) {
        [self animationACTION_itemCircleMove];
    }
    else if (self.animation == HSFCircleAnimation_followMove) {
        [self animationACTION_bgCircleMove];
        [self animationACTION_itemCircleMove];
    }
    else if (self.animation == HSFCircleAnimation_circleOpen) {
        [self animationACTION_circleOpen];
    }
}

#pragma mark 动画类型
-(void)animationACTION_bgCircleMove{
    CABasicAnimation *animation_normal = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation_normal.fromValue = @0;
    animation_normal.toValue = @1;
    animation_normal.duration = self.during;
    animation_normal.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation_normal.repeatCount = self.repeatCount;
    animation_normal.removedOnCompletion = NO;
    animation_normal.fillMode = kCAFillModeForwards;
    [self.maskLayer addAnimation:animation_normal forKey:@"ani"];
}
-(void)animationACTION_itemCircleMove{
    CABasicAnimation *animation_follow = [CABasicAnimation new];
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
    animation_follow.repeatCount = self.repeatCount;
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
        animation_normal.duration = self.during;
        animation_normal.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        animation_normal.repeatCount = self.repeatCount;
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
