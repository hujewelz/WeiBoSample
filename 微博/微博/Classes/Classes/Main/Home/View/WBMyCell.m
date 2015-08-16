//
//  WBMyCell.m
//  微博
//
//  Created by jewelz on 15/8/2.
//  Copyright (c) 2015年 yangtzeu. All rights reserved.
//

#import "WBMyCell.h"

@implementation WBMyCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    //NSLog(@"initWithStyle-------");
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
