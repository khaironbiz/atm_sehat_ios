//
//  BroadcastNutritionScaleViewController.m
//  AILinkBleSDKSourceCode
//
//  Created by LarryZhang on 2021/12/14.
//  Copyright © 2021 IOT. All rights reserved.
//

#import "BroadcastNutritionScaleViewController.h"
#import <AILinkBleSDK/ELBroadcastNutritionFoodScaleBleManager.h>
#import <AILinkBleSDK/ELBroadcastNutritionFoodScaleDataModel.h>
#import "Masonry.h"

@interface BroadcastNutritionScaleViewController () <BroadcastNutritionFoodScaleBleDelegate>
@property(nonatomic, strong) UITextView *textView;
@property(nonatomic, strong) UILabel *statusLbl;

@end

@implementation BroadcastNutritionScaleViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [ELBroadcastNutritionFoodScaleBleManager shareManager].broadcastNutritionFoodScaleBleDelegate = self;
    [[ELBroadcastNutritionFoodScaleBleManager shareManager] startScan];
    [self setupUI];
}


- (void)broadcastNutritionFoodScaleBleDataModel:(ELBroadcastNutritionFoodScaleDataModel *_Nonnull)model {
    static Byte serialNumber = 0xFF;
    if (serialNumber == model.serialNumber) {
        return;
    }
    serialNumber = model.serialNumber;

    NSString *testData = [NSString stringWithFormat:@"MAC:%@ cid:%d vid:%d pid:%d weight:%@ weightPoint:%@ weightUnit:%@ sn:%d",
                                                    model.mac, model.cid - 65535, model.vid, model.pid, @(model.weight), @(model.weightPoint), @(model.weightUnit), model.serialNumber];
    [self addLog:testData];
}

- (void)broadcastNutritionFoodScaleBleUpdateState:(ELBluetoothState)state {
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

    [[ELBroadcastNutritionFoodScaleBleManager shareManager] stopScan];
}
@end
