//
//  ZDXStoreFiltratePushViewTypeCell.h
//  GeLiStore
//
//  Created by user99 on 2017/11/3.
//  Copyright © 2017年 user99. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZDXStoreFiltratePushViewTypeCell : UITableViewCell

+(instancetype)initWithTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

@property (assign, nonatomic) CGFloat cellH;
@end
