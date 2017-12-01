//
//  ZDXStoreConsignnerInfoCell.m
//  GeLiStore
//
//  Created by user99 on 2017/12/1.
//  Copyright © 2017年 user99. All rights reserved.
//

#import "ZDXStoreConsignnerInfoCell.h"
#import "ZDXComnous.h"


#define border 10

@interface ZDXStoreConsignnerInfoCell ()
@property (weak, nonatomic) UILabel *name; // 收货人名
@property (weak, nonatomic) UILabel *phoneNum; // 电话号码
@property (weak, nonatomic) UIView *lineView; // 下划横线
@property (weak, nonatomic) UILabel *detailAddress; // 详细地址
@property (weak, nonatomic) UIButton *defaultAddressBtn; // 默认地址按钮
@property (weak, nonatomic) UIButton *editBtn; // 编辑按钮
@property (weak, nonatomic) UIButton *cancelBtn; // 删除按钮

@property (weak, nonatomic) UIView *bottomView;

@end

@implementation ZDXStoreConsignnerInfoCell

+(instancetype)initWithConsigneeTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *indentifier = @"cell";
    ZDXStoreConsignnerInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    if (!cell) {
        cell = [[ZDXStoreConsignnerInfoCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:indentifier];
    }
    return cell;
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupUI];
    }
    return self;
}

-(void)setupUI{
    
    // 收货人名
    UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(border, 20, 100, 20)];
    name.font = ZDXFont(15);
    name.textColor = blackLabelColor;
    [self.contentView addSubview:name];
    self.name = name;
    
    // 电话号码
    UILabel *phoneNum = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - border - 150, 20, 150, 20)];
    phoneNum.font = ZDXFont(15);
    phoneNum.textColor = blackLabelColor;
    phoneNum.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:phoneNum];
    self.phoneNum = phoneNum;
    
    // 详细地址
    UILabel *detailAddress = [[UILabel alloc] init];
    detailAddress.x = border;
    detailAddress.y = CGRectGetMaxY(self.name.frame) + 20;
    detailAddress.font = ZDXFont(14);
    detailAddress.textColor = blackLabelColor;
    detailAddress.numberOfLines = 0;
    [self.contentView addSubview:detailAddress];
    self.detailAddress = detailAddress;
    
    // 下划横线
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = colorWithString(@"#f4f4f4");
    [self.contentView addSubview:lineView];
    self.lineView = lineView;
    
    // 默认地址按钮
    UIButton *defaultAddressBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [defaultAddressBtn setImage:[UIImage imageNamed:@"默认地址选框"] forState:UIControlStateNormal];
    [defaultAddressBtn setImage:[UIImage imageNamed:@"选框"] forState:UIControlStateSelected];
    defaultAddressBtn.titleLabel.font = ZDXFont(14);
    [defaultAddressBtn setTitle:@"默认地址" forState:UIControlStateNormal];
    [defaultAddressBtn setTitleColor:blackLabelColor forState:UIControlStateNormal];
    defaultAddressBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
    
    defaultAddressBtn.x = border;
    defaultAddressBtn.width = defaultAddressBtn.imageView.width + 10 + [defaultAddressBtn.titleLabel.text sizeWithFont:ZDXFont(14)].width + 10;
    defaultAddressBtn.height = 20;
    
    [defaultAddressBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.contentView addSubview:defaultAddressBtn];
    self.defaultAddressBtn = defaultAddressBtn;
    
    // 删除按钮
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelBtn setTitleColor:blackLabelColor forState:UIControlStateNormal];
    cancelBtn.titleLabel.font = ZDXFont(14);
    
    [cancelBtn setImage:[UIImage imageNamed:@"删除"] forState:UIControlStateNormal];
    [cancelBtn setTitle:@"删除" forState:UIControlStateNormal];
    cancelBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 9);
    
    cancelBtn.width = cancelBtn.imageView.width + 10 + [cancelBtn.titleLabel.text sizeWithFont:ZDXFont(14)].width + 10;
    cancelBtn.x = SCREEN_WIDTH - border - cancelBtn.width;
    cancelBtn.height = 20;
    
    [cancelBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:cancelBtn];
    self.cancelBtn = cancelBtn;
    
    // 编辑按钮
    UIButton *editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [editBtn setTitleColor:blackLabelColor forState:UIControlStateNormal];
    editBtn.titleLabel.font = ZDXFont(14);

    [editBtn setImage:[UIImage imageNamed:@"编辑"] forState:UIControlStateNormal];
    [editBtn setTitle:@"编辑" forState:UIControlStateNormal];
    editBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 9);
    
    editBtn.width = editBtn.imageView.width + 10 + [editBtn.titleLabel.text sizeWithFont:ZDXFont(14)].width + 10;
    editBtn.x = SCREEN_WIDTH - border * 2 - editBtn.width - self.cancelBtn.width;
    editBtn.height = 20;
    
    [editBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:editBtn];
    self.editBtn = editBtn;

    
    UIView *bottomView = [[UIView alloc] init];
    bottomView.x = 0;
    bottomView.width = SCREEN_WIDTH;
    bottomView.height = 9;
    bottomView.backgroundColor = colorWithString(@"#f4f4f4");
    [self.contentView addSubview:bottomView];
    self.bottomView = bottomView;
}

-(void)btnClick:(UIButton *)button{
   
    if ([self.delegate respondsToSelector:@selector(consigneeInfoOperationType:consigneeInfoModel:)]) {
        [self.delegate consigneeInfoOperationType:button.titleLabel.text consigneeInfoModel:self.model];
    }
    
}

-(void)setModel:(ZDXStoreConsigneeInfoModel *)model{
    _model = model;
    
    self.name.text = model.userName;
    self.phoneNum.text = model.userPhone;
    
    CGSize addressSize = [model.userAddress sizeWithFont:ZDXFont(14) maxW:SCREEN_WIDTH - border * 2];
    self.detailAddress.size = addressSize;
    self.detailAddress.text = model.userAddress;
    
    self.lineView.frame = CGRectMake(0, CGRectGetMaxY(self.detailAddress.frame) + 9, SCREEN_WIDTH, 2);
    
    CGFloat btnY = CGRectGetMaxY(self.lineView.frame) + 10;
    if (model.isDefault == 1) {
        self.defaultAddressBtn.selected = YES;
    }else{
        self.defaultAddressBtn.selected = NO;
    }
    
    self.defaultAddressBtn.y = btnY;
    
    self.cancelBtn.y = btnY;
    
    self.editBtn.y = btnY;
    
    self.bottomView.y = CGRectGetMaxY(self.defaultAddressBtn.frame) + 21;
    
    self.cellH = CGRectGetMaxY(self.bottomView.frame);
    
    
}


@end
