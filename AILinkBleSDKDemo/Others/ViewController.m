//
//  ViewController.m
//  AILinkBleSDKSourceCode
//
//  Created by iot_user on 2020/4/7.
//  Copyright © 2020 IOT. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"
#import "AiLinkSuperViewController.h"
#import "InheritScanViewController.h"
#import "BabyScaleViewController.h"
#import "BloodScanViewController.h"
#import "HeightGuageScanViewController.h"
#import "RemoteControlScanViewController.h"
#import "ForeheadScanViewController.h"
#import "ThermometerScanViewController.h"
#import "WheelMonitorScanViewController.h"
#import "BodyFatScaleScanViewController.h"
#import "BroadcastScaleViewController.h"
#import "EightScaleScanViewController.h"
#import "ToothbrushScanViewController.h"
#import "ELBfsWifiScanVC.h"
#import "OximeterScanViewController.h"
#import "BloodSugarScanViewController.h"
#import "CoffeeScaleScanViewController.h"
#import "FoodThermometerScanViewController.h"
#import "BroadcastNutritionScaleViewController.h"
#import "NutritionScaleScanViewController.h"
#import "AiFreshNutritionScaleScanViewController.h"
#import "FaceMaskScanViewController.h"
#import "SkipScanViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, copy) NSArray *datas;
@property (nonatomic, copy) NSArray *vcsArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.datas = @[
                   @"Parse data yourself(有AILink协议自己解析数据)",
                   @"04_Baby Scale(婴儿秤)",
                   @"05_Sphygmomanometer(血压计)",
                   @"06_Height Guage(身高仪)",
                   @"07_Remote Control(遥控器)",
                   @"08_Forehead thermometer(额温枪)",
                   @"09_Digital thermometer(温度计)",
                   @"10_TPMS(胎压监测)",
                   @"11_Bluetooth BodyfatScale(体脂秤)",
                   @"12_Bluetooth BroadcastScale(广播秤)",
                   @"13_Eight-electrode scale(八电极体脂秤)",
                   @"14_wifi-ble toothbrush(WiFi-ble牙刷)",
                   @"15_wifi-ble bodyfatScale(WiFi-ble体脂秤)",
                   @"16_Bluetooth Oximeter(血氧仪)",
                   @"17_Bluetooth BloodGlucoseMeter(血糖仪)",
                   @"18_CoffeeScale(咖啡秤)",
                   @"19_FoodThermometer(食物温度计)",
                   @"20_BrodcastNutritionScale(广播营养秤)",
                   @"21_NutritionScale(连接营养秤)",
                   @"22_AiFreshNutritionScale(好营养营养秤)",
                   @"23_FaceMask(智能口罩)",
                   @"24_Skip(跳绳)",
    ];
    
    self.vcsArray = @[
        [[InheritScanViewController alloc] init],
        [[BabyScaleViewController alloc] init],
        [[BloodScanViewController alloc] init],
        [[HeightGuageScanViewController alloc] init],
        [[RemoteControlScanViewController alloc] init],
        [[ForeheadScanViewController alloc] init],
        [[ThermometerScanViewController alloc] init],
        [[WheelMonitorScanViewController alloc] init],
        [[BodyFatScaleScanViewController alloc] init],
        [[BroadcastScaleViewController alloc] init],
        [[EightScaleScanViewController alloc] init],
        [[ToothbrushScanViewController alloc] init],
        [[ELBfsWifiScanVC alloc] init],
        [[OximeterScanViewController alloc] init],
        [[BloodSugarScanViewController alloc] init],
        [[CoffeeScaleScanViewController alloc] init],
        [[FoodThermometerScanViewController alloc] init],
        [[BroadcastNutritionScaleViewController alloc] init],
        [[NutritionScaleScanViewController alloc] init],
        [[AiFreshNutritionScaleScanViewController alloc] init],
        [[FaceMaskScanViewController alloc] init],
        [[SkipScanViewController alloc] init]
    ];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.mas_equalTo(0);
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datas.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"cellid";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellId];
    }
    cell.textLabel.text = self.datas[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIViewController *vc = self.vcsArray[indexPath.row];
    vc.title = self.datas[indexPath.row];
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
@end
