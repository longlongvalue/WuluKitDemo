//
//  ViewController.m
//  WuluKitDemo
//
//  Created by gaolailong on 2020/8/4.
//

#import "ViewController.h"
#import <WuluKit/WuluKit.h>
#import "ProtocolTest.h"

@interface ViewController ()

@property (nonatomic, strong) WuluKitPlugin *wuluPlugin;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor systemGray5Color];
    
    [WuluKitPlugin setEnvironment:@"QA"];
    
    CGFloat SCREENWIDTH = [[UIScreen mainScreen] bounds].size.width;
    CGFloat SCREENHEIGHT = [[UIScreen mainScreen] bounds].size.height;
    UIScrollView *scrollView = [UIScrollView new];
    scrollView.frame = CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT);
    scrollView.contentSize = CGSizeMake(SCREENWIDTH, SCREENHEIGHT * 1.1);
    [self.view addSubview:scrollView];
    
    // 初始化交通卡SDK
    self.wuluPlugin = [[WuluKitPlugin alloc] initialWithDelegate:[ProtocolTest shareInstance] appid:@"102" userId:@"2" deviceToken:@"3"];
    self.wuluPlugin.wxAppid = @"wx6fe739eda712ed9a";
    UIViewController *waistView = [self.wuluPlugin showWaistLinePageWithMinY:160.0];
    [self addChildViewController:waistView];
    [waistView didMoveToParentViewController:self];
    [scrollView addSubview:waistView.view];
    
}

@end
