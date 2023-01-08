//
//  ELBfsWifiConnectTableViewCell.h
//  AILinkBleSDKSourceCode
//
//  Created by cliCk on 2021/4/28.
//  Copyright © 2021 IOT. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ELBfsWifiConnectTableViewCell : UITableViewCell

@property (nonatomic, copy) NSString *wifiName;

/** 是否连接 */
@property (nonatomic, assign) BOOL isLink;

@end

NS_ASSUME_NONNULL_END
