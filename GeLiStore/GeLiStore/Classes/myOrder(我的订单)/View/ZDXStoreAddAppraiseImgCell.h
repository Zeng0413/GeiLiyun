//
//  ZDXStoreAddAppraiseImgCell.h
//  GeLiStore
//
//  Created by user99 on 2018/1/8.
//  Copyright © 2018年 user99. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZDXStoreAddAppraiseImgCell : UITableViewCell

+(instancetype)cellWithAppraiseImgTableView:(UITableView *)tableView;

@property (assign, nonatomic) CGFloat cellH;

@property (strong, nonatomic, readonly) NSMutableArray *photos;

-(void)addPhoto:(UIImage *)photo;

@end
