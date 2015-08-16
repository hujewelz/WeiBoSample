//
//  WBCount.m
//  微博
//
//  Created by jewelz on 15/8/1.
//  Copyright (c) 2015年 yangtzeu. All rights reserved.
//

#import "WBAccount.h"

@implementation WBAccount

+ (instancetype)accountWithDict:(NSDictionary *)dict {
    WBAccount *account = [[WBAccount alloc] init];
    account.access_token = dict[@"access_token"];
    account.expires_in = dict[@"expires_in"];
    account.uid = dict[@"uid"];
    account.token_date = [NSDate date];
    
    return account;
}

// 对象归档
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.access_token forKey:@"access_token"];
    [aCoder encodeObject:self.expires_in forKey:@"expires_in"];
    [aCoder encodeObject:self.uid forKey:@"uid"];
    [aCoder encodeObject:self.token_date forKey:@"token_date"];
}

// 对象档
- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        self.access_token = [aDecoder decodeObjectForKey:@"access_token"];
        self.expires_in = [aDecoder decodeObjectForKey:@"expires_in"];
        self.uid = [aDecoder decodeObjectForKey:@"uid"];
        self.token_date = [aDecoder decodeObjectForKey:@"token_date"];
    }
    return self;
}

@end
