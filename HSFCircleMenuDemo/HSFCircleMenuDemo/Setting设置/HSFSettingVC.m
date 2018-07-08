//
//  HSFSettingVC.m
//  HSFCircleMenuDemo
//
//  Created by 黄山锋 on 2018/7/6.
//  Copyright © 2018年 黄山锋. All rights reserved.
//

#import "HSFSettingVC.h"

//cell
#import "HSFSettingCell.h"
//config
#import "HSFCircleMenuConfig.h"
//vc
#import "ColorSettingVC.h"

@interface HSFSettingVC ()<UITableViewDelegate,UITableViewDataSource, UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) HSFSettingCell *cell;
@property(nonatomic,strong) UIImagePickerController *imagePicker;
@property (nonatomic,assign) NSInteger type;

@end

@implementation HSFSettingVC

#pragma mark -viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"设置";
    self.view.backgroundColor = [UIColor whiteColor];
    //配置tableView
    [self setUpTableView];
    //保存
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveACTION)];
}
//配置tableView
-(void)setUpTableView{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.estimatedRowHeight = 44;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([HSFSettingCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([HSFSettingCell class])];
}

#pragma mark -UITableViewDelegate,UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    self.cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HSFSettingCell class])];
    self.cell.contentView.backgroundColor = [UIColor whiteColor];
    self.cell.config = self.config;
    
    //点击颜色
    [self.cell.titleColorBtn setTag:100];
    [self.cell.bgColorBtn setTag:200];
    [self.cell.itemBgColorBtn setTag:300];
    [self.cell.titleColorBtn addTarget:self action:@selector(colorSelectACTION:) forControlEvents:UIControlEventTouchUpInside];
    [self.cell.bgColorBtn addTarget:self action:@selector(colorSelectACTION:) forControlEvents:UIControlEventTouchUpInside];
    [self.cell.itemBgColorBtn addTarget:self action:@selector(colorSelectACTION:) forControlEvents:UIControlEventTouchUpInside];
    
    self.cell.bgImgView.userInteractionEnabled = YES;
    self.cell.centerImgView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap_bg = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(bgTapACTION)];
    UITapGestureRecognizer *tap_center = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(centerTapACTION)];
    [self.cell.bgImgView addGestureRecognizer:tap_bg];
    [self.cell.centerImgView addGestureRecognizer:tap_center];
    
    return self.cell;
}
#pragma mark -点击事件
//点击颜色
-(void)colorSelectACTION:(UIButton *)sender{
    ColorSettingVC *vc = [[ColorSettingVC alloc]init];
    __block typeof(self) weakSelf = self;
    switch (sender.tag) {
        case 100:
        {
            vc.titleStr = @"设置标题颜色";
            vc.curSelectColorBlock = ^(UIColor *color) {
                weakSelf.cell.titleColorView.backgroundColor = color;
                weakSelf.cell.config.titleColor = color;
            };
        }
            break;
        case 200:
        {
            vc.titleStr = @"设置背景颜色";
            vc.curSelectColorBlock = ^(UIColor *color) {
                weakSelf.cell.bgColorView.backgroundColor = color;
                weakSelf.cell.config.bgColor = color;
            };
        }
            break;
        case 300:
        {
            vc.titleStr = @"设置item背景颜色";
            vc.curSelectColorBlock = ^(UIColor *color) {
                weakSelf.cell.itemBgColorView.backgroundColor = color;
                weakSelf.cell.config.itemBgColor = color;
            };
        }
            break;
            
        default:
            break;
    }
    
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark 设置背景图
-(void)bgTapACTION{
    self.type = 0;
    [self showPhotoAlertWithTitle:@"设置背景图"];
}

#pragma mark 设置中心图
-(void)centerTapACTION{
    self.type = 1;
    [self showPhotoAlertWithTitle:@"设置中心图"];
}

#pragma mark 弹框
-(void)showPhotoAlertWithTitle:(NSString *)title{
    __block typeof(self) weakSelf = self;
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:title message:@"选取方式" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *camera = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf showSystemPhotoOrCamera:1];
    }];
    UIAlertAction *photo = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf showSystemPhotoOrCamera:2];
    }];
    [alertC addAction:cancel];
    [alertC addAction:camera];
    [alertC addAction:photo];
    [self presentViewController:alertC animated:YES completion:nil];
}
//调用系统相册、相机
-(void)showSystemPhotoOrCamera:(NSInteger)type{
    // 判断系统是否支持相机
    NSUInteger sourceType = 0;
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self; //设置代理
    imagePickerController.allowsEditing = YES;
    if (type == 0) {
        return;
    }else if (type == 1) {
        //拍照
        sourceType = UIImagePickerControllerSourceTypeCamera;
        imagePickerController.sourceType = sourceType;
        [self presentViewController:imagePickerController animated:YES completion:nil];
    }else if (type == 2){
        //相册
        sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        imagePickerController.sourceType = sourceType;
        [self presentViewController:imagePickerController animated:YES completion:nil];
    }
}
#pragma mark -
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:^{}];
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage]; //通过key值获取到图片
    if (self.type == 0) {
        self.cell.config.bgImg = image;
        self.cell.bgImgView.image = image;
    }else{
        self.cell.config.centerImg = image;
        self.cell.centerImgView.image = image;
    }
}


#pragma mark 点击保存
-(void)saveACTION{
    self.config = self.cell.config;
    if ([self.delegate respondsToSelector:@selector(saveSettingWithConfig:)]) {
        [self.delegate saveSettingWithConfig:self.config];
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
