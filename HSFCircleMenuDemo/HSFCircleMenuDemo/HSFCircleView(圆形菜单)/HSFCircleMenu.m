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
//animation
#import "HSFAnimationHelper.h"


@interface HSFCircleMenu ()<CAAnimationDelegate>

//辅助
@property (nonatomic,strong) CALayer *maskLayer;
@property (nonatomic,strong) NSMutableArray *openLayerArr;//HSFCircleAnimation_bgCircleOpen时才会用到
@property (nonatomic,strong) NSMutableArray *items;
@property (nonatomic,strong) NSMutableArray *itemCenterPointArr;
@property (nonatomic,strong) UIImageView *bgImgView;
@property (nonatomic,strong) UIImageView *centerImgView;

//动画
@property (nonatomic,strong) HSFAnimationHelper *animationHelper;

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

#pragma mark 不推荐初始化方法：初始化后在对所有属性逐一赋值，最后setUp
-(void)setUp{
    //初始化动画helper
    self.animationHelper = [[HSFAnimationHelper alloc]init];
    self.animationHelper.config = self.config;
    //添加背景图片
    self.bgImgView = [[UIImageView alloc]initWithFrame:self.bounds];
    if (self.config.bgImg) {
        self.bgImgView.image = self.config.bgImg;
    }
    self.bgImgView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:self.bgImgView];
    
    //仅用于bgCircleOpen动画时
    if (self.config.useNewAnimationWay && self.config.animation_bg == HSFCircleBgAnimation_bgCircleOpen) {
        [self addBgCircleOpenLayers];
    }else{
        if (self.config.animation == HSFCircleAnimation_bgCircleOpen) {
            [self addBgCircleOpenLayers];
        }
    }
        
    //添加item
    [self addItemBtns];
    
    //添加中心图片
    self.centerImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.config.centerImgSize.width, self.config.centerImgSize.height)];
    self.centerImgView.center = self.center;
    self.centerImgView.contentMode = UIViewContentModeScaleAspectFit;
    if (self.config.centerImg) {
        self.centerImgView.image = self.config.centerImg;
    }
    [self addSubview:self.centerImgView];
    
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
#pragma mark 背景圆形动画时添加layer
-(void)addBgCircleOpenLayers{
    if (self.openLayerArr.count > 0) {
        [self.openLayerArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj removeFromSuperlayer];
        }];
    }
    
    NSInteger count = [self getSafeCountOfAllItems];
    CGFloat perAngle = (M_PI * 2)/count;
    CGFloat startAngel = -perAngle/2.f;
    NSMutableArray *layerArr = [NSMutableArray array];
    for (int i = 0; i < count; i++) {
        UIBezierPath *path_layer;
        if (self.config.direction == HSFCircleDirection_clockwise) {//顺时针
            if (!self.config.bgImg) {
                path_layer = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.config.radius, self.config.radius) radius:self.config.radius/2.f startAngle:perAngle*i+startAngel endAngle:perAngle*(i+1.1)+startAngel clockwise:NO];
            }else{
                path_layer = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.config.radius, self.config.radius) radius:self.config.radius/2.f startAngle:perAngle*i+startAngel endAngle:perAngle*(i+1.1)+startAngel clockwise:YES];
            }
        }else{//逆时针
            if (!self.config.bgImg) {
                path_layer = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.config.radius, self.config.radius) radius:self.config.radius/2.f startAngle:perAngle*i+startAngel endAngle:perAngle*(i+1.1)+startAngel clockwise:YES];
            }else{
                path_layer = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.config.radius, self.config.radius) radius:self.config.radius/2.f startAngle:perAngle*i+startAngel endAngle:perAngle*(i+1.1)+startAngel clockwise:NO];
            }
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

#pragma mark 添加item
-(void)addItemBtns{
    CGFloat w = self.config.itemW;
    CGFloat h = w;
    CGFloat space = self.config.space;
    NSInteger count = [self getSafeCountOfAllItems];
    CGFloat perAngle = 360.f/count;
    CGFloat radius_item = self.config.radius - w/2.f;
    CGFloat angle = 0.f;
    self.itemCenterPointArr = nil;
    for (int i = 0; i < count; i++) {
        HSFCircleMenuItem *item;
        NSString *title = @"";
        NSString *icon = @"";
        if (i >= self.config.titles.count) {
            title = @"";
        }else{
            title = self.config.titles[i];
        }
        if (i >= self.config.icons.count) {
            icon = @"";
        }else{
            icon = self.config.icons[i];
        }
        item = [[HSFCircleMenuItem alloc]initWithTitle:title titleColor:self.config.titleColor fontSize:self.config.fontSize icon:icon];
        if (self.config.direction == HSFCircleDirection_clockwise) {
            angle = -perAngle*i + 90.f;
        }else{
            angle = perAngle*i + 90.f;
        }
        
        //添加
        CGPoint center_item = [self calcCircleCoordinateWithCenter:CGPointMake(self.config.radius, self.config.radius) andWithAngle:angle andWithRadius:(radius_item-space)];
        item.frame = CGRectMake(0, 0, w, h);
        item.center = center_item;
        [self.itemCenterPointArr addObject:[NSValue valueWithCGPoint:center_item]];
        [self.items addObject:item];
        //圆角
        item.layer.masksToBounds = YES;
        item.layer.cornerRadius = w/2.f;
        //item背景色
        item.backgroundColor = self.config.itemBgColor;
        //添加
        [self addSubview:item];
        //添加点击事件
        [item setTag:(100+i)];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapItemACTION:)];
        [item addGestureRecognizer:tap];
        
        //是否圆形布局
        [self rotateItemIfIsCircleLayout:item angle:angle];
    }
}

//是否圆形布局
-(void)rotateItemIfIsCircleLayout:(HSFCircleMenuItem *)item angle:(CGFloat)angle{
    if (self.config.isCircleLayout) {
        if (self.config.direction == HSFCircleDirection_clockwise){
            item.transform = CGAffineTransformRotate(item.transform,(-2*M_PI)*((angle-90.f)/360.f));
        }else{
            item.transform = CGAffineTransformRotate(item.transform,(2*M_PI)*((90.f-angle)/360.f));
        }
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



#pragma mark 动画
-(void)startAnimaiton {
    self.backgroundColor = self.config.bgColor;
    self.hidden = NO;
    
    if (self.config.useNewAnimationWay) {
        //bg动画
        if (self.config.animation_bg == HSFCircleBgAnimation_none) {
            //...
        }
        else if (self.config.animation_bg == HSFCircleBgAnimation_bgCircleMove) {
            [self.animationHelper animation_bgCircleMove_for:self.maskLayer];
        }
        else if (self.config.animation_bg == HSFCircleBgAnimation_bgCircleOpen) {
            self.backgroundColor = [UIColor clearColor];
            [self.animationHelper animation_bgCircleOpen_withOpenLayerArr:self.openLayerArr];
        }
        //item动画
        if (self.config.animation_item == HSFCircleItemAnimation_none) {
            //...
        }
        else if (self.config.animation_item == HSFCircleItemAnimation_itemCircleMove) {
            [self.animationHelper animation_itemCircleMove_for:self.layer];
        }
        else if (self.config.animation_item == HSFCircleItemAnimation_itemShoot) {
            [self.animationHelper animation_itemShoot_withItems:self.items itemCenterPointArr:self.itemCenterPointArr];
        }
        else if (self.config.animation_item == HSFCircleItemAnimation_itemShootBy) {
            [self.animationHelper animation_itemShootBy_withItems:self.items itemCenterPointArr:self.itemCenterPointArr];
        }
    }else{
        if (self.config.animation == HSFCircleAnimation_bgCircleMove) {
//            [self animationACTION_bgCircleMove];
            [self.animationHelper animation_bgCircleMove_for:self.maskLayer];
        }
        else if (self.config.animation == HSFCircleAnimation_itemCircleMove) {
//            [self animationACTION_itemCircleMove];
            [self.animationHelper animation_itemCircleMove_for:self.layer];
        }
        else if (self.config.animation == HSFCircleAnimation_followMove) {
//            [self animationACTION_bgCircleMove];
//            [self animationACTION_itemCircleMove];
            
            [self.animationHelper animation_bgCircleMove_for:self.maskLayer];
            [self.animationHelper animation_itemCircleMove_for:self.layer];
        }
        else if (self.config.animation == HSFCircleAnimation_bgCircleOpen) {
//            [self animationACTION_bgCircleOpen];
            
            self.backgroundColor = [UIColor clearColor];
            [self.animationHelper animation_bgCircleOpen_withOpenLayerArr:self.openLayerArr];
        }
        else if (self.config.animation == HSFCircleAnimation_itemShoot) {
//            [self animationACTION_itemShoot];
            [self.animationHelper animation_itemShoot_withItems:self.items itemCenterPointArr:self.itemCenterPointArr];
        }
        else if (self.config.animation == HSFCircleAnimation_itemShootBy) {
//            [self animationACTION_itemShootBy];
            [self.animationHelper animation_itemShootBy_withItems:self.items itemCenterPointArr:self.itemCenterPointArr];
        }
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
-(void)animationACTION_bgCircleOpen{
    self.backgroundColor = [UIColor clearColor];
    __block typeof(self) weakSelf = self;
    [self.openLayerArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CALayer *layer = (CALayer *)obj;
        //动画
        CABasicAnimation *animation_normal = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        if (!weakSelf.config.bgImg) {
            animation_normal.fromValue = @0;
            animation_normal.toValue = @1;
        }else{
            animation_normal.fromValue = @1;
            animation_normal.toValue = @0;
        }
        animation_normal.duration = self.config.during;
        animation_normal.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        animation_normal.repeatCount = self.config.repeatCount;
        animation_normal.removedOnCompletion = NO;
        animation_normal.fillMode = kCAFillModeForwards;
        [layer addAnimation:animation_normal forKey:nil];
    }];
}
-(void)animationACTION_itemShoot{
    //复位
//    [self resetItemPosition];
    //动画
    __block typeof(self) weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        for (int i = 0; i < weakSelf.items.count; i++) {
            NSValue *toValue = weakSelf.itemCenterPointArr[i];
            __block CGPoint toPoint = toValue.CGPointValue;
            __block HSFCircleMenuItem *item = weakSelf.items[i];
            
            //方法一：需要打开复位代码
//            [UIView animateWithDuration:weakSelf.config.during animations:^{
//                [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
//                item.frame = CGRectMake(toPoint.x-item.frame.size.width/2.f, toPoint.y-item.frame.size.height/2.f, item.frame.size.width, item.frame.size.height);
//            }];
            
            
            //方法二：
            CABasicAnimation *animation_normal = [CABasicAnimation animationWithKeyPath:@"position"];
            animation_normal.fromValue = [NSValue valueWithCGPoint:CGPointMake(weakSelf.config.radius, weakSelf.config.radius)];
            animation_normal.toValue = toValue;
            animation_normal.duration = self.config.during;
            animation_normal.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            animation_normal.repeatCount = self.config.repeatCount;
            animation_normal.removedOnCompletion = NO;
            animation_normal.fillMode = kCAFillModeForwards;
            [item.layer addAnimation:animation_normal forKey:@"ani"];
        }
    });
}
-(void)animationACTION_itemShootBy{
    __block typeof(self) weakSelf = self;
    //复位
//    [self resetItemPosition];
    
    
//    //方法一：需要打开复位代码
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [weakSelf itemShootBy:0];
//    });
    
    //方法二：
    [self.items enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        HSFCircleMenuItem *item = (HSFCircleMenuItem *)obj;
        item.hidden = YES;
    }];
    for (int i = 0; i < self.items.count; i++) {
        NSValue *toValue = self.itemCenterPointArr[i];
        __block CGPoint toPoint = toValue.CGPointValue;
        __block HSFCircleMenuItem *item = self.items[i];
        
        CGFloat perDuring = self.config.during/self.items.count;
//        CGFloat aheadDuring = perDuring/3.f;
        CGFloat aheadDuring = 0.f;
        CGFloat startTime = (perDuring*i-aheadDuring);
        if (i == 0) {
            startTime = 0.f;
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(startTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            item.hidden = NO;
            CABasicAnimation *animation_normal = [CABasicAnimation animationWithKeyPath:@"position"];
            animation_normal.fromValue = [NSValue valueWithCGPoint:CGPointMake(weakSelf.config.radius, weakSelf.config.radius)];
            animation_normal.toValue = toValue;
            animation_normal.duration = self.config.during;
            animation_normal.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
            animation_normal.repeatCount = self.config.repeatCount;
            animation_normal.removedOnCompletion = NO;
            animation_normal.fillMode = kCAFillModeForwards;
            [item.layer addAnimation:animation_normal forKey:@"ani"];
        });
    }
}
//复位
-(void)resetItemPosition{
    __block typeof(self) weakSelf = self;
    [self.items enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        HSFCircleMenuItem *item = (HSFCircleMenuItem *)obj;
        item.center = CGPointMake(weakSelf.config.radius, weakSelf.config.radius);
    }];
}
-(void)itemShootBy:(NSInteger)i{
    NSValue *toValue = self.itemCenterPointArr[i];
    __block CGPoint toPoint = toValue.CGPointValue;
    __block HSFCircleMenuItem *item = self.items[i];
    __block typeof(self) weakSelf = self;
    __block NSInteger index = i;
    [UIView animateWithDuration:self.config.during/self.items.count animations:^{
        //方法一：需要打开复位代码
        [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
        item.frame = CGRectMake(toPoint.x-item.frame.size.width/2.f, toPoint.y-item.frame.size.height/2.f, item.frame.size.width, item.frame.size.height);
    }completion:^(BOOL finished) {
        if (index < weakSelf.items.count-1) {
            index++;
            [weakSelf itemShootBy:index];
        }
    }];
}


//停止动画
-(void)puaseAnimation{
    self.backgroundColor = [UIColor clearColor];
    self.hidden = YES;
    [self.maskLayer removeAllAnimations];
}


#pragma mark CAAnimationDelegate
- (void)animationDidStart:(CAAnimation *)anim{
    
}
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    
}





#pragma mark 辅助方法
//计算圆圈上点在IOS系统中的坐标
-(CGPoint)calcCircleCoordinateWithCenter:(CGPoint) center  andWithAngle : (CGFloat) angle andWithRadius: (CGFloat) radius{
    CGFloat x2 = radius*cosf(angle*M_PI/180.f);
    CGFloat y2 = radius*sinf(angle*M_PI/180.f);
    return CGPointMake(center.x+x2, center.y-y2);
}
//保护数组不越界
-(NSInteger)getSafeCountOfAllItems{
    if (!self.config.icons) {
        self.config.icons = @[];
    }
    if (!self.config.titles) {
        self.config.titles = @[];
    }
    NSInteger deta = self.config.icons.count-self.config.titles.count;
    NSInteger count = (deta > 0)?self.config.icons.count : self.config.titles.count;
    return count;
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
-(NSMutableArray *)itemCenterPointArr{
    if (!_itemCenterPointArr) {
        _itemCenterPointArr = [NSMutableArray array];
    }
    return _itemCenterPointArr;
}


@end
