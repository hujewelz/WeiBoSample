//
//  WBHomeViewController.m
//  微博
//
//  Created by jewelz on 15/4/24.
//  Copyright (c) 2015年 yangtzeu. All rights reserved.
//

#import "WBHomeViewController.h"
#import "WBMyCell.h"

static NSString *identifer = @"Cell";
@interface WBHomeViewController ()

@end

@implementation WBHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(leftAction) image:@"navigationbar_friendsearch" highLighted:@"navigationbar_friendsearch_highlighted"];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(rightAction) image:@"navigationbar_pop" highLighted:@"navigationbar_pop_highlighted"];
    
    [self.tableView registerClass:[WBMyCell class] forCellReuseIdentifier:identifer];
    
    //设置tabbar上的文字
    self.tabBarItem.badgeValue = @"10";
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 15, 0, 15);
    //self.tableView.separatorColor = [UIColor redColor];
    
}

#warning 根据文字计算文字大小
/**
 NSString *str = @"收获地址:浪费了的疯了疯了短发短发了收到了丰富的丰富的方法奋斗奋斗方法";
 UIFont *font = [UIFont systemFontOfSize:14];
 CGSize size = CGSizeMake(320, MAXFLOAT);
 CGRect lablelRect = [str boundingRectWithSize:size options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading) attributes:[NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName] context:nil];
 
 
 2.
 NSString *a = @"";
 NSMutableDictionary *atb = [NSMutableDictionary dictionary];
 atb[NSFontAttributeName] = ;
 CGSize size = [a sizeWithAttributes:atb];
 */


#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Potentially incomplete method implementation.
//    // Return the number of sections.
//    return 0;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WBMyCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer forIndexPath:indexPath];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%zd", indexPath.row];
   // cell.separatorInset = UIEdgeInsetsMake(0, 15, 0, 15);
    
    return cell;
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

// 右边索引的标题数组
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    NSMutableArray *array = [NSMutableArray array];
    for(int section='A';section<='Z';section++)
    {
        [array addObject:[NSString stringWithFormat:@"%c",section]];
    }
    return array;
}
// 自定义索引与数组的对应关系
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    return (index+1==26)?0:(index+1);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    //    scrollView == self.tableView == self.view
    // 如果tableView还没有数据，就直接返回
    //if ( self.tableView.tableFooterView.isHidden == NO) return;
    
    CGFloat offsetY = scrollView.contentOffset.y;
    
    // 当最后一个cell完全显示在眼前时，contentOffset的y值
    CGFloat judgeOffsetY = scrollView.contentSize.height + scrollView.contentInset.bottom - scrollView.height - self.tableView.tableFooterView.height;
    if (offsetY >= judgeOffsetY+self.tableView.rowHeight) { // 最后一个cell完全进入视野范围内
        
        NSLog(@"scroll to button");
        // 显示footer
        self.tableView.tableFooterView.hidden = NO;
        
        // 加载更多的微博数据
        //[self loadMoreStatus];
    }
    
    /*
     contentInset：除具体内容以外的边框尺寸
     contentSize: 里面的具体内容（header、cell、footer），除掉contentInset以外的尺寸
     contentOffset:
     1.它可以用来判断scrollView滚动到什么位置
     2.指scrollView的内容超出了scrollView顶部的距离（除掉contentInset以外的尺寸）
     */

    
}

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
