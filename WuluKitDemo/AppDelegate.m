//
//  AppDelegate.m
//  WuluKitDemo
//
//  Created by gaolailong on 2020/8/4.
//

#import "AppDelegate.h"
#import <WXApi.h>
#import "WXApiManager.h"
#import <AlipaySDK/AlipaySDK.h>

#import <UserNotifications/UserNotifications.h>
#import "NotificationHandle.h"

#define kAppKey_Wechat @"wx6fe739eda712ed9a"
#define UniVersalLink @"https://test.nfcos.net.cn/wulukit/"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    // 注册微信支付
    BOOL isSuccess = [WXApi registerApp:kAppKey_Wechat universalLink:UniVersalLink];
    if (isSuccess) {
        NSLog(@"微信支付API注册成功");
    } else {
        NSLog(@"微信支付API注册失败");
    }
    
    [self registerNotification:application];
    
    return YES;
}

// NOTE: 9.0以后使用新API接口
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
    if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        /// TODO: 测试付款这里接收并处理以后sdk中付款的的回调方法还会不会执行
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:nil];
        [[AlipaySDK defaultService] processAuth_V2Result:url standbyCallback:^(NSDictionary *resultDic) {
                //code：拿到授权信息，完成业务逻辑
            NSLog(@"AlipaySDK processAuth_V2Result = %@",resultDic);
        }];
    }else if ([url.host isEqualToString:@"pay"]){ //微信支付的回调
        return [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
    }
    return YES;
}

#pragma mark - ------ 注册通知 ------
- (void)registerNotification:(UIApplication *)application {
    [UNUserNotificationCenter currentNotificationCenter].delegate = [NotificationHandle shareInstance];
    
    [[NotificationHandle shareInstance] authorizationPushNotificaton:application];
    [[NotificationHandle shareInstance] registerNotificationCategory];
    
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    
    NSString *deviceTokenString = [self hexStringWithData:deviceToken];
    NSLog(@"deviceToken:%@", deviceTokenString);
    
    [[NSUserDefaults standardUserDefaults] setValue:deviceTokenString forKey:@"deviceToken"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
    NSLog(@"获取token失败:%@\n",error.localizedDescription);
}

- (NSString *)hexStringWithData:(NSData *)data {
    Byte *bytes = (Byte *)[data bytes];
    NSString *hexStr=@"";
    for(int i=0;i<[data length];i++) {
        NSString *newHexStr = [NSString stringWithFormat:@"%x",bytes[i]&0xff];///16进制数
        if([newHexStr length]==1){
            hexStr = [NSString stringWithFormat:@"%@0%@",hexStr,newHexStr];
        } else {
            hexStr = [NSString stringWithFormat:@"%@%@",hexStr,newHexStr];
        }
    }
    return hexStr;
}

@end
