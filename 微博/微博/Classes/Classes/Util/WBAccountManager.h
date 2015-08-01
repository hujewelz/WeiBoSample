//
//  WBAccountManager.h
//  微博
//
//  Created by jewelz on 15/8/1.
//  Copyright (c) 2015年 yangtzeu. All rights reserved.
//

#import <Foundation/Foundation.h>
@class WBAccount;
@interface WBAccountManager : NSObject

+ (void)saveAccount:(WBAccount *)account;
+ (WBAccount *)account;

@end
