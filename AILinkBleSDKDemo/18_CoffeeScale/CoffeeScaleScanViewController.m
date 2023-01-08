//
//  CoffeeScaleScanViewController.m
//  AILinkBleSDKSourceCode
//
//  Created by LarryZhang on 2021/12/13.
//  Copyright © 2021 IOT. All rights reserved.
//

#import "CoffeeScaleScanViewController.h"
#import <AILinkBleSDK/ELCoffeeScaleBleManager.h>
#import "Masonry.h"
#import "CoffeeScaleConnectionViewController.h"

@interface CoffeeScaleScanViewController () <UITableViewDelegate, UITableViewDataSource, CoffeeScaleBleDelegate>
@property(nonatomic, strong) UITableView *tableView;

@property(nonatomic, strong) NSArray<ELPeripheralModel *> *devices;

@end

@implementation CoffeeScaleScanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.mas_equalTo(0);
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [[ELCoffeeScaleBleManager shareManager] startScan];
    [ELCoffeeScaleBleManager shareManager].coffeeScaleDelegate = self;
}

- (void)viewWillDisappear:(BOOL)animated {
    [[ELCoffeeScaleBleManager shareManager] stopScan];
}

#pragma mark - CoffeeScaleBleDelegate

- (void)deviceBleReceiveState:(ELBluetoothState)state {
    NSLog(@"deviceBleReceiveState = %ld", state);
}

- (void)deviceBleReceiveDevices:(NSArray<ELPeripheralModel *> *)devices {
    self.devices = devices;
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.devices.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"cellid";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellId];
    }
    ELPeripheralModel *p = self.devices[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"Name:%@---Mac:%@\nCID:%ld---VID:%ld---PID:%ld", p.peripheral.name, p.macAddress, p.deviceType, p.vendorID, p.productID];
    cell.textLabel.numberOfLines = 2;
    cell.textLabel.textColor = [UIColor blackColor];

    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ELPeripheralModel *p = self.devices[indexPath.row];
    CoffeeScaleConnectionViewController *vc = [[CoffeeScaleConnectionViewController alloc] init];
    vc.p = p;
    [self.navigationController pushViewController:vc animated:YES];
}

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

@end
