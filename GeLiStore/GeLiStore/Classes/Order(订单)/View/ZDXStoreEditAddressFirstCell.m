//
//  ZDXStoreEditAddressFirstCell.m
//  GeLiStore
//
//  Created by user99 on 2017/11/29.
//  Copyright © 2017年 user99. All rights reserved.
//

#import "ZDXStoreEditAddressFirstCell.h"
#import "UIColor+ColorChange.h"
@interface ZDXStoreEditAddressFirstCell ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *conginnerTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumTextField;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

@end

@implementation ZDXStoreEditAddressFirstCell

- (void)awakeFromNib {
    [super awakeFromNib];

    self.conginnerTextField.delegate = self;
    self.phoneNumTextField.delegate = self;
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.addressLabel.textColor = [UIColor colorWithHexString:@"#888888"];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.conginnerTextField endEditing:YES];
    [self.phoneNumTextField endEditing:YES];
    
    return YES;
}

@end
