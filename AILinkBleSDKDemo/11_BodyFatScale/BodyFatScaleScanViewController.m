//
//  BodyFatScaleScanViewController.m
//  AILinkBleSDKSourceCode
//
//  Created by iot_user on 2020/4/8.
//  Copyright © 2020 IOT. All rights reserved.
//

#import "BodyFatScaleScanViewController.h"
#import "Masonry.h"
#import <AILinkBleSDK/ELBodyFatScaleBleManager.h>
#import "BodyFatScaleConnectViewController.h"

@interface BodyFatScaleScanViewController ()<UITableViewDelegate,UITableViewDataSource,ELBodyFatScaleBleDelegate>
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray<ELPeripheralModel *> *devices;

@end

@implementation BodyFatScaleScanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
//    self.title = @"Devices";
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.mas_equalTo(0);
    }];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[ELBodyFatScaleBleManager shareManager] startScan];
    [ELBodyFatScaleBleManager shareManager].bodyFatScaleDelegate = self;
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
}
#pragma mark ============ ELBluetoothManagerDelegate ==============
-(void)bodyFatScaleManagerUpdateState:(ELBluetoothState)state{
    NSLog(@"bluetoothManagerUpdateBleState = %ld",state);
}
-(void)bodyFatScaleManagerScanDevices:(NSArray<ELPeripheralModel *> *)scaleDevices{
    self.devices = scaleDevices;
    [self.tableView reloadData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.devices.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"cellid";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellId];
    }
    ELPeripheralModel *p = self.devices[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"Name:%@---Mac:%@\nCID:%ld---VID:%ld---PID:%ld",p.deviceName,p.macAddress,p.deviceType,p.vendorID,p.productID];
    cell.textLabel.numberOfLines = 2;
    cell.textLabel.textColor = [UIColor blackColor];
    
    return cell;

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ELPeripheralModel *p = self.devices[indexPath.row];
    BodyFatScaleConnectViewController *vc = [[BodyFatScaleConnectViewController alloc] init];
    vc.p = p;
    [self.navigationController pushViewController:vc animated:YES];
}
-(UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}
-(void)dealloc{
    [[ELBodyFatScaleBleManager shareManager] stopScan];
}
@end
