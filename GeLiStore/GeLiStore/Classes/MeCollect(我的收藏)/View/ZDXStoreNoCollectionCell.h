//
//  ZDXStoreNoCollectionCell.h
//  GeLiStore
//
//  Created by user99 on 2017/12/11.
//  Copyright © 2017年 user99. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZDXStoreNoCollectionCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *Img;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ImgH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ImgW;
@end
