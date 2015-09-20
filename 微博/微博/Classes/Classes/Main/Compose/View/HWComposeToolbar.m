//
//  HWComposeToolbar.m
//  黑马微博2期
//
//  Created by apple on 14-10-20.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "HWComposeToolbar.h"

@interface HWComposeToolbar ()

@property (nonatomic, strong) NSMutableArray *buttons;
@property (nonatomic, weak) UIButton *lastSelectedBtn;
@property (nonatomic, weak) UITextField *textField;

@end

@implementation HWComposeToolbar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"compose_toolbar_background"]];
        self.buttons = [NSMutableArray arrayWithCapacity:3];
        //self.showKeyboardState = YES;
        // 初始化按钮
        [self setupBtn:@"compose_camerabutton_background" highImage:@"compose_camerabutton_background_highlighted" type:HWComposeToolbarButtonTypeCamera];
        
        UITextField *textField = [[UITextField alloc] init];
        //textField.backgroundColor = [UIColor orangeColor];
        textField.borderStyle = UITextBorderStyleRoundedRect;
        [self addSubview:textField];
        self.textField = textField;
        
        //[self setupBtn:@"compose_toolbar_picture" highImage:@"compose_toolbar_picture_highlighted" type:HWComposeToolbarButtonTypePicture];
        
        //[self setupBtn:@"compose_mentionbutton_background" highImage:@"compose_mentionbutton_background_highlighted" type:HWComposeToolbarButtonTypeMention];
        
        [self setupBtn:@"compose_emoticonbutton_background" highImage:@"compose_emoticonbutton_background_highlighted" type:HWComposeToolbarButtonTypeEmotion];
    
        [self setupBtn:@"compose_trendbutton_background" highImage:@"compose_trendbutton_background_highlighted" type:HWComposeToolbarButtonTypeTrend];
    }
    return self;
}

/**
 * 创建一个按钮
 */
- (UIButton *)setupBtn:(NSString *)image highImage:(NSString *)highImage type:(HWComposeToolbarButtonType)type
{
    UIButton *btn = [[UIButton alloc] init];
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    [btn setImage:[UIImage imageNamed:@"compose_keyboardbutton_background"] forState:UIControlStateSelected];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    //btn.backgroundColor = [UIColor redColor];
    btn.tag = type;
    [self addSubview:btn];
    [self.buttons addObject:btn];
    return btn;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 设置所有按钮的frame
    int count = 7;
    CGFloat btnW = self.width / count;
    CGFloat btnH = self.height;
    
    self.textField.frame = CGRectMake(btnW, 4, self.width-3*btnW, btnH-8);
    
    int i = 0;
    
    for (UIButton *btn in self.buttons) {
       // UIButton *btn = self.buttons[i];
        btn.y = 0;
        btn.width = btnW;
        btn.x = i * btnW;
        btn.height = btnH;
        i++;
        
        if (i == 1) {
            i = count-2;
        }
    }
    

}

- (void)setDelegate:(id<HWComposeToolbarDelegate>)delegate {
    _delegate = delegate;
    self.textField.delegate = delegate;
}

- (void)btnClick:(UIButton *)btn
{
    btn.selected = !btn.selected;
    if (_lastSelectedBtn != btn) {
        _lastSelectedBtn.selected = !btn.selected;
    }
    
    self.lastSelectedBtn = btn;
    
    if ([self.delegate respondsToSelector:@selector(composeToolbar:didClickButton:)]) {
//        NSUInteger index = (NSUInteger)(btn.x / btn.width);
        [self.delegate composeToolbar:self didClickButton:btn.tag];
    }
}
@end
