//
//  ToothbrushConnectionViewController.h
//  AILinkBleSDKSourceCode
//
//  Created by iot_user on 2020/9/29.
//  Copyright © 2020 IOT. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ELPeripheralModel;
NS_ASSUME_NONNULL_BEGIN

@interface ToothbrushConnectionViewController : UIViewController
@property (nonatomic, strong) ELPeripheralModel *p;
@end

NS_ASSUME_NONNULL_END
