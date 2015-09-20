//
//  HWComposeToolbar.h
//  黑马微博2期
//
//  Created by apple on 14-10-20.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    HWComposeToolbarButtonTypeCamera, // 拍照
    HWComposeToolbarButtonTypePicture, // 相册
    HWComposeToolbarButtonTypeMention, // @
    HWComposeToolbarButtonTypeTrend, // #
    HWComposeToolbarButtonTypeEmotion // 表情
} HWComposeToolbarButtonType;

@class HWComposeToolbar;

@protocol HWComposeToolbarDelegate <UITextFieldDelegate>
@optional
- (void)composeToolbar:(HWComposeToolbar *)toolbar didClickButton:(HWComposeToolbarButtonType)buttonType;
@end

@interface HWComposeToolbar : UIView
@property (nonatomic, weak) id<HWComposeToolbarDelegate> delegate;
@property (nonatomic) BOOL showKeyboardState;

//- (void)buttonWithTarget:(id)target action:(SEL)action;

@end
