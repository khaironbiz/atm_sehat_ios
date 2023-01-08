//
//  ELBfsWifiConnectTableViewCell.m
//  AILinkBleSDKSourceCode
//
//  Created by cliCk on 2021/4/28.
//  Copyright © 2021 IOT. All rights reserved.
//

#import "ELBfsWifiConnectTableViewCell.h"
#import "Masonry.h"

@interface ELBfsWifiConnectTableViewCell ()

@property (nonatomic, strong) UILabel *nameLabel, *linkLabel;

@end

@implementation ELBfsWifiConnectTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.nameLabel = [[UILabel alloc] init];
        self.nameLabel.textColor = [UIColor blackColor];
        [self.contentView addSubview:self.nameLabel];
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(20);
            make.centerY.equalTo(self.contentView.mas_centerY);
        }];
        
        self.linkLabel = [[UILabel alloc] init];
        self.linkLabel.textColor = [UIColor blueColor];
        [self.contentView addSubview:self.linkLabel];
        [self.linkLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.offset(-20);
            make.centerY.equalTo(self.contentView.mas_centerY);
        }];
        
    }
    return self;
}

#pragma mark - setter

- (void)setWifiName:(NSString *)wifiName {
    self.nameLabel.text = wifiName;
}

- (void)setIsLink:(BOOL)isLink {
    if (isLink) {
        self.linkLabel.text = @"Connected";
    } else {
        self.linkLabel.text = @"";
    }
}

@end
