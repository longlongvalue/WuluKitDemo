//
//  ProtocolTest.m
//  WuluKitDemo
//
//  Created by gaolailong on 2020/7/3.
//  Copyright © 2020 上海复旦微电子集团股份有限公司. All rights reserved.
//

#define PrivateKey @"MIIEpAIBAAKCAQEAu1Vq9vL4AJvI4my6dkPXqvkd5tGYh3yLpWIh1MYi2NFu9VKIS6LfsdY1eDgJeAJwWCFNXvt2Zw6ihlnaRmFGv2GxPMaH7BJ9RPVB8kLwbgfEL+X4fUeEFySMap9bD5m+Uvj16piW7tIKaBHrpEzfl0KjvjmWHh7Rmg/4Cz52m7HSdGaoKbOmlCY/YecDmhjMSmMeF8SyLSWdWoygYQC/EDu1RgPnYfuUe+OrWBSoWTEct1f+92Dh/jELCrBb25o5vw3qqphJ6sxoTJe5wfqxklZ5Dgv+H5SlFOjTo27xuQdie0JWhZnjKD6+yixpslcgIclsUAAc2FqMCyHyfY8AVQIDAQABAoIBAQCnlPMaNSJ8UOA1BbUMRQZycWY5bPh5A4ZdDVtcX18e/MO4+/rnRq28BfdRMzftPqlHfYscU/GIocPsUgb8fNrwK7GEv8kp+yRLAufak91HYPU1MBHJ6KcWmOBwJVwtqYhj60j6c0RaIlWi4Z0eHpLKWpfmfNd43HL+0hg/3sH15mYwip1JUVxg/K8hAMaQYkrpyL1L6yy9SmNQzBFvPCf2Es5/qGHodNk5ZFtnEQd13UddLpTEbTrKv8ZxU7b2gwQJSo/qU3vnBHq87GalgQ2rapqjN+K0g/BdKQ0vNlFjkrg7rq9kNlxvGiMBhY33DJilj73o5RFpnu+LEULKwZ4FAoGBAOWmLemM6+NfT43ve5AOQY9VT9x1eRoNBZXQnId9CTvtfbuo6LrONNEvVDbyT0HceeLeZP+hnLQ146IlmvutyC+a01PJMTOCNdy7boDbHoTk8YhhXv4mYtKj5th0MN9ZnxJ7AVP8Z19xW0l7D/7LJyoKHXdphV0++VBJVvPPL0//AoGBANDUPnlrdPXRaUC5jmYoWCSUDRck6TdrxXa4WCSu7pqCUannabRrDODrw38f2NaNQM2WxzWf8imU9SJKgWz427NS22fTnHsuz+NnUL3lOVFFiuKzw8xWNXkYoojnx/LUNFr1mY4mOa1g3T1f4FKNZithsmC53/gPfFzBW23au2+rAoGASNqiYCBjyTs4asfZxEaxh75B2qet5pTQ+8k1j0ocftWF+N3KD1FRsjc4mUHf4P4H8PAqzGpB423hLFSPyV5FTszoVAFUyYl6eu8/TEO3d+OFuIVjdG9LFJYIqwyZYJH3BA7fyfwd80pr8nDHD0b1wsF4vaRNOdq7jzvlCO3mjZMCgYBQ5ae+Ca6pe5I2jKtpT7+1i9T2XkoqOgmo0Aj1TP8Jw+o203rTdZTrnOmC2ad6lgXAnuRVFb0N9rJvskUpHc6eTT7JneREpAHMqj1REvd9UF9ZKyJyigL1AmIUfxWqMCKIChSOSKiXTarnF7kiwbwOmi4r4lWtFvKqTA1LJSzvOQKBgQCgjnanWIl/FNUe55YeGLUJSS2WRWh99MdUZE7zTs33AhnppynZ7I3qdTUI//C/qcpepel8AiLGOVSVTl18+v0itzsz276T7b5OE/8z4zwza+rsyPRyNCWN7igCPGo7uJV9oiv5dxUhpNNujMelMUkxOJ8IWpfWr68U3lmip2mhAw=="

#import "ProtocolTest.h"
#import <WuluKit/WuluKit.h>
#import "RSAEncryptor.h"

@implementation ProtocolTest

+ (instancetype)shareInstance {
    static ProtocolTest *protocolTest;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        protocolTest = [[ProtocolTest alloc] init];
    });
    return protocolTest;
}


//获取当前时间
- (NSString *)currentDateStr{
    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];// 创建一个时间格式化对象
    [dateFormatter setDateFormat:@"YYYYMMddhhmmss"];//设定时间格式,这里可以设置成自己需要的格式
    NSString *dateString = [dateFormatter stringFromDate:currentDate];//将时间转化成字符串
    return dateString;
}


#pragma mark - WuluKitPluginDelegate
- (void)getAppSign:(GetAppSign)complete {
    NSString *appid = @"101";
    NSString *userid = @"2";
    NSString *deviceToken = @"3";
    NSString *timestamp = [self currentDateStr];
    NSString *orignalSign = [NSString stringWithFormat:@"%@%@%@%@", appid, userid, deviceToken, timestamp];
    NSString *signStr = [self sign:orignalSign];
    complete(appid, userid, deviceToken, timestamp, signStr, 1);
}

- (void)getUserRealNameInfo:(nonnull void (^)(NSString * _Nullable, NSString * _Nullable, NSString * _Nullable))callback {
    callback(nil, nil, nil);
}


- (void)registerWithRecommondName:(NSString * _Nullable)recommondName RegisterType:(NSInteger)registerType Callback:(nonnull RegisterComplete)callback {
    // TODO: 跳转登录页面进行注册登录,成功后调用callback返回wulukit sdk告知登录结果
    callback(nil);
}

- (void)giveUserRealNameInfoWithUserName:(NSString *)userRealName idCardNumber:(NSString *)IDCardNumber telephoe:(NSString *)telephone {
    NSLog(@"userRealName:%@---IDCardNumber:%@---telephone:%@", userRealName, IDCardNumber, telephone);
}

- (NSString *)sign:(NSString *)plainText {
    //对数据进行加密
    NSString *result = [RSAEncryptor sign:plainText withPriKey:PrivateKey];
    NSLog(@"签名:%@",result);
    return result;
}

@end
