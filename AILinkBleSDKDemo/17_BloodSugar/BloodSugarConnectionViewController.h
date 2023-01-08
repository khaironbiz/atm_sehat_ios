//
//  BloodSugarConnectionViewController.h
//  AILinkBleSDKSourceCode
//
//  Created by cliCk on 2021/1/28.
//  Copyright © 2021 IOT. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ELPeripheralModel;

NS_ASSUME_NONNULL_BEGIN

@interface BloodSugarConnectionViewController : UIViewController

@property (nonatomic, strong) ELPeripheralModel *p;

@end

NS_ASSUME_NONNULL_END
