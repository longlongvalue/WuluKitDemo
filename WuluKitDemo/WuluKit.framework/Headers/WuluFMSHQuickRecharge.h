//
//  WuluFMSHQuickRecharge.h
//  WuluKit
//
//  Created by gaolailong on 2021/7/6.
//  Copyright © 2021 上海复旦微电子集团股份有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^completion)(NSError * _Nullable error);

@protocol WuluFMSHQuickRechargeDelegate <NSObject>

@required

/// App签名失效后，WuluKit主动向App获取签名参数
/// @param callback 回调函数告知WuluKit，签名数据包含appid、userid、timestamp、appSignature、keyIndex
- (void)getAppSign:(GetAppSign)callback;

@end

@interface WuluFMSHQuickRecharge : NSObject

- (instancetype)initialWithDelegate:(id<WuluFMSHQuickRechargeDelegate>)delegate;

/// 快捷充值（仅支持Apple Pay）
/// @param parentVc 显示充值页面的父控制器
/// @param amount 充值金额
/// @param dpanCode 充值卡设备标识
/// @param ctExtCode 联名卡编码
/// @param callback 充值结果回调
- (void)quickRechargeWithParentVc:(UIViewController *)parentVc rechargeAmount:(NSInteger)amount dpanCode:(NSString *)dpanCode ctExtCode:(NSString *)ctExtCode completion:(completion)callback;

@end

NS_ASSUME_NONNULL_END
