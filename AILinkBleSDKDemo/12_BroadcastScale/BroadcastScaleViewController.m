//
//  BroadcastScaleViewController.m
//  AILinkBleSDKSourceCode
//
//  Created by iot_user on 2020/9/12.
//  Copyright © 2020 IOT. All rights reserved.
//

#import "BroadcastScaleViewController.h"
#import <AILinkBleSDK/ELBroadcastScaleBleManager.h>
#import <AILinkBleSDK/AlgorithmSDK.h>
#import <AILinkBleSDK/ELBodyFatScaleBleUserModel.h>
#import <AILinkBleSDK/ELWeightAlgorithmusModel.h>
#import "Masonry.h"


@interface BroadcastScaleViewController () <BroadcastScaleBleDelegate>
@property(nonatomic, strong) UITextView *textView;
@property(nonatomic, strong) UILabel *statusLbl;

@property(nonatomic, strong) ELBroadcastScaleDataModel *dataModel;

@end

@implementation BroadcastScaleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [ELBroadcastScaleBleManager shareManager].broadcastScaleBleDelegate = self;
    [[ELBroadcastScaleBleManager shareManager] startScan];
    [self setupUI];
}


- (void)broadcastScaleBleDataModel:(ELBroadcastScaleDataModel *)model {
    switch (model.testStatus) {
        case BroadcastScaleTestStatusWeightTesting: {
            self.statusLbl.text = @"Weight testing";
        }
            break;
        case BroadcastScaleTestStatusADCTesting: {
            self.statusLbl.text = @"Impedance testing";
            break;
        }
        case BroadcastScaleTestStatusADCTestSuccess: {
            self.statusLbl.text = @"Impedance test success";
            break;
        }
        case BroadcastScaleTestStatusADCTestFailed: {
            self.statusLbl.text = @"Impedance test failed";
            break;
        }
        case BroadcastScaleTestStatusTestEnd: {
            self.statusLbl.text = @"Test end";
            ELBodyFatScaleBleUserModel *user = self.getOneUser;
            NSString *weightKg = [ELWeightAlgorithmusModel getKgWithWeightShowStr:model.weight weightUnit:model.weightUnit weightPoint:model.weightPoint];
            AlgorithmModel *agModel = [AlgorithmSDK getBodyfatWithWeight:weightKg.floatValue adc:(int) model.adc sex:user.sex age:(int) user.age height:(int) user.height];
            NSLog(@"agModel:%@", agModel);

            break;
        }
    }

    NSString *testData = [NSString stringWithFormat:@"MAC:%@\ncid = %d--vid=%d--pid=%d\nWeight = %@%@\nADC = %d", model.mac, model.cid - 65535, model.vid, model.pid, model.weight, AiLinkBleWeightUnitDic[@(model.weightUnit)], model.adc];
    [self addLog:testData];
}

- (void)broadcastScaleBleUpdateState:(ELBluetoothState)state {
    if (state == ELBluetoothStateAvailable) {
        self.statusLbl.text = @"Connecting";
    } else if (state == ELBluetoothStateUnavailable) {
        self.statusLbl.text = @"Bluetooth is disconnected";
    }

}

- (void)addLog:(NSString *)log {
    self.textView.text = [NSString stringWithFormat:@"%@\n%@", log, self.textView.text];
}

- (void)setupUI {
    self.textView = [[UITextView alloc] init];
    self.textView.backgroundColor = [UIColor blackColor];
    self.textView.text = @"Log";
    self.textView.textColor = [UIColor redColor];
    [self.view addSubview:self.textView];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.bottom.mas_equalTo(-10);
        make.height.equalTo(self.view).multipliedBy(0.7);
    }];

    //
    self.statusLbl = [[UILabel alloc] init];
    self.statusLbl.text = @"Connecting";
    self.statusLbl.adjustsFontSizeToFitWidth = YES;
    self.statusLbl.font = [UIFont boldSystemFontOfSize:30];
    self.statusLbl.textColor = [UIColor redColor];
    self.statusLbl.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.statusLbl];
    [self.statusLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(40);
        make.left.right.equalTo(self.textView);
        make.bottom.equalTo(self.textView.mas_top).mas_offset(-20);
    }];
}

- (void)dealloc {

    [[ELBroadcastScaleBleManager shareManager] stopScan];
}

- (ELBodyFatScaleBleUserModel *)getOneUser {
    ELBodyFatScaleBleUserModel *user = [[ELBodyFatScaleBleUserModel alloc] init];
    user.createTime = [[NSDate date] timeIntervalSince1970];
    user.usrID = 0;
    user.role = BodyFatScaleRole_Ordinary;
    user.sex = ELBluetoothUserSex_Woman;
    user.age = 26;
    user.height = 170;
    user.weight = 600;
    user.adc = 560;
    return user;
}

@end
