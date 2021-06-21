//
//  RegisterVC.m
//  WuluKitDemo
//
//  Created by gaolailong on 2021/4/1.
//

#import "RegisterVC.h"
#import "LoginVC.h"

@interface RegisterVC ()<LoginVCDelegate>

@end

@implementation RegisterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGFloat SCREENWIDTH = [[UIScreen mainScreen] bounds].size.width;
    
    UIButton *registerBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 250, SCREENWIDTH - 40, 40)];
    [registerBtn setTitle:@"注册" forState:UIControlStateNormal];
    registerBtn.backgroundColor = [UIColor greenColor];
    [registerBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [registerBtn addTarget:self action:@selector(registerView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registerBtn];
    
    UIButton *refeshBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 300, SCREENWIDTH - 40, 40)];
    [refeshBtn setTitle:@"取消" forState:UIControlStateNormal];
    refeshBtn.backgroundColor = [UIColor greenColor];
    [refeshBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [refeshBtn addTarget:self action:@selector(cancelRegisterView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:refeshBtn];
    
    UIButton *loginBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 350, SCREENWIDTH - 40, 40)];
    [loginBtn setTitle:@"去登录" forState:UIControlStateNormal];
    loginBtn.backgroundColor = [UIColor greenColor];
    [loginBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(goLogin) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
    
}


- (void)registerView {
    if ([_delegate respondsToSelector:@selector(registerResult:)]) {
        [_delegate registerResult:nil];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)cancelRegisterView {
    if ([_delegate respondsToSelector:@selector(registerResult:)]) {
        NSError *error = [NSError errorWithDomain:@"取消注册" code:9001 userInfo:nil];
        [_delegate registerResult:error];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)goLogin {
//    if ([_delegate respondsToSelector:@selector(goLogin)]) {
//        [_delegate goLogin];
//    }
    // 第二种方式，一步一步退回
    LoginVC *loginVC = [[LoginVC alloc] init];
    loginVC.delegate = self;
    [self.navigationController pushViewController:loginVC animated:YES];
}

- (void)loginResult:(NSError *)error {
    if ([_delegate respondsToSelector:@selector(registerResult:)]) {
        [_delegate registerResult:error];
    }
    [self.navigationController popViewControllerAnimated:YES];
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
