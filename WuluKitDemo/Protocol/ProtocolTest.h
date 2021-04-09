//
//  ProtocolTest.h
//  WuluKitDemo
//
//  Created by gaolailong on 2020/7/3.
//  Copyright © 2020 上海复旦微电子集团股份有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WuluKit/WuluKit.h>

typedef void(^Complete)(NSError * _Nullable error);

NS_ASSUME_NONNULL_BEGIN

@protocol ProtocolTestDelegate <NSObject>

- (void)showLoginView:(Complete)callback;

- (void)showRegisterView:(Complete)callback;

@end

@interface ProtocolTest : NSObject<WuluKitPluginDelegate>

@property (nonatomic, assign) BOOL                      isLogin;

@property (nonatomic, weak) id<ProtocolTestDelegate>    delegate;

+ (instancetype)shareInstance;

@end

NS_ASSUME_NONNULL_END
