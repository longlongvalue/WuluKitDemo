//
//  LoginVC.h
//  WuluKitDemo
//
//  Created by gaolailong on 2021/3/16.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol LoginVCDelegate <NSObject>

- (void)loginResult:(NSError * _Nullable)error;

@end

@interface LoginVC : UIViewController

@property (nonatomic, weak) id<LoginVCDelegate>         delegate;

@end

NS_ASSUME_NONNULL_END
