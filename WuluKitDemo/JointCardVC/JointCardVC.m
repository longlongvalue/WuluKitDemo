//
//  JointCardVC.m
//  WuluKitDemo
//
//  Created by gaolailong on 2021/1/21.
//

#import "JointCardVC.h"
#import <WuluKit/WuluKit.h>
#import "ProtocolTest.h"

@interface JointCardVC ()

/// sdk实例
@property (nonatomic, strong) WuluKitPlugin                 *wuluPlugin;

@property (nonatomic, strong) UIActivityIndicatorView       *activityIndicator;

@end

@implementation JointCardVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [WuluKitPlugin setEnvironment:@"QA"];
    
}

// 联名卡页面可能会存在一些耗时操作，建议不要放在主线程中执行
- (IBAction)jointCardBtnClicked:(UIButton *)sender {
    [self.activityIndicator startAnimating];
    // 初始化交通卡SDK
    NSString *userid = @"2";;
    NSString *appid = @"102";
//    HCYKT.HCT:南昌
//    NJSMK.SAIC:上汽
    NSString *tempCtExtCode = @"HCYKT.HCT";
    self.wuluPlugin = [[WuluKitPlugin alloc] initialWithDelegate:[ProtocolTest shareInstance] appid:appid userId:userid deviceToken:@"3"];
    self.wuluPlugin.wxAppid = @"wx6fe739eda712ed9a";
    NSError *error = [self.wuluPlugin showAddTraficCardPageWithParentController:self.navigationController andCxtCode:tempCtExtCode];
    [self.activityIndicator stopAnimating];
    if (error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:error.domain preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *ok = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:nil];
            [alertVC addAction:ok];
            [self presentViewController:alertVC animated:YES completion:nil];
        });
    }
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
