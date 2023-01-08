//
//  ELAirDetectorBleParser.h
//  AILinkBleSDK
//
//  Created by LarryZhang on 2022/12/12.
//

#import <Foundation/Foundation.h>
#import "ELSDKHeader.h"
#import "ELAirDetectorBleHeader.h"
#import "ELAirDetectorBleFunctionModel.h"
#import "ELAirDetectorBleStatusModel.h"
#import "ELAirDetectorBleSettingModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^didUpdateDataBlock)(ELAirDetectorBleCMD cmd, ELAirDetectorTLVType type);

@interface ELAirDetectorBleParser : NSObject

@property (nonatomic, strong) ELAirDetectorBleFunctionModel *functionModel;

@property (nonatomic, strong) ELAirDetectorBleStatusModel *statusModel;

@property (nonatomic, strong) ELAirDetectorBleSettingModel *settingModel;


- (void)parseData:(NSData *)payload callback:(didUpdateDataBlock)calllback;

@end

NS_ASSUME_NONNULL_END
