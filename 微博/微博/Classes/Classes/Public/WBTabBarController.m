//
//  WBTabBarController.m
//  微博
//
//  Created by jewelz on 15/4/23.
//  Copyright (c) 2015年 yangtzeu. All rights reserved.
//

#import "WBTabBarController.h"
#import "WBNavigationController.h"

@interface WBTabBarController ()

@end

@implementation WBTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBar.tintColor = [UIColor redColor];
    
    UIViewController *vc1 = [[UIViewController alloc] init];
    [self addChildViewController:vc1 withTitle:@"首页" image:@"tabbar_home" andSelectedImage:@"tabbar_home_selected"];
    
    UIViewController *vc2 = [[UIViewController alloc] init];
    [self addChildViewController:vc2 withTitle:@"消息" image:@"tabbar_message_center" andSelectedImage:@"tabbar_message_center_selected"];
    
    UIViewController *vc3 = [[UIViewController alloc] init];
    [self addChildViewController:vc3 withTitle:nil image:@"tabbar_compose_background_icon_add" andSelectedImage:@"tabbar_compose_background_icon_add"];
    
    UIViewController *vc4 = [[UIViewController alloc] init];
    [self addChildViewController:vc4 withTitle:@"发现" image:@"tabbar_discover" andSelectedImage:@"tabbar_discover_selected"];
    
    UIViewController *vc5 = [[UIViewController alloc] init];
    [self addChildViewController:vc5 withTitle:@"我" image:@"tabbar_profile" andSelectedImage:@"tabbar_profile_selected"];
    
    
}

- (void)addChildViewController:(UIViewController *)childController withTitle:(NSString *)title image:(NSString *)image andSelectedImage:(NSString *)selectedImage{
    childController.title = title;
    childController.view.backgroundColor = [self randomColor];
    
    childController.tabBarItem.image = [UIImage imageNamed:image];
    //设置选择的图片 imageWithRenderingMode设置图片渲染模式 UIImageRenderingModeAlwaysOriginal：不渲染
    childController.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    NSDictionary *attributeNormal = @{NSForegroundColorAttributeName:[UIColor lightGrayColor]};
    NSDictionary *attributeSelected = @{NSForegroundColorAttributeName:[UIColor redColor]};
    [childController.tabBarItem setTitleTextAttributes:attributeNormal forState:UIControlStateNormal];
    [childController.tabBarItem setTitleTextAttributes:attributeSelected forState:UIControlStateSelected];
    
    
    [self addChildViewController:[[WBNavigationController alloc] initWithRootViewController:childController]];
}

- (UIColor *)randomColor {
    return [UIColor colorWithRed:arc4random_uniform(255)/255.0f green:arc4random_uniform(255)/255.0f blue:arc4random_uniform(255)/255.0f alpha:1];
}


@end
