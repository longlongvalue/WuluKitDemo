//
//  NotificationViewController.m
//  WuluKitNCE
//
//  Created by gaolailong on 2021/7/2.
//  Copyright © 2021 上海复旦微电子集团股份有限公司. All rights reserved.
//

#import "NotificationViewController.h"
#import <UserNotifications/UserNotifications.h>
#import <UserNotificationsUI/UserNotificationsUI.h>
#import <PassKit/PassKit.h>
#import <WuluKit/WuluKit.h>
#import "NotifyModel.h"
#import "FMSHNSEProtocol.h"

@interface NotificationViewController () <UNNotificationContentExtension>

@property (nonatomic, strong) UIView                    *contentView;

@property (nonatomic, strong) UILabel                   *rechargeMoneyLb;

@property (nonatomic, strong) NotifyModel               *notificationModel;

@property (nonatomic, strong) WuluFMSHQuickRecharge     *quickRecharge;

@end

@implementation NotificationViewController

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc] initWithFrame:self.view.bounds];
        _contentView.backgroundColor = [UIColor whiteColor];
    }
    return _contentView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any required interface initialization here.
    NSLog(@"notification viewDidLoad");
    [WuluKitPlugin setEnvironment:@"UAT"];
}

#pragma mark - ------ 收到通知更新UI ------
- (void)didReceiveNotification:(UNNotification *)notification {
    NSLog(@"notification didReceiveNotification");
    NSDictionary *cardInfo = [notification.request.content.userInfo objectForKey:@"cardInfo"];
    if (!cardInfo || ![cardInfo isKindOfClass:[NSDictionary class]]) {
        return;
    }
    
    self.notificationModel = [NotifyModel modelWithDictionary:cardInfo];
    [self.view addSubview:self.contentView];
    
    UIActivityIndicatorView *activity = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleLarge];
    activity.center =CGPointMake(CGRectGetWidth(self.view.frame) /2, CGRectGetHeight(self.view.frame) /2);
    activity.transform = CGAffineTransformMakeScale(2, 2);
    activity.color = [UIColor grayColor];
    activity.hidesWhenStopped = YES;
    [activity startAnimating];
    [self.contentView addSubview:activity];
    
    
    // 初始化快捷充值对象
    self.quickRecharge = [[WuluFMSHQuickRecharge alloc] initialWithDelegate:[FMSHNSEProtocol shareInstance] dpanCode:self.notificationModel.dpanCode completion:^(NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [activity stopAnimating];
            // 移除旧视图
            [self.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
            if (error) {
                // 错误视图
                [self setUpResultPageUI:NO tipText:error.domain];
                return;
            }
            // 支付视图
            [self setUpPaymentPageUI];
        });
    }];
}

#pragma mark - ------ 支付页面 ------
- (void)setUpPaymentPageUI {
    // 该支付金额数据可从后端获取然后本地缓存
    NSArray *moneyArray = [NSArray arrayWithObjects:@"10", @"20", @"50", nil];
    CGFloat viewWidth = CGRectGetWidth(self.view.frame);
    CGFloat marginY = 20.0;
    // 卡面图片，可以使用URL地址加缓存策略
    UIImageView *cardFaceIv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"3xdigitalcard"]];
    CGFloat cfIvW = CGRectGetWidth(self.view.frame) / 3.0 * 2.18;
    CGFloat cfIvH = cfIvW / 3.0 * 1.9;
    CGFloat cfIvX = (viewWidth - cfIvW) / 2.0;
    cardFaceIv.frame = CGRectMake(cfIvX, marginY, cfIvW, cfIvH);
    cardFaceIv.layer.cornerRadius = 10;
    cardFaceIv.layer.masksToBounds = YES;
    [self.contentView addSubview:cardFaceIv];
    // 付款金额
    CGFloat moneyPreLbY = CGRectGetMaxY(cardFaceIv.frame) + marginY;
    CGFloat moneyPreOffsetX = 25.0;
    NSString *moneyPreLbStr = @"¥ ";
    UILabel *moneyPreLb = [UILabel new];
    moneyPreLb.frame = CGRectMake(0, moneyPreLbY, viewWidth / 2.0 - moneyPreOffsetX, 15);
    moneyPreLb.text = moneyPreLbStr;
    moneyPreLb.textAlignment = NSTextAlignmentRight;
    moneyPreLb.font = [UIFont systemFontOfSize:20];
    [self.contentView addSubview:moneyPreLb];
    
    NSString *moneyLbStr = [moneyArray firstObject];
    UILabel *moneyLb = [UILabel new];
    moneyLb.frame = CGRectMake(CGRectGetMaxX(moneyPreLb.frame), moneyPreLbY, viewWidth / 2.0 + moneyPreOffsetX, 40);
    moneyLb.font = [UIFont boldSystemFontOfSize:50];
    moneyLb.text = moneyLbStr;
    [self.contentView addSubview:moneyLb];
    self.rechargeMoneyLb = moneyLb;
    // 计算两个宽
//    CGSize moneyPreLbSize = [moneyPreLb sizeThatFits:CGSizeMake(MAXFLOAT, MAXFLOAT)];
//    CGSize moneyLbSize = [moneyLb sizeThatFits:CGSizeMake(MAXFLOAT, MAXFLOAT)];
//    CGFloat moneyPreLbX = (viewWidth - moneyPreLbSize.width - moneyLbSize.width) / 2.0;
//    CGFloat moneyPreLbY = CGRectGetMaxY(cardFaceIv.frame) + marginY;
//    moneyPreLb.frame = CGRectMake(moneyPreLbX, moneyPreLbY, moneyPreLbSize.width, 15);
//    moneyLb.frame = CGRectMake(CGRectGetMaxX(moneyPreLb.frame), moneyPreLbY, moneyLbSize.width, 40);
    
    // 金额分割线
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(moneyLb.frame) + marginY, viewWidth, 0.5)];
    lineView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.1];
    [self.contentView addSubview:lineView];
    
    // 金额选项按钮
    CGFloat moneyBtnMarginX = 0;
    CGFloat moneyBtnW = (viewWidth - (moneyArray.count + 1) * moneyBtnMarginX) / moneyArray.count;
    CGFloat moneyBtnY = CGRectGetMaxY(lineView.frame);
    CGFloat moneyBtnH = 55.0;
    [moneyArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *moneyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        moneyBtn.frame = CGRectMake(moneyBtnMarginX + idx * (moneyBtnMarginX + moneyBtnW), moneyBtnY, moneyBtnW, moneyBtnH);
        [moneyBtn setTitle:[NSString stringWithFormat:@"¥%@", obj] forState:UIControlStateNormal];
        [moneyBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [moneyBtn addTarget:self action:@selector(moneyBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:moneyBtn];
    }];
    // ApplePay支付按钮
    PKPaymentButtonType buttonStyle = PKPaymentButtonTypeTopUp;
    PKPaymentButton *applePayBtn = [[PKPaymentButton alloc] initWithPaymentButtonType:buttonStyle paymentButtonStyle:PKPaymentButtonStyleBlack];
    [applePayBtn addTarget:self action:@selector(applePayClicked) forControlEvents:UIControlEventTouchUpInside];
    applePayBtn.layer.cornerRadius = 8.0;
    applePayBtn.frame = CGRectMake(20, moneyBtnY + moneyBtnH, viewWidth - 40, 45);
    [self.contentView addSubview:applePayBtn];
}
#pragma mark - ------ 支付按钮被点击 ------
- (void)applePayClicked {
    NSLog(@"支付按钮被点击");
    
    [self.quickRecharge quickRechargeWithParentVc:self rechargeAmount:[self.rechargeMoneyLb.text integerValue] * 100 dpanCode:self.notificationModel.dpanCode ctExtCode:self.notificationModel.ctExtCode completion:^(NSError * _Nullable error) {
        BOOL isSuccess = NO;
        if (!error) {
            isSuccess = YES;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            // 移除旧视图
            [self.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
            // 重新添加新视图
            [self.view addSubview:self.contentView];
            [self setUpResultPageUI:isSuccess tipText:error.domain];
        });
    }];
}

#pragma mark - ------ 金额被点击 ------
- (void)moneyBtnClicked:(UIButton *)sender {
    NSLog(@"money:%@", sender.titleLabel.text);
    self.rechargeMoneyLb.text = [sender.titleLabel.text substringFromIndex:1];
}

#pragma mark - ------ 支付成功页面 ------
- (void)setUpResultPageUI:(BOOL)isSuccess tipText:(NSString *)tip {
    // 支付成功图片
    CGFloat viewWidth = CGRectGetWidth(self.view.frame);
    CGFloat viewHeight = CGRectGetHeight(self.view.frame);
    CGFloat marginY = 20.0;
    NSString *resultIconName = @"big-white-ok-icon";
    NSString *resultTipText = @"充值成功，请关注卡内余额变化";
    if (!isSuccess) {
        resultIconName = @"big-orange-Incomplete";
        resultTipText = @"充值失败";
        if (tip) {
            resultTipText = tip;
        }
    }
    // 卡面图片
    UIImageView *resultIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:resultIconName]];
    CGFloat cfIvW = 120.0;
    CGFloat cfIvH = cfIvW;
    CGFloat cfIvX = (viewWidth - cfIvW) / 2.0;
    resultIcon.frame = CGRectMake(cfIvX, 20, cfIvW, cfIvH);
    [self.contentView addSubview:resultIcon];
    // 支付成功文字
    UILabel *resultLb = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(resultIcon.frame) + 10, viewWidth, 30)];
    resultLb.text = resultTipText;
    resultLb.font = [UIFont systemFontOfSize:20];
    resultLb.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:resultLb];
    // 支付成功按钮
    UIButton *resultBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    CGFloat marginX = 20.0;
    CGFloat resultBtnH = 45.0;
    CGFloat resultBtnY = viewHeight - resultBtnH - marginY;
    resultBtn.frame = CGRectMake(marginX, resultBtnY, viewWidth - marginX * 2, resultBtnH);
    [resultBtn setTitle:@"完成" forState:UIControlStateNormal];
    [resultBtn setBackgroundColor:[UIColor colorNamed:@"MainPage"]];
    [resultBtn addTarget:self action:@selector(completeClicked) forControlEvents:UIControlEventTouchUpInside];
    resultBtn.layer.cornerRadius = 8.0;
    [self.contentView addSubview:resultBtn];
}

- (void)completeClicked {
    // 可根据成功失败决定是否移除通知
//    UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
//    UNUserNotificationCenter.current().removeAllDeliveredNotifications()
    [self.extensionContext dismissNotificationContentExtension];
}

@end
