//
//  WuluFMSHTraficCard.h
//  WuluKit
//
//  Created by gaolailong on 2020/7/3.
//  Copyright © 2020 上海复旦微电子集团股份有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, WuluKitActivationState) {
    WuluKitCardActivationStateActivated, /// 活跃状态
    WuluKitCardActivationStateRequiresActivation, /// 需要激活
    WuluKitCardActivationStateActivating, /// 激活中
    WuluKitCardActivationStateSuspended, /// 挂失
    WuluKitCardActivationStateDeactivated /// 无效
};


NS_ASSUME_NONNULL_BEGIN

@interface WuluFMSHTraficCard : NSObject

/// 交通卡卡号
@property (nonatomic, copy) NSString                    *faceNo;

/// 交通卡余额,元
@property (nonatomic, copy) NSDecimalNumber             *transitBalance;

/// 交通卡余额交易币种代码
@property (nonatomic, copy) NSString                    *transitBalanceCurrencyCode;

/// 交通卡卡面
@property (nonatomic, copy) NSString                    *cardface;

/// 交通卡类型
@property (nonatomic, copy) NSString                    *cardType;

/// 是否在站内
@property (nonatomic, assign) BOOL                      inStation;

/// 是否在黑名单中
@property (nonatomic, assign) BOOL                      blacklisted;

/// 是否在watch上
@property (nonatomic, assign) BOOL                      onWatch;

/// 交通卡状态
@property (nonatomic, assign) WuluKitActivationState    activationState;

/// 交通卡应用序号
@property (nonatomic, copy) NSString                    *appNo;
/// 卡账户
@property (nonatomic, copy) NSString                    *fpan;
@property (nonatomic, copy) NSString                    *fpanSuffix;
/// 虚拟卡
@property (nonatomic, copy) NSString                    *dpan;
@property (nonatomic, copy) NSString                    *dpanSuffix;

/// 通过获取卡信息接口获得数据
/// 联名卡编码
@property (nonatomic, copy) NSString                    *ctExtCode;
/// 开始可退卡时间，YYYYMMDDHH24MISS格式，成功时必须存在
@property (nonatomic, copy) NSString                    *refundValidity;
/// 卡面ID
@property (nonatomic, copy) NSString                    *skinId;

/// 交通卡实例方法
/// @param modelDict 字典转模型
+ (instancetype)modelWithCardDictionary:(NSDictionary *)modelDict;

@end

NS_ASSUME_NONNULL_END
