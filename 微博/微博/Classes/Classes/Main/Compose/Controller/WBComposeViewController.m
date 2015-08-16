//
//  WBComposeViewController.m
//  微博
//
//  Created by jewelz on 15/8/14.
//  Copyright (c) 2015年 yangtzeu. All rights reserved.
//

#import "WBComposeViewController.h"
#import "WBPlacehodelerTextView.h"

@interface WBComposeViewController ()<UITextViewDelegate>

@property (nonatomic, weak) UIView *toorBar;

@end

@implementation WBComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancle)];
    
    [self setupTextView];
}

- (void)setupTextView {
    WBPlacehodelerTextView *textView = [[WBPlacehodelerTextView alloc] initWithFrame:self.view.bounds];
    textView.delegate = self;
    textView.placeholder = @"发微博...";
    textView.placeholderColor = [UIColor lightGrayColor];
    [self.view addSubview:textView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    UIView *input = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.height, self.view.width, 44)];
    textView.alwaysBounceVertical = YES;    //垂直方向永远可以拖拽
    input.backgroundColor = [UIColor redColor];
    [self.view addSubview:input];
    self.toorBar = input;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    //只要拖拽就隐藏键盘
    [self.view endEditing:YES];
}


- (void)keyBoardWillChange:(NSNotification *)notification {
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
        self.toorBar.y = keyboardF.origin.y - self.toorBar.height;
    }];

}

- (void)cancle {
    [self dismissViewControllerAnimated:YES completion:nil];
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
