//
//  LikeUserLIstTVC.m
//  GOTour
//
//  Created by 磊 田 on 15/10/14.
//  Copyright © 2015年 tianLei. All rights reserved.
//

#import "LikeUserLIstTVC.h"
#import "ReferrerModel.h"
#import "LikeUserListCell.h"
#define kUserListUrl @"http://appsrv.flyxer.com/api/digest/recomm/"

@interface LikeUserLIstTVC ()

@property (nonatomic, strong) NSMutableArray *likers;
//@property (nonatomic, strong) NSMutableArray *likers;


@end

@implementation LikeUserLIstTVC
- (void)dealloc
{
    NSLog(@"被销毁");

}
- (void)viewDidLoad {
    self.navigationController.navigationBar.hidden = NO;
    [super viewDidLoad];
  //  请求数据
    [self loadData];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    http://appsrv.flyxer.com/api/digest/recomm/2971/like?page=1
    
}

- (void)loadData
{
    NSString *urlStr = [kUserListUrl stringByAppendingFormat:@"%@/like",_ID];
    NSDictionary *dict = @{
                           @"page":@"1"
                           };
    _likers = [NSMutableArray array];
    [TLHTTPTool requestDataWithUrl:urlStr parameters:dict success:^(id responseObject) {
        NSArray *array = responseObject[@"liker_user"];
        
        for (NSDictionary *dict in array) {
            
            ReferrerModel *model = [[ReferrerModel alloc] init];
            model = [ReferrerModel objectWithKeyValues:dict];
            [_likers addObject:model];
            
        }

        [self.tableView reloadData];
    } fail:^(id error) {
        
        NSLog(@"请求失败");
    }];

}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _likers.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LikeUserListCell *cell = [LikeUserListCell createTableView:tableView];
    cell.referrer = _likers[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    

    return 50 + kMargin;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    [[SDImageCache sharedImageCache] clearMemory];
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
