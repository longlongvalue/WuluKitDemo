//
//  LoginVC.m
//  WuluKitDemo
//
//  Created by gaolailong on 2021/3/16.
//

#import "LoginVC.h"

@interface LoginVC ()

@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGFloat SCREENWIDTH = [[UIScreen mainScreen] bounds].size.width;
    
    UIButton *loginBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 50, SCREENWIDTH - 40, 40)];
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    loginBtn.backgroundColor = [UIColor greenColor];
    [loginBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(loginView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
    
    UIButton *refeshBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 100, SCREENWIDTH - 40, 40)];
    [refeshBtn setTitle:@"取消" forState:UIControlStateNormal];
    refeshBtn.backgroundColor = [UIColor greenColor];
    [refeshBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [refeshBtn addTarget:self action:@selector(cancelLoginView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:refeshBtn];
    
}

- (void)loginView {
    if ([_delegate respondsToSelector:@selector(loginResult:)]) {
        [_delegate loginResult:nil];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)cancelLoginView {
    if ([_delegate respondsToSelector:@selector(loginResult:)]) {
        NSError *error = [NSError errorWithDomain:@"取消登录" code:9001 userInfo:nil];
        [_delegate loginResult:error];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
