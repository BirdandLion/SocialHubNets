//
//  GPComposeViewController.m
//  我的微博
//
//  Created by qianfeng on 16/1/9.
//  Copyright (c) 2016年 kelvin. All rights reserved.
//

#import "GPComposeViewController.h"
#import "GPEmotionTextView.h"
#import "GPEmotionTextView.h"
#import "GPComposeToolBar.h"
#import "GPComposePhotosView.h"
#import "GPAccountTool.h"
#import "GPHomeModel.h"
#import "MJExtension.h"
#import "MBProgressHUD+MJ.h"
#import "GPSendStatusResult.h"
#import "GPSendStatusParam.h"
#import "GPStatusTool.h"
#import "GPHttpTool.h"
#import "GPEmotionKeyboard.h"
#import "GPEmotion.h"

@interface GPComposeViewController ()<GPComposeToolBarDelegate, UITextViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic, weak) GPEmotionTextView *textView;
@property (nonatomic, weak) GPComposeToolBar *toolBar;
@property (nonatomic, weak) GPComposePhotosView *photosView;
@property (nonatomic, strong) GPEmotionKeyboard *keyboard;

@property (nonatomic, assign) BOOL isChangingKeyboard;

@end

@implementation GPComposeViewController

- (GPEmotionKeyboard*)keyboard
{
    if(_keyboard == nil)
    {
        self.keyboard = [GPEmotionKeyboard keyboard];
        self.keyboard.width = 375;
        self.keyboard.height = 216;
    }
    return _keyboard;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置导航内容
    [self setupNavBar];
    // 设置输入控件
    [self setupTextView];
    // 添加工具条
    [self setupToolbar];
    // 添加相册控件
    [self setupPhotosView];
    // 监听表情选中的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(emotionSelected:) name:GPEmotionDidSelectedNotification object:nil];
    // 监听表情删除按钮
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(emotionDeleteed:) name:GPEmotionDidDeletedNotification object:nil];
}

// 添加相册控件
- (void)setupPhotosView
{
    GPComposePhotosView *photosView = [[GPComposePhotosView alloc] init];
    photosView.width = self.textView.width;
    photosView.height = self.textView.height;
    photosView.y = 80;
    [self.textView addSubview:photosView];
    self.photosView = photosView;
}

// 添加工具条
- (void)setupToolbar
{
    // 1. 创建
    GPComposeToolBar *toolBar = [[GPComposeToolBar alloc] init];
    toolBar.width = self.view.width;
    toolBar.height = 44;
    toolBar.delegate = self;
    self.toolBar = toolBar;
    
    // 2. 显示
//    self.textView.inputAccessoryView = toolBar;
    toolBar.y = self.view.height - toolBar.height;
    [self.view addSubview:toolBar];
}

- (void)setupTextView
{
    // 1. 创建输入控件
    GPEmotionTextView *textView = [[GPEmotionTextView alloc] init];
    [self.view addSubview:textView];
    textView.frame = self.view.bounds;
    textView.alwaysBounceVertical = YES;
    textView.delegate = self;
    self.textView = textView;
    
    // 2. 设置占位文字
    textView.placeholder = @"分享新鲜事";
    
    // 3. 设置字体
    textView.font = [UIFont systemFontOfSize:17];
    
    // 4. 监听键盘
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardDidHideNotification object:nil];
}

// view 将要显示时调用
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // 成为第一响应者
    [self.textView becomeFirstResponder];
}

// 设置导航内容
- (void)setupNavBar
{
    NSString *name = [GPAccountTool account].name;
    if(name)
    {
        // 设置标题文本格式
        NSString *prefix = @"发微博";
        NSString *string = [NSString stringWithFormat:@"%@\n%@", prefix, name];
        NSMutableAttributedString *richText = [[NSMutableAttributedString alloc] initWithString:string];
        [richText addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:16] range:[string rangeOfString:prefix]];
        [richText addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:[string rangeOfString:name]];
        
        // 显示标题
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.text = string;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.numberOfLines = 0;
        titleLabel.width = 100;
        titleLabel.height = 44;
        self.navigationItem.titleView = titleLabel;
    }
    else
    {
        self.title = @"发微博";
    }
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelClick)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStylePlain target:self action:@selector(sendClick)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    self.view.backgroundColor = [UIColor whiteColor];
}

// 监听表情选中
- (void)emotionSelected:(NSNotification*)notification
{
    GPEmotion *emotion = notification.userInfo[GPSelectedEmotion];
    
    // 1. 拼接表情
    [self.textView appendEmotion:emotion];
    
    // 2. 检测文字长度
    [self textViewDidChange:self.textView];
}

// 点击了表情键盘上面的删除按钮
- (void)emotionDeleteed:(NSNotification*)notification
{
    // 往回删一个字符
    [self.textView deleteBackward];
}

// 取消
- (void)cancelClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
// 发送
- (void)sendClick
{
    if(self.photosView.images.count)
    {
        GPLog(@"Compose Send image");
        [self sendStatusWithImage];
    }
    else
    {
        GPLog(@"Compose Send text");
        [self sendStatusWithoutImage];
    }
}

// 发表有图片的微博
- (void)sendStatusWithImage
{
    // 1. 封装请求参数
    GPSendStatusParam *param = [[GPSendStatusParam alloc] init];
    param.access_token = [GPAccountTool account].access_token;
    param.status = self.textView.text;
    
    // 2. 发送POST请求
    [GPStatusTool sendStatusPictureWithParam:param constructionBodyWithBlock:^(id<AFMultipartFormData> formData) {
        // 拼接文件参数
#warning 目前新浪开发的发微博接口, 最多只能发送一张
        UIImage *image = [self.photosView.images firstObject];
        NSData *data = UIImageJPEGRepresentation(image, 1.0);
        [formData appendPartWithFileData:data name:@"pic" fileName:@"status.jpg" mimeType:@"image/jpeg"];
    } success:^(GPSendStatusResult *result) {
        [MBProgressHUD showSuccess:@"发送成功"];
    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"发送失败"];
    }];
    
    // 3. 关闭控制器
    [self dismissViewControllerAnimated:self completion:nil];
}

// 发表没有图片的微博
- (void)sendStatusWithoutImage
{       
    // 1. 封装请求参数
    GPSendStatusParam *param = [[GPSendStatusParam alloc] init];
    param.access_token = [GPAccountTool account].access_token;
    param.status = self.textView.realText;
    
    // 2. 发送微博
    [GPStatusTool sendStatusWithParam:param success:^(GPSendStatusResult *result) {
        [MBProgressHUD showSuccess:@"发送成功"];
    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"发送失败"];
    }];
    
    // 3. 关闭控制器
    [self dismissViewControllerAnimated:self completion:nil];
}

// 键盘将要显示

- (void)keyboardWillShow:(NSNotification*)note
{
    // 1. 取出键盘弹出的时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    // 2. 设置toolbar的动画时间
    [UIView animateWithDuration:duration animations:^{
        CGRect keyboardFrame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
        CGFloat keyboardH = keyboardFrame.size.height;
        self.toolBar.transform = CGAffineTransformMakeTranslation(0, -keyboardH);
    }];
}

- (void)keyboardWillHide:(NSNotification*)note
{
    if(self.isChangingKeyboard) return;

    // 1. 取出键盘弹出的时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    // 2. 设置toolbar的动画时间
    [UIView animateWithDuration:duration animations:^{
        self.toolBar.transform = CGAffineTransformIdentity;
    }];
}

#pragma mark - GPComposeToolBarDelegate

- (void)composeToolBar:(GPComposeToolBar *)toolbar didClickedButton:(GPComposeToolBarButtonType)buttonType
{
    switch (buttonType) {
        case GPComposeToolBarButtonTypeCamera:
            [self openCamera];
            break;
        case GPComposeToolBarButtonTypePicture:
            [self openAlbum];
            break;
        case GPComposeToolBarButtonTypeMention:
            
            break;
        case GPComposeToolBarButtonTypeTrend:
            
            break;
        case GPComposeToolBarButtonTypeEmotion:
            [self openEmotion];
            break;
            
        default:
            break;
    }
}

// 打开照相机
- (void)openCamera
{
    if(![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        return;
    
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
    ipc.delegate = self;
    [self presentViewController:ipc animated:YES completion:nil];
}

// 打开相册
- (void)openAlbum
{
    if(![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum])
        return;
    
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    ipc.delegate = self;
    [self presentViewController:ipc animated:YES completion:nil];
}

// 打开表情 - 键盘高度216
- (void)openEmotion
{
    // 正在切换键盘
    self.isChangingKeyboard = YES;
    
    if(self.textView.inputView)
    {
        self.textView.inputView = nil;
        // 显示表情图片
        self.toolBar.showEmotionButton = YES;
    }
    else
    {
        // 如果临时更换了文本框的键盘,一定要重新打开键盘
        self.textView.inputView = self.keyboard;
        // 不显示表情图片
        self.toolBar.showEmotionButton = NO;
    }
    
    // 关闭键盘
    [self.textView resignFirstResponder];
    
    // 打开键盘
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.textView becomeFirstResponder];
        // 更换键盘完毕
        self.isChangingKeyboard = NO;
    });
    
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    // 1. 取出选中的图片
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    // 2. 添加图片到相册中
    [self.photosView addImage:image];
    
}

#pragma mark - UITextViewDelegate
// 当用户开始拖拽时调用
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

- (void)textViewDidChange:(UITextView *)textView
{
    self.navigationItem.rightBarButtonItem.enabled = textView.attributedText.length != 0;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
