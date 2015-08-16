//
//  WBTabBar.m
//  微博
//
//  Created by jewelz on 15/8/8.
//  Copyright (c) 2015年 yangtzeu. All rights reserved.
//

#import "WBTabBar.h"

@interface WBTabBar ()

@property (nonatomic, weak) UIButton *plusBtn;

@end

@implementation WBTabBar

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UIButton *plusBtn = [[UIButton alloc] init];
        [plusBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [plusBtn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateNormal];
        plusBtn.size = plusBtn.currentBackgroundImage.size;
        [self addSubview:plusBtn];
        _plusBtn = plusBtn;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
   // self.plusBtn.width = self.width / 5;
   // self.plusBtn.height = self.height;
    
    self.plusBtn.center = CGPointMake(self.width*0.5, self.height*0.5);
    
    CGFloat width = self.width / 5;

    int index = 0;
    
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            view.width = self.width / 5;
            view.x = index * width;
            index ++;
            self.backgroundColor = [UIColor redColor];
            if (index == 2) {
                index ++;
            }
        }
    }
    
}

- (void)addTarget:(id)target action:(SEL)action {
    [self.plusBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
}

@end
