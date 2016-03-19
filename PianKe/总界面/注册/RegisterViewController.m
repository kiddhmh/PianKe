//
//  RegisterViewController.m
//  PianKe
//
//  Created by 胡明昊 on 16/2/29.
//  Copyright © 2016年 CMCC. All rights reserved.
//

#import "RegisterViewController.h"
#import "RegisterTopView.h"
#import "Masonry.h"
#import "RegisterBottomView.h"
#import "SVProgressHUD.h"
#import "HMHTextField.h"
#import "DropDownMenu.h"
#import "NSString+Extension.h"
#import "HttpTool.h"
@interface RegisterViewController () <UINavigationControllerDelegate,UIImagePickerControllerDelegate>
/**
 *  上部分视图
 */
@property (nonatomic,strong) RegisterTopView *topView;
/**
 *  下部分视图
 */
@property (nonatomic,strong) RegisterBottomView *bottomView;
/**
 *  头像文件名
 */
@property (nonatomic,strong) NSString *imageFile;

@end

@implementation RegisterViewController


#pragma mark -
#pragma mark - 生命周期方法
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.imageFile = @"头像";
    
    [self.view addSubview:self.topView];
    [self.topView.backBtn addTarget:self action:@selector(backTo) forControlEvents:UIControlEventTouchUpInside];
    //给头像添加手势，选择照片
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(choosePhoto)];
    [self.topView.iconImageView addGestureRecognizer:tap];
    self.topView.iconImageView.userInteractionEnabled = YES;
    
    [self.view addSubview:self.bottomView];
    //给按钮添加关联方法
    [self.bottomView.FinishBtn addTarget:self action:@selector(FinishRegiste) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomView.messageBtn addTarget:self action:@selector(showMessage) forControlEvents:UIControlEventTouchUpInside];
    
    [self setupAutoLayout];
    
    //添加通知监听键盘的显示和隐藏
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeFrame) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(backFrame) name:UIKeyboardWillHideNotification object:nil];
}


/**
 *  页面被销毁时，移除通知
 */
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - 
#pragma mark - 自动适配
- (void)setupAutoLayout
{
    __weak typeof(self)vc = self;
    //设置上部分视图约束
    [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(vc.view.mas_top);
        make.centerX.equalTo(vc.view.mas_centerX);
        make.left.equalTo(vc.view.mas_left);
        make.height.mas_equalTo([UIScreen mainScreen].bounds.size.height * 0.4);
    }];
    
    //设置下部分视图的约束
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(vc.topView.mas_bottom);
        make.left.and.right.bottom.equalTo(vc.view);
    }];
    
}

#pragma mark -
#pragma mark - 懒加载
- (RegisterTopView *)topView
{
    if (!_topView) {
        _topView = [[RegisterTopView alloc] init];
    }
    return _topView;
}


- (RegisterBottomView *)bottomView
{
    if (!_bottomView) {
        _bottomView = [[RegisterBottomView alloc] init];
    }
    return _bottomView;
}


#pragma mark -
#pragma mrk - 按钮关联方法
/**
 *  返回上一级页面
 */
- (void)backTo
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


/**
 *  完成注册按钮
 */
- (void)FinishRegiste
{
    //先进行判断，三个文本框是否都输入文字
    if ([self isRight]) {
        NSLog(@"注册成功");
            NSDictionary *dic = @{@"client":@"1",
                                  @"deviceid":@"A55AF7DB-88C8-408D-B983-D0B9C9CA0B36",
                                  @"email":_bottomView.YXTextField.text,
                                  @"gender":_topView.xingbie,
                                  @"passwd":_bottomView.MMTextField.text,
                                  @"uname":_bottomView.nameTextField.text,
                                  @"version":@"3.0.6",
                                  @"auth":@"",
                                  @"iconfile":_imageFile};
        
       AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"pplication/x-javascript"];
        [manager POST:@"http://api2.pianke.me/user/reg" parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
            
            if ([_imageFile isEqualToString:@"头像"]) return;
            else{
                
                UIImage *postImage = [UIImage imageWithContentsOfFile:_imageFile];
                NSData *imageData = UIImageJPEGRepresentation(postImage, 0.1);
                [formData appendPartWithFileData:imageData name:@"iconfile" fileName:_imageFile    mimeType:@"image/png"];
            }
            
        } success:^(NSURLSessionDataTask *task, id responseObject) {
            
            NSString *errorStr = [[responseObject objectForKey:@"data"] objectForKey:@"msg"];
            if (errorStr != nil) {
                [DropDownMenu showWith:errorStr to:self.view belowSubView:self.view];
            }
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
            [SVProgressHUD showErrorWithStatus:@"图片上传失败"];
        }];
    }
}

/**
 *  点击进入片刻协议页面
 */
- (void)showMessage
{
    NSLog(@"片刻协议页面");
}



#pragma mark - 
#pragma mark - 手势关联方法
- (void)choosePhoto
{
    //显示弹框
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *actionPhoto = [UIAlertAction actionWithTitle:@"相机拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
       //开启相机，拍照
        [self takePhoto:0];
    }];
    
    UIAlertAction *actionLibrary = [UIAlertAction actionWithTitle:@"从相册中选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
       //从相册中选择照片
        [self takePhoto:1];
    }];
    
    UIAlertAction *actionCancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [alertVC dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [alertVC addAction:actionPhoto];
    [alertVC addAction:actionLibrary];
    [alertVC addAction:actionCancel];
    
    [self presentViewController:alertVC animated:YES completion:nil];
    
}



#pragma mark -
#pragma mark - 通知方法
/**
 *  页面上移
 */
- (void)changeFrame
{
    self.view.transform = CGAffineTransformMakeTranslation(0, -100);
}

/**
 *  页面恢复
 */
- (void)backFrame
{
    self.view.transform = CGAffineTransformIdentity;
}


#pragma mark - 
#pragma mark - 其他方法
/**
 *  开启相机或者相册
 *
 *  @param index 索引
 */
- (void)takePhoto:(NSInteger)index
{
    switch (index) {
        case 0:
            //唤醒相机
        {
            
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                //创建图片拾取器
                UIImagePickerController *picker = [[UIImagePickerController alloc] init];
                //设置代理
                picker.delegate = self;
                //设置来源
                picker.sourceType = UIImagePickerControllerSourceTypeCamera;
                //允许编辑照片
                picker.allowsEditing = YES;
                [self presentViewController:picker animated:YES completion:nil];
            }else
            {
                [SVProgressHUD showErrorWithStatus:@"您的设备不支持相机功能"];
            }
        }
            break;
        case 1:
            //唤醒相册
        {
            
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
                //创建图片拾取器
                UIImagePickerController *picker = [[UIImagePickerController alloc] init];
                //设置代理
                picker.delegate = self;
                //设置来源
                picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                //允许编辑照片
                picker.allowsEditing = YES;
                [self presentViewController:picker animated:YES completion:nil];
            }else
            {
                [SVProgressHUD showErrorWithStatus:@"您的设备不支持相册功能"];
            }
        }
            break;
        default:
            break;
    }

}


#pragma mark - 
#pragma mark - 图片拾取器代理方法
/**
 *  完成获取图片的操作
 */
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    //获取编辑过的照片，设置头像
    UIImage *iconImage = info[UIImagePickerControllerEditedImage];
    //将图片写入沙盒
    NSString *homePath = [NSHomeDirectory() stringByAppendingString:@"/Documents"];
    
    NSString *imageViews   = [homePath stringByAppendingFormat:@"/%d.png", arc4random_uniform(1000000)];
    [UIImageJPEGRepresentation(iconImage, 1.0f) writeToFile:imageViews atomically:YES];
    self.imageFile = imageViews;

    self.topView.iconImageView.image = iconImage;
    self.topView.iconImageView.layer.cornerRadius = 28;
    self.topView.iconImageView.layer.masksToBounds = YES;
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark -
#pragma mark - 判断文本框是否符合规范
- (BOOL)isRight
{
    if (self.bottomView.nameTextField.text.length == 0) {
        [DropDownMenu showWith:@"请输入昵称" to:self.view belowSubView:self.view];
        return NO;
    }else if (self.bottomView.YXTextField.text.length == 0)
    {
        [DropDownMenu showWith:@"请输入邮箱" to:self.view belowSubView:self.view];
        return NO;
    }else if (self.bottomView.MMTextField.text.length == 0){
        [DropDownMenu showWith:@"请输入密码" to:self.view belowSubView:self.view];
        return NO;
    }else if ([self.bottomView.YXTextField.text isEmail] == NO){
        [DropDownMenu showWith:@"邮箱格式错误" to:self.view belowSubView:self.view];
    }
    return YES;
}


/**
 * 隐藏状态栏
 */
- (BOOL)prefersStatusBarHidden
{
    return YES;
}

@end
