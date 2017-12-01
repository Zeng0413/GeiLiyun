//
//  ZDXStoreEditAddressFirstCell.h
//  GeLiStore
//
//  Created by user99 on 2017/11/29.
//  Copyright © 2017年 user99. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZDXStoreEditAddressFirstCellDelegate <NSObject>

-(void)chooseAddress;

@end

@interface ZDXStoreEditAddressFirstCell : UITableViewCell

@property (weak, nonatomic) id<ZDXStoreEditAddressFirstCellDelegate> delegate;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UITextField *conginnerTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumTextField;
@end
