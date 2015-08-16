//
//  WBOAuthViewController.m
//  微博
//
//  Created by jewelz on 15/8/1.
//  Copyright (c) 2015年 yangtzeu. All rights reserved.
//

#import "WBOAuthViewController.h"
#import "WBTabBarController.h"
#import "WBAccountManager.h"
#import "WBAccount.h"

@interface WBOAuthViewController ()<UIWebViewDelegate>

@end

@implementation WBOAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    webView.delegate = self;
    [self.view addSubview:webView];
    
    NSString *path = @"https://api.weibo.com/oauth2/authorize?client_id=813370806&redirect_uri=http://www.baidu.com";
    //NSString *path = @"http://www.baidu.com";

    
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:path]]];
    

}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    NSLog(@"webViewDidStartLoad");
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {

    NSString *url = request.URL.absoluteString;
    
    NSRange range = [url rangeOfString:@"code="];
    if (range.length != 0) {
        NSInteger formIndex = range.location + range.length;
        NSString *code = [url substringFromIndex:formIndex];
        NSLog(@"code: %@", code);
        
        [self getTokenWithCode:code];
        
        return NO;
    }
    
    return YES;
}

- (void)getTokenWithCode:(NSString *)code {
    
    /*https://api.weibo.com/oauth2/access_token
     client_id	true	string	申请应用时分配的AppKey。 813370806
     client_secret	true	string	申请应用时分配的AppSecret。
     grant_type	true	string	请求的类型，填写authorization_code
     
     grant_type为authorization_code时
     必选	类型及范围	说明
     code	true	string	调用authorize获得的code值。
     redirect_uri
     
     */
    
    NSString *host = @"https://api.weibo.com/oauth2/access_token";
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:host]];
   
    NSString *data = [NSString stringWithFormat:@"client_id=%@&client_secret=%@&grant_type=%@&code=%@&redirect_uri=%@",@"813370806",@"fe40ebdddb7ca17b866f0d82b9879d71",@"authorization_code",code,@"http://www.baidu.com"];
    request.HTTPMethod = @"POST";
    request.HTTPBody = [data dataUsingEncoding:NSUTF8StringEncoding];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (data) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            NSLog(@"data %@", dict);
            WBAccount *account = [WBAccount accountWithDict:dict];
            //将对象存到沙盒中
            [WBAccountManager saveAccount:account];
            
            UIWindow *window = [UIApplication sharedApplication].keyWindow;
            window.rootViewController = [[WBTabBarController alloc] init];
            
        } else {
             NSLog(@"error %@", connectionError);
        }
        
    }];
}

@end
