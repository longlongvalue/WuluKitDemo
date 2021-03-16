//
//  ViewController.m
//  WuluKitDemo
//
//  Created by gaolailong on 2020/8/4.
//

#import "ViewController.h"
#import <WuluKit/WuluKit.h>
#import "ProtocolTest.h"
#import "LoginVC.h"

@interface ViewController ()<ProtocolTestDelegate, LoginVCDelegate>

@property (nonatomic, strong) WuluKitPlugin *wuluPlugin;

@property (nonatomic, copy) Complete callback;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor systemGray5Color];
    
    [WuluKitPlugin setEnvironment:@"UAT"];
    
    CGFloat SCREENWIDTH = [[UIScreen mainScreen] bounds].size.width;
    CGFloat SCREENHEIGHT = [[UIScreen mainScreen] bounds].size.height;
    UIScrollView *scrollView = [UIScrollView new];
    scrollView.frame = CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT);
    scrollView.contentSize = CGSizeMake(SCREENWIDTH, SCREENHEIGHT * 1.1);
    [self.view addSubview:scrollView];
    
    ProtocolTest *protocolTest = [ProtocolTest shareInstance];
    protocolTest.delegate = self;
    
    NSString *appid = @"100";
    NSString *userid = nil;
    if (protocolTest.isLogin) {
        userid = @"2";
    }
    // 初始化交通卡SDK
    self.wuluPlugin = [[WuluKitPlugin alloc] initialWithDelegate:protocolTest appid:appid userId:userid deviceToken:@"3"];
    if (protocolTest.isLogin) {
        self.wuluPlugin.wxAppid = @"wx6fe739eda712ed9a";
    }
    UIViewController *waistView = [self.wuluPlugin showWaistLinePageWithMinY:160.0];
    [self addChildViewController:waistView];
    [waistView didMoveToParentViewController:self];
    [scrollView addSubview:waistView.view];
    
}

- (void)showLoginView:(Complete)callback {
    self.callback = callback;
    LoginVC *loginVC = [[LoginVC alloc] init];
    loginVC.delegate = self;
    [self presentViewController:loginVC animated:YES completion:nil];
}

- (void)loginResult:(NSError *)error {
    if (error) {
        self.callback(error);
    } else {
        self.callback(nil);
    }
    self.callback = nil;
}

@end
