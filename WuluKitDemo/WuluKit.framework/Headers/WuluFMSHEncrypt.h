//
//  WuluFMSHEncrypt.h
//  WuluKit
//
//  Created by gaolailong on 2021/7/13.
//  Copyright © 2021 上海复旦微电子集团股份有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WuluFMSHEncrypt : NSObject

/// 签名方法
/// @param plainText 签名明文
/// @param privateKey 签名私钥
+ (NSString *)wuluKitSignWithPlainText:(NSString *)plainText withPrivateKey:(NSString *)privateKey;

@end

NS_ASSUME_NONNULL_END
