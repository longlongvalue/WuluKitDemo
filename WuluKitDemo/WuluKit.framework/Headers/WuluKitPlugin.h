//
//  WuluKitPlugin.h
//  WuluKit
//
//  Created by gaolailong on 2020/7/1.
//  Copyright © 2020 上海复旦微电子集团股份有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "WuluFMSHTraficCard.h"

typedef void(^RegisterComplete)(NSError * _Nullable error);
typedef void(^GetAppSign)(NSString * _Nonnull appid, NSString * _Nullable userid, NSString * _Nullable deviceToken, NSString * _Nonnull timestamp, NSString * _Nonnull appSignature, NSInteger keyIndex);

NS_ASSUME_NONNULL_BEGIN

@protocol WuluKitPluginDelegate <NSObject>

@required

/// App签名失效后，WuluKit主动向App获取签名参数
/// @param callback 回调函数告知WuluKit，签名数据包含appid、userid、timestamp、appSignature、keyIndex
- (void)getAppSign:(GetAppSign)callback;

/// 跳转App登录/注册页面
/// @param recommondName 便捷注册时推荐的用户名
/// @param registerType 注册类型。1:注册     2:登录
/// @param callback 回调函数告知WuluKit已完成相关操作，如果用户取消等，需在NSError信息中告知，例如
/// NSError *error = [NSError errorWithDomain:@"用户取消注册登录" code:1024 userInfo:nil];
- (void)registerWithRecommondName:(NSString * _Nullable)recommondName RegisterType:(NSInteger)registerType Callback:(RegisterComplete)callback;

/// 获取用户实名认证的姓名、身份证号码、手机号码
/// @param callback 回调函数
- (void)getUserRealNameInfo:(void(^)(NSString * _Nullable userRealName, NSString * _Nullable IDCardNumber, NSString * _Nullable telephone))callback;

@optional
/// 发送用户实名认证的姓名、身份证号、手机号码
/// @param userRealName 姓名
/// @param IDCardNumber 身份证号
/// @param telephone 手机号码
- (void)giveUserRealNameInfoWithUserName:(NSString *)userRealName idCardNumber:(NSString *)IDCardNumber telephoe:(NSString *)telephone;

@end

@interface WuluKitPlugin : NSObject

/// 十六进制页面主色调，默认#358cf5
@property (nonatomic, copy) NSString    *mainPageColor;

/// 十六进制页面辅色调，默认#ff9a2e
@property (nonatomic, copy) NSString    *secondaryPageColor;

/// 在微信开放平台注册的应用id
@property (nonatomic, copy) NSString    *wxAppid;

/// 消费记录中是否显示“可在App中查看乘车消费记录”。默认0:不显示；1:显示
@property (nonatomic, assign) NSInteger travelRecordsBanner;

/// WuluKit初始化
/// @param delegate 代理方
/// @param appid 应用唯一标识
/// @param userId 应用内登录用户唯一标识
/// @param deviceToken 匿名用户的设备唯一标识
- (instancetype)initialWithDelegate:(id<WuluKitPluginDelegate>)delegate appid:(NSString * _Nonnull)appid userId:(NSString * _Nullable)userId deviceToken:(NSString * _Nonnull)deviceToken;

/// 获取App有权限读取的本机卡列表
+ (nullable NSArray <WuluFMSHTraficCard *>*)cardList;

/// 显示交通卡整页列表页面
/// @param parentVC WuluKit要显示的父控制器
- (void)showFullPageWithParentController:(UINavigationController *_Nonnull)parentVC;

/// 显示交通卡腰线列表页面
/// @param y 腰线页面要显示的顶部的最小Y坐标
- (UIViewController *)showWaistLinePageWithMinY:(CGFloat)y;

/// 刷新腰线页面
- (void)refrshWaistLinePage;

@end

NS_ASSUME_NONNULL_END
