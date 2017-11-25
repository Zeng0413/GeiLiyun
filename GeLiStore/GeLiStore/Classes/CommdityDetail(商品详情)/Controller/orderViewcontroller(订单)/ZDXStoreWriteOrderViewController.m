//
//  ZDXStoreWriteOrderViewController.m
//  GeLiStore
//
//  Created by user99 on 2017/11/24.
//  Copyright © 2017年 user99. All rights reserved.
//

#import "ZDXStoreWriteOrderViewController.h"
#import "ZDXStoreOrderAddressDefaultCell.h"
#import "ZDXStoreOrderGoodsShowCell.h"

static NSString *orderAddressDefaultCellID = @"orderAddressDefaultCell";
static NSString *orderGoodsShowCellID = @"OrderGoodsShowCell";
@interface ZDXStoreWriteOrderViewController ()

@end

@implementation ZDXStoreWriteOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"填写订单";
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:@"ZDXStoreOrderAddressDefaultCell" bundle:nil] forCellReuseIdentifier:orderAddressDefaultCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"ZDXStoreOrderGoodsShowCell" bundle:nil] forCellReuseIdentifier:orderGoodsShowCellID];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 1) {
        return 2;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        ZDXStoreOrderAddressDefaultCell *cell = [tableView dequeueReusableCellWithIdentifier:orderAddressDefaultCellID];
        return cell;
    }
    if (indexPath.section == 1) {
        ZDXStoreOrderGoodsShowCell *cell = [tableView dequeueReusableCellWithIdentifier:orderGoodsShowCellID];
        return cell;
    }
    
    static NSString *indentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:indentifier];
    }
    cell.textLabel.text = @"zdx";
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 59;
    }else if (indexPath.section == 1){
        return 107;
    }
    return 50;
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
