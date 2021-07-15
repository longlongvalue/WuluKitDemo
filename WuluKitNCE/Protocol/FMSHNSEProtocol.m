//
//  FMSHNSEProtocol.m
//  WuluKitNCE
//
//  Created by gaolailong on 2021/7/6.
//  Copyright © 2021 上海复旦微电子集团股份有限公司. All rights reserved.
//

#import "FMSHNSEProtocol.h"

//#define PrivateKey @"-----BEGIN RSA PRIVATE KEY-----\nMIIEpAIBAAKCAQEAu1Vq9vL4AJvI4my6dkPXqvkd5tGYh3yLpWIh1MYi2NFu9VKI\nS6LfsdY1eDgJeAJwWCFNXvt2Zw6ihlnaRmFGv2GxPMaH7BJ9RPVB8kLwbgfEL+X4\nfUeEFySMap9bD5m+Uvj16piW7tIKaBHrpEzfl0KjvjmWHh7Rmg/4Cz52m7HSdGao\nKbOmlCY/YecDmhjMSmMeF8SyLSWdWoygYQC/EDu1RgPnYfuUe+OrWBSoWTEct1f+\n92Dh/jELCrBb25o5vw3qqphJ6sxoTJe5wfqxklZ5Dgv+H5SlFOjTo27xuQdie0JW\nhZnjKD6+yixpslcgIclsUAAc2FqMCyHyfY8AVQIDAQABAoIBAQCnlPMaNSJ8UOA1\nBbUMRQZycWY5bPh5A4ZdDVtcX18e/MO4+/rnRq28BfdRMzftPqlHfYscU/GIocPs\nUgb8fNrwK7GEv8kp+yRLAufak91HYPU1MBHJ6KcWmOBwJVwtqYhj60j6c0RaIlWi\n4Z0eHpLKWpfmfNd43HL+0hg/3sH15mYwip1JUVxg/K8hAMaQYkrpyL1L6yy9SmNQ\nzBFvPCf2Es5/qGHodNk5ZFtnEQd13UddLpTEbTrKv8ZxU7b2gwQJSo/qU3vnBHq8\n7GalgQ2rapqjN+K0g/BdKQ0vNlFjkrg7rq9kNlxvGiMBhY33DJilj73o5RFpnu+L\nEULKwZ4FAoGBAOWmLemM6+NfT43ve5AOQY9VT9x1eRoNBZXQnId9CTvtfbuo6LrO\nNNEvVDbyT0HceeLeZP+hnLQ146IlmvutyC+a01PJMTOCNdy7boDbHoTk8YhhXv4m\nYtKj5th0MN9ZnxJ7AVP8Z19xW0l7D/7LJyoKHXdphV0++VBJVvPPL0//AoGBANDU\nPnlrdPXRaUC5jmYoWCSUDRck6TdrxXa4WCSu7pqCUannabRrDODrw38f2NaNQM2W\nxzWf8imU9SJKgWz427NS22fTnHsuz+NnUL3lOVFFiuKzw8xWNXkYoojnx/LUNFr1\nmY4mOa1g3T1f4FKNZithsmC53/gPfFzBW23au2+rAoGASNqiYCBjyTs4asfZxEax\nh75B2qet5pTQ+8k1j0ocftWF+N3KD1FRsjc4mUHf4P4H8PAqzGpB423hLFSPyV5F\nTszoVAFUyYl6eu8/TEO3d+OFuIVjdG9LFJYIqwyZYJH3BA7fyfwd80pr8nDHD0b1\nwsF4vaRNOdq7jzvlCO3mjZMCgYBQ5ae+Ca6pe5I2jKtpT7+1i9T2XkoqOgmo0Aj1\nTP8Jw+o203rTdZTrnOmC2ad6lgXAnuRVFb0N9rJvskUpHc6eTT7JneREpAHMqj1R\nEvd9UF9ZKyJyigL1AmIUfxWqMCKIChSOSKiXTarnF7kiwbwOmi4r4lWtFvKqTA1L\nJSzvOQKBgQCgjnanWIl/FNUe55YeGLUJSS2WRWh99MdUZE7zTs33AhnppynZ7I3q\ndTUI//C/qcpepel8AiLGOVSVTl18+v0itzsz276T7b5OE/8z4zwza+rsyPRyNCWN\n7igCPGo7uJV9oiv5dxUhpNNujMelMUkxOJ8IWpfWr68U3lmip2mhAw==\n-----END RSA PRIVATE KEY-----"
//
//#define PblicKey @"-----BEGIN PUBLIC KEY-----\nMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAu1Vq9vL4AJvI4my6dkPX\nqvkd5tGYh3yLpWIh1MYi2NFu9VKIS6LfsdY1eDgJeAJwWCFNXvt2Zw6ihlnaRmFG\nv2GxPMaH7BJ9RPVB8kLwbgfEL+X4fUeEFySMap9bD5m+Uvj16piW7tIKaBHrpEzf\nl0KjvjmWHh7Rmg/4Cz52m7HSdGaoKbOmlCY/YecDmhjMSmMeF8SyLSWdWoygYQC/\nEDu1RgPnYfuUe+OrWBSoWTEct1f+92Dh/jELCrBb25o5vw3qqphJ6sxoTJe5wfqx\nklZ5Dgv+H5SlFOjTo27xuQdie0JWhZnjKD6+yixpslcgIclsUAAc2FqMCyHyfY8A\nVQIDAQAB\n-----END PUBLIC KEY-----"

#define PrivateKey @"MIIEpAIBAAKCAQEAu1Vq9vL4AJvI4my6dkPXqvkd5tGYh3yLpWIh1MYi2NFu9VKIS6LfsdY1eDgJeAJwWCFNXvt2Zw6ihlnaRmFGv2GxPMaH7BJ9RPVB8kLwbgfEL+X4fUeEFySMap9bD5m+Uvj16piW7tIKaBHrpEzfl0KjvjmWHh7Rmg/4Cz52m7HSdGaoKbOmlCY/YecDmhjMSmMeF8SyLSWdWoygYQC/EDu1RgPnYfuUe+OrWBSoWTEct1f+92Dh/jELCrBb25o5vw3qqphJ6sxoTJe5wfqxklZ5Dgv+H5SlFOjTo27xuQdie0JWhZnjKD6+yixpslcgIclsUAAc2FqMCyHyfY8AVQIDAQABAoIBAQCnlPMaNSJ8UOA1BbUMRQZycWY5bPh5A4ZdDVtcX18e/MO4+/rnRq28BfdRMzftPqlHfYscU/GIocPsUgb8fNrwK7GEv8kp+yRLAufak91HYPU1MBHJ6KcWmOBwJVwtqYhj60j6c0RaIlWi4Z0eHpLKWpfmfNd43HL+0hg/3sH15mYwip1JUVxg/K8hAMaQYkrpyL1L6yy9SmNQzBFvPCf2Es5/qGHodNk5ZFtnEQd13UddLpTEbTrKv8ZxU7b2gwQJSo/qU3vnBHq87GalgQ2rapqjN+K0g/BdKQ0vNlFjkrg7rq9kNlxvGiMBhY33DJilj73o5RFpnu+LEULKwZ4FAoGBAOWmLemM6+NfT43ve5AOQY9VT9x1eRoNBZXQnId9CTvtfbuo6LrONNEvVDbyT0HceeLeZP+hnLQ146IlmvutyC+a01PJMTOCNdy7boDbHoTk8YhhXv4mYtKj5th0MN9ZnxJ7AVP8Z19xW0l7D/7LJyoKHXdphV0++VBJVvPPL0//AoGBANDUPnlrdPXRaUC5jmYoWCSUDRck6TdrxXa4WCSu7pqCUannabRrDODrw38f2NaNQM2WxzWf8imU9SJKgWz427NS22fTnHsuz+NnUL3lOVFFiuKzw8xWNXkYoojnx/LUNFr1mY4mOa1g3T1f4FKNZithsmC53/gPfFzBW23au2+rAoGASNqiYCBjyTs4asfZxEaxh75B2qet5pTQ+8k1j0ocftWF+N3KD1FRsjc4mUHf4P4H8PAqzGpB423hLFSPyV5FTszoVAFUyYl6eu8/TEO3d+OFuIVjdG9LFJYIqwyZYJH3BA7fyfwd80pr8nDHD0b1wsF4vaRNOdq7jzvlCO3mjZMCgYBQ5ae+Ca6pe5I2jKtpT7+1i9T2XkoqOgmo0Aj1TP8Jw+o203rTdZTrnOmC2ad6lgXAnuRVFb0N9rJvskUpHc6eTT7JneREpAHMqj1REvd9UF9ZKyJyigL1AmIUfxWqMCKIChSOSKiXTarnF7kiwbwOmi4r4lWtFvKqTA1LJSzvOQKBgQCgjnanWIl/FNUe55YeGLUJSS2WRWh99MdUZE7zTs33AhnppynZ7I3qdTUI//C/qcpepel8AiLGOVSVTl18+v0itzsz276T7b5OE/8z4zwza+rsyPRyNCWN7igCPGo7uJV9oiv5dxUhpNNujMelMUkxOJ8IWpfWr68U3lmip2mhAw=="

#define PblicKey @"MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAu1Vq9vL4AJvI4my6dkPXqvkd5tGYh3yLpWIh1MYi2NFu9VKIS6LfsdY1eDgJeAJwWCFNXvt2Zw6ihlnaRmFGv2GxPMaH7BJ9RPVB8kLwbgfEL+X4fUeEFySMap9bD5m+Uvj16piW7tIKaBHrpEzfl0KjvjmWHh7Rmg/4Cz52m7HSdGaoKbOmlCY/YecDmhjMSmMeF8SyLSWdWoygYQC/EDu1RgPnYfuUe+OrWBSoWTEct1f+92Dh/jELCrBb25o5vw3qqphJ6sxoTJe5wfqxklZ5Dgv+H5SlFOjTo27xuQdie0JWhZnjKD6+yixpslcgIclsUAAc2FqMCyHyfY8AVQIDAQAB"


@implementation FMSHNSEProtocol

+ (instancetype)shareInstance {
    static FMSHNSEProtocol *protocolTest;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        protocolTest = [[FMSHNSEProtocol alloc] init];
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
    NSString *appid = @"100";
    NSString *userid = @"2";
    NSString *deviceToken = @"3";
    NSString *timestamp = [self currentDateStr];
    NSString *orignalSign = [NSString stringWithFormat:@"%@%@%@%@", appid, userid, deviceToken, timestamp];
    NSString *signStr = [self sign:orignalSign];
    complete(appid, userid, deviceToken, timestamp, signStr, 1);
}

- (NSString *)sign:(NSString *)plainText {
    //对数据进行加密
    NSString *result = [WuluFMSHEncrypt wuluKitSignWithPlainText:plainText withPrivateKey:PrivateKey];
    NSLog(@"签名:%@",result);
    return result;
}

@end
