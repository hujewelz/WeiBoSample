//
//  WBComposeViewController.m
//  微博
//
//  Created by jewelz on 15/8/14.
//  Copyright (c) 2015年 yangtzeu. All rights reserved.
//

#import "WBComposeViewController.h"
#import "WBPlacehodelerTextView.h"

@interface WBComposeViewController ()

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
    UIView *input = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 44)];
    input.backgroundColor = [UIColor redColor];
    textView.inputAccessoryView = input;
    textView.placeholder = @"发微博...";
    textView.placeholderColor = [UIColor lightGrayColor];
    [self.view addSubview:textView];
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
