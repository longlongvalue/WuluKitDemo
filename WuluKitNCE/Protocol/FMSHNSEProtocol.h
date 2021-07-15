//
//  FMSHNSEProtocol.h
//  WuluKitNCE
//
//  Created by gaolailong on 2021/7/6.
//  Copyright © 2021 上海复旦微电子集团股份有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WuluKit/WuluKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FMSHNSEProtocol : NSObject<WuluFMSHQuickRechargeDelegate>

+ (instancetype)shareInstance;

@end

NS_ASSUME_NONNULL_END
