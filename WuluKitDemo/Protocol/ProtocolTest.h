//
//  ProtocolTest.h
//  WuluKitDemo
//
//  Created by gaolailong on 2020/7/3.
//  Copyright © 2020 上海复旦微电子集团股份有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WuluKit/WuluKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProtocolTest : NSObject<WuluKitPluginDelegate>

+ (instancetype)shareInstance;

@end

NS_ASSUME_NONNULL_END
