//
//  WBNavigationController.m
//  微博
//
//  Created by jewelz on 15/4/23.
//  Copyright (c) 2015年 yangtzeu. All rights reserved.
//

#import "WBNavigationController.h"

@interface WBNavigationController ()

@end

@implementation WBNavigationController
+ (void)initialize {
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    
    //设置正常状态
    NSDictionary *attribute = @{NSForegroundColorAttributeName:[UIColor orangeColor], NSFontAttributeName:[UIFont systemFontOfSize:14]};
    [item setTitleTextAttributes:attribute forState:UIControlStateNormal];
    
    //设置不可用状态
    NSDictionary *disAttribute = @{NSForegroundColorAttributeName:[UIColor lightGrayColor], NSFontAttributeName:[UIFont systemFontOfSize:14]};
    [item setTitleTextAttributes:disAttribute forState:UIControlStateDisabled];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(back) image:@"navigationbar_back" highLighted:@"navigationbar_back_highlighted"];
        
        viewController.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(more) image:@"navigationbar_more" highLighted:@"navigationbar_more_highlighted"];
        
    }
    [super pushViewController:viewController animated:YES];
}

- (void)back {
    [self popViewControllerAnimated:YES];
}

- (void)more {
    [self popToRootViewControllerAnimated:YES];
}

@end
