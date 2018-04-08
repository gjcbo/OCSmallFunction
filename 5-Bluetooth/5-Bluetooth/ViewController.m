//
//  ViewController.m
//  5-Bluetooth
//
//  Created by RaoBo on 2018/4/8.
//  Copyright © 2018年 关键词. All rights reserved.
//

#import "ViewController.h"
#import <CoreBluetooth/CoreBluetooth.h>

// 特征值. 这个需要和公司的硬件人员沟通，不同的设备不一样的
#define kServiceUUID @"FFF0"
#define kCharacteristicUUID @"FFF6"

@interface ViewController ()<CBCentralManagerDelegate,CBPeripheralDelegate>

/**中心,发起连接的设备*/
@property (nonatomic, strong) CBCentralManager *centralManager;
/**外设:被连接的设备*/
@property(nonatomic, strong) CBPeripheral *peripheral;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // 创建中心管理者对象 If <i>nil</i>, the main queue will be used.
    CBCentralManager *manager = [[CBCentralManager alloc] initWithDelegate:self queue:nil]; // 如果队列为nil 默认为主队列。
    self.centralManager = manager;
}

#pragma mark - CBCentralManagerDelegate
// 必须实现
- (void)centralManagerDidUpdateState:(CBCentralManager *)central
{
    switch (central.state) {
        case CBManagerStatePoweredOn:
            NSLog(@"蓝牙已经开启");
            break;
        case CBManagerStateResetting:
            NSLog(@"蓝牙重启中");
            break;
        case CBManagerStateUnsupported:
            NSLog(@"蓝牙状态不支持");
            break;
        case CBManagerStateUnauthorized:
            NSLog(@"蓝牙位授权");
            break;
        case CBManagerStateUnknown:
            NSLog(@"蓝牙未知");
            break;
        case CBManagerStatePoweredOff:
            NSLog(@"蓝牙已关闭");
            break;
        default:
            break;
    }
}

//2.扫描到设备会进入的方法
- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary<NSString *,id> *)advertisementData RSSI:(NSNumber *)RSSI
{
    NSLog(@"peripheral.name:%@ - RSSI:%@",peripheral.name,RSSI);
    
    // RSSI 信号强度 越大信号越强 (eg:-40 > -58)
    // 这里根据需要连接你要连接的设备，比如你要连接KISSLOCK开头的设别 可以利用 peripheral.name 进行判断 进而限制
    if ([RSSI floatValue] > -77) {
        
        self.peripheral = peripheral;
        
        // 连接蓝牙设备
        [self.centralManager connectPeripheral:peripheral options:nil];
    }
}

// 3.蓝牙连接失败的回调
- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error
{
    NSLog(@"连接蓝牙失败:%@ 原因:%@",peripheral.name,error);
}
// 4.蓝牙连接成功的回调
- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral
{
    NSLog(@"连接蓝牙成功:%@",peripheral.name);
    
    // 设置外设代理
    peripheral.delegate = self;
    self.peripheral = peripheral;
    
    // 搜索服务 service If <i>nil</i>, all services will be discovered.    nil表示搜索所有服务
    // 如果搜索到服务 会走外设(peripheral)的 扫描到服务代理方法
    [self.peripheral discoverServices:nil];
}

// 5.断开连接
- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error
{
    NSLog(@"断开连接:%@",peripheral.name);
}


#pragma mark - CBPeripheralDelegate
// 1.扫描服务
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error
{
    // 遍历peripheral的服务
    for (CBService *service in peripheral.services) {
        if ([[service.UUID UUIDString] isEqualToString:kServiceUUID]) {
            NSLog(@"service.UUID一样,立即扫描characteristics");
            [self.peripheral discoverCharacteristics:nil forService:service]; // 扫描kServiceUUID服务对应的特征值：characteristics  . nil代表扫描所有的特征值
        }
    }
}

// 扫描到service对应的characteristic
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error
{
    NSLog(@"扫描到特征值:%@ UUID:%@",peripheral.name,service.UUID);
    
    for (CBCharacteristic *character in service.characteristics) {
        
        // 根据特征值的UUID判断是否要监听特征值
        if ([[character.UUID UUIDString] isEqualToString:kCharacteristicUUID]) {
            
            [self.peripheral setNotifyValue:YES forCharacteristic:character]; //  监听特征值，否则的话 didUpdateValueForCharacteristic 方法不会被调用
            
            // 还可以做其他操作：比如写数据。
//            peripheral writeValue:sendData forCharacteristic:characteristic type:CBCharacteristicWriteWithoutResponse];
            
        }
    }
}

/// 重要!!!! 更新特征值
- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    // 与蓝牙的数据交互都在这里进行。
    // 在这做操作.
}
#pragma mark - Private
/** 监测蓝牙是否打开*/
- (BOOL)isBlueToothIsOpen
{
    //        CBCentralManagerStatePoweredOn // NS_DEPRECATED(10_7, 10_13, 5_0, 10_0, "Use CBManagerState instead"); 弃用了
    
    if (self.centralManager.state == CBManagerStatePoweredOn) {

        return YES;
    }
    return NO;
}

/** 申请打开蓝牙权限弹框*/
- (void)openBlueToothAlert
{
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"提示" message:@"打开蓝牙才可以使用" preferredStyle:(UIAlertControllerStyleAlert)];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:nil];
    
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        NSURL *openBleUrl = [NSURL URLWithString:@"App-prefs:root=Bluetooth"];
        UIApplication *app = [UIApplication sharedApplication];
        if ([app canOpenURL:openBleUrl]) {
            [app openURL:openBleUrl options:@{} completionHandler:nil];
        }
    }];
    
    [alertC addAction:cancelAction];
    [alertC addAction:sureAction];
    
    [self presentViewController:alertC animated:YES completion:nil];
}

#pragma mark -


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
