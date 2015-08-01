//
//  WBSearchBar.m
//  微博
//
//  Created by jewelz on 15/4/25.
//  Copyright (c) 2015年 yangtzeu. All rights reserved.
//

#import "WBSearchBar.h"

@implementation WBSearchBar

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        NSLog(@"initWithFrame");
        self.font = [UIFont systemFontOfSize:15];
        self.placeholder = @"请输入搜索条件";
        self.background = [UIImage imageNamed:@"searchbar_textfield_background"];
        
        
        UIImageView *image = [[UIImageView alloc] init];
        image.image = [UIImage imageNamed:@"searchbar_textfield_search_icon"];
        image.width = 30;
        image.height = 30;
        image.contentMode = UIViewContentModeCenter;
        self.leftView = image;
        self.leftViewMode = UITextFieldViewModeAlways;
    }
    return self;
}

+ (instancetype)searchBar {
    return [[self alloc] init];     //init方法会自动调用initWithFrame:方法
}
@end
