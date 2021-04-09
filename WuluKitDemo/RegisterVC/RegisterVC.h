//
//  RegisterVC.h
//  WuluKitDemo
//
//  Created by gaolailong on 2021/4/1.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol RegisterVCDelegate <NSObject>

/// 注册结果
/// @param error 注册错误
- (void)registerResult:(NSError * _Nullable)error;

/// 已有账号去登录
- (void)goLogin;

@end

@interface RegisterVC : UIViewController

@property (nonatomic, weak) id<RegisterVCDelegate>         delegate;

@end

NS_ASSUME_NONNULL_END
