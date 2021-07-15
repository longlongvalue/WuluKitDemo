//
//  NotifyModel.h
//  WuluKitNCE
//
//  Created by gaolailong on 2021/7/6.
//  Copyright © 2021 上海复旦微电子集团股份有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NotifyModel : NSObject

/// 充值卡CT标识
@property (nonatomic, copy) NSString            *ctExtCode;

/// 充值卡设备标识
@property (nonatomic, copy) NSString            *dpanCode;

+ (instancetype)modelWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
