//
//  WBProfileViewController.m
//  微博
//
//  Created by jewelz on 15/4/25.
//  Copyright (c) 2015年 yangtzeu. All rights reserved.
//

#import "WBProfileViewController.h"
static NSString *identifer = @"Cell";

@interface WBProfileViewController ()

@end

@implementation WBProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"设置" style:UIBarButtonItemStylePlain target:self action:@selector(setting)];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:identifer];
}

- (void)setting {
    
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Potentially incomplete method implementation.
//    // Return the number of sections.
//    return 0;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer forIndexPath:indexPath];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return 200;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIScrollView *scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 200)];
    scrollview.contentSize = CGSizeMake(self.view.width *3, 0);
    scrollview.backgroundColor = [UIColor lightGrayColor];
    return scrollview;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {

    NSLog(@"scrollViewDidEndDecelerating");
}


@end
