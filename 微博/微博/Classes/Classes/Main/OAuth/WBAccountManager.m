//
//  WBAccountManager.m
//  微博
//
//  Created by jewelz on 15/8/1.
//  Copyright (c) 2015年 yangtzeu. All rights reserved.
//

#define ACCOUNT_PATH [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]stringByAppendingPathComponent:@"account.data"]

#import "WBAccountManager.h"
#import "WBAccount.h"

@implementation WBAccountManager


+ (void)saveAccount:(WBAccount *)account {
    [NSKeyedArchiver archiveRootObject:account toFile:ACCOUNT_PATH];
}

+ (WBAccount *)account {
    WBAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:ACCOUNT_PATH];
    //account.expires_in
    NSDate *tokenTime = account.token_date;
    NSDate *expressTime = [tokenTime dateByAddingTimeInterval:[account.expires_in integerValue]];
    
    
    if ([[NSDate date] compare:expressTime] != NSOrderedAscending) {
        return nil;
    }
    
    return account;
}

@end
