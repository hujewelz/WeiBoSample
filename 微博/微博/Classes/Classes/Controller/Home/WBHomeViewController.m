//
//  WBHomeViewController.m
//  微博
//
//  Created by jewelz on 15/4/24.
//  Copyright (c) 2015年 yangtzeu. All rights reserved.
//

#import "WBHomeViewController.h"
static NSString *identifer = @"Cell";
@interface WBHomeViewController ()

@end

@implementation WBHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(leftAction) image:@"navigationbar_friendsearch" highLighted:@"navigationbar_friendsearch_highlighted"];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(rightAction) image:@"navigationbar_pop" highLighted:@"navigationbar_pop_highlighted"];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:identifer];
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

#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here, for example:
    // Create the next view controller.
    UIViewController *detailViewController = [[UIViewController alloc] init];
    detailViewController.view.backgroundColor = [UIColor redColor];
    [self.navigationController pushViewController:detailViewController animated:YES];
}

- (void)leftAction {
    NSLog(@"left.....");
}

- (void)rightAction {
    NSLog(@"right.....");
}

@end
