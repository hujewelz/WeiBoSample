//
//  WBComposeViewController.m
//  微博
//
//  Created by jewelz on 15/8/14.
//  Copyright (c) 2015年 yangtzeu. All rights reserved.
//

#import "WBComposeViewController.h"
#import "WBPlacehodelerTextView.h"
#import "HWComposeToolbar.h"
#import "HWEmotionKeyboard.h"
#import "WBFileKeyboard.h"

@interface WBComposeViewController ()<UITextViewDelegate, HWComposeToolbarDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate> {
    int _selectedItem;
    int _lastSelectedItem;
    
}

//@property (nonatomic, weak) UIView *toorBar;
/** 键盘顶部的工具条 */
@property (nonatomic, weak) HWComposeToolbar *toolbar;

@property (nonatomic, weak) WBPlacehodelerTextView *textView;
/** 相册（存放拍照或者相册中选择的图片） */
//@property (nonatomic, weak) HWComposePhotosView *photosView;
/** 表情键盘 */
@property (nonatomic, strong) HWEmotionKeyboard *emotionKeyboard;
/** 文件键盘 */
@property (nonatomic, strong) WBFileKeyboard *fileKeyboard;
/** 是否正在切换键盘 */
@property (nonatomic, assign) BOOL showKeybaord;
@end

@implementation WBComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancle)];
    
    // 添加输入控件
    [self setupTextView];
    
    // 添加工具条
    [self setupToolbar];
}

- (void)setupTextView {
    WBPlacehodelerTextView *textView = [[WBPlacehodelerTextView alloc] initWithFrame:self.view.bounds];
    textView.delegate = self;
    textView.placeholder = @"发微博...";
    textView.placeholderColor = [UIColor lightGrayColor];
    [self.view addSubview:textView];
    self.textView = textView;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    self.showKeybaord = YES;
    
//    UIView *input = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.height, self.view.width, 44)];
//    textView.alwaysBounceVertical = YES;    //垂直方向永远可以拖拽
//    input.backgroundColor = [UIColor redColor];
//    [self.view addSubview:input];
//    self.toorBar = input;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // 成为第一响应者（能输入文本的控件一旦成为第一响应者，就会叫出相应的键盘）
    //[self.textView becomeFirstResponder];
}

#pragma mark - 懒加载
- (HWEmotionKeyboard *)emotionKeyboard
{
    if (!_emotionKeyboard) {
        self.emotionKeyboard = [[HWEmotionKeyboard alloc] init];
        self.emotionKeyboard.width = self.view.width;
        self.emotionKeyboard.height = 216;
    }
    return _emotionKeyboard;
}

#pragma mark - 懒加载
- (WBFileKeyboard *)fileKeyboard
{
    if (!_fileKeyboard) {
        self.fileKeyboard = [[WBFileKeyboard alloc] init];
        self.fileKeyboard.width = self.view.width;
        self.fileKeyboard.height = 216;
    }
    return _fileKeyboard;
}


/**
 * 添加工具条
 */
- (void)setupToolbar
{
    HWComposeToolbar *toolbar = [[HWComposeToolbar alloc] init];
    toolbar.width = self.view.width;
    toolbar.height = 44;
    toolbar.y = self.view.height - toolbar.height;
    toolbar.delegate = self;
    [self.view addSubview:toolbar];
    self.toolbar = toolbar;
    
}


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    //只要拖拽就隐藏键盘
    [self.view endEditing:YES];
}


- (void)keyBoardWillChange:(NSNotification *)notification {
    
    // 如果正在切换键盘，就不要执行后面的代码
    if (self.textView.inputView && !self.showKeybaord) return;
   
    /**
     键盘弹出\隐藏动画的执行节奏
     UIKeyboardAnimationCurveUserInfoKey = 7;
     UIKeyboardAnimationDurationUserInfoKey = "0.25";
     键盘弹出\隐藏后的frame：
     UIKeyboardFrameEndUserInfoKey = "NSRect: {{0, 271}, {320, 297}}";
     */
    NSLog(@"%@", notification);
    
    NSDictionary *dict = [notification userInfo];
    NSTimeInterval duration = [dict[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    int curve = [dict[UIKeyboardAnimationCurveUserInfoKey] intValue];
    CGRect keyboardF = [dict[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    
    [UIView animateWithDuration:duration animations:^{
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationCurve:curve];
        // 工具条的Y值 == 键盘的Y值 - 工具条的高度
        if (keyboardF.origin.y > self.view.height) { // 键盘的Y值已经远远超过了控制器view的高度
            self.toolbar.y = self.view.height - self.toolbar.height; //让toorbar定在底部
        } else {
            self.toolbar.y = keyboardF.origin.y - self.toolbar.height;
        }
    }];

}

- (void)cancle {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - HWComposeToolbarDelegate
- (void)composeToolbar:(HWComposeToolbar *)toolbar didClickButton:(HWComposeToolbarButtonType)buttonType
{
    switch (buttonType) {
        case HWComposeToolbarButtonTypeCamera: // 拍照
            //[self openCamera];
            _selectedItem = 1;
            break;
            
        case HWComposeToolbarButtonTypePicture: // 相册
            //[self openAlbum];
            return;
            break;
            
        case HWComposeToolbarButtonTypeMention: // @
            break;
            return;
        case HWComposeToolbarButtonTypeTrend: // #
            //self.emotionKeyboard.selectedItem = 4;
            _selectedItem = 2;
            //self.textView.inputView = self.fileKeyboard;
            break;
            
        case HWComposeToolbarButtonTypeEmotion: // 表情\键盘
            
            _selectedItem = 3;
            //self.textView.inputView = self.emotionKeyboard;
            //[self switchKeyboard];
            break;
    }
    [self switchKeyboard];

}

#pragma mark - 其他方法
/**
 *  切换键盘
 */
- (void)switchKeyboard
{
    // self.textView.inputView == nil : 使用的是系统自带的键盘
    
    //NSLog(@"last selected: %d, selected: %d", _lastSelectedItem, _selectedItem);
    
    if (_selectedItem != _lastSelectedItem) {
        
        if (_lastSelectedItem !=0 && self.textView.inputView) {
            self.showKeybaord = NO;
        }
        self.textView.inputView = nil;
        //self.toolbar.showKeyboardState = YES;
        
        
    } else {
        self.showKeybaord = YES;
        //self.toolbar.showKeyboardState = NO;
    }
    
    if (self.textView.inputView == nil) { // 切换为自定义的表情键盘
    
        if (_selectedItem == 1) {
            _lastSelectedItem = 1;
            self.textView.inputView = self.emotionKeyboard;
        }
        if (_selectedItem == 2) {
            _lastSelectedItem = 2;
            self.textView.inputView = self.fileKeyboard;
        }
        if (_selectedItem == 3) {
            _lastSelectedItem = 3;
            self.textView.inputView = self.emotionKeyboard;
        }
        
        //self.toolbar.showKeyboardButton = NO;
    } else { // 切换为系统自带的键盘
        self.textView.inputView = nil;
        //self.toolbar.showKeyboardButton = YES;
    }
    
    // 开始切换键盘
    //self.switchingKeybaord = YES;
    
    // 退出键盘
    [self.textView endEditing:YES];
    //    [self.view endEditing:YES];
    //    [self.view.window endEditing:YES];
    //    [self.textView resignFirstResponder];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 弹出键盘
        [self.textView becomeFirstResponder];
        
        // 结束切换键盘
        //self.switchingKeybaord = NO;
    });
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.view endEditing:YES];
    //NSLog(@"text: %@", textField.text);
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    //NSLog(@"begin editing");
    //_selectedItem = 100;
    self.textView.inputView = nil;
    self.showKeybaord = YES;
//    if (!self.textView.inputView) {
//        _lastSelectedItem = _selectedItem;
//    }
    
}

- (void)openCamera
{
    [self openImagePickerController:UIImagePickerControllerSourceTypeCamera];
}

- (void)openAlbum
{
    // 如果想自己写一个图片选择控制器，得利用AssetsLibrary.framework，利用这个框架可以获得手机上的所有相册图片
    // UIImagePickerControllerSourceTypePhotoLibrary > UIImagePickerControllerSourceTypeSavedPhotosAlbum
    [self openImagePickerController:UIImagePickerControllerSourceTypePhotoLibrary];
}

- (void)openImagePickerController:(UIImagePickerControllerSourceType)type
{
    if (![UIImagePickerController isSourceTypeAvailable:type]) return;
    
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.sourceType = type;
    ipc.delegate = self;
    [self presentViewController:ipc animated:YES completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate
/**
 * 从UIImagePickerController选择完图片后就调用（拍照完毕或者选择相册图片完毕）
 */
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    // info中就包含了选择的图片
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    // 添加图片到photosView中
    //[self.photosView addPhoto:image];
}

- (void)test {
    //简单图文混排的实现
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(60, 100, 200, 100)];
    
    NSTextAttachment *att = [[NSTextAttachment alloc] init];
    att.image = [UIImage imageNamed:@"tabbar_compose_camera"];
    
    NSMutableAttributedString *aString = [[NSMutableAttributedString alloc]initWithString:@"图文混排"];
    
    [aString appendAttributedString:[NSAttributedString attributedStringWithAttachment:att]];
    label.attributedText = aString;
    
    [self.view addSubview:label];
}


@end
