//
//  NotifyModel.m
//  WuluKitNCE
//
//  Created by gaolailong on 2021/7/6.
//  Copyright © 2021 上海复旦微电子集团股份有限公司. All rights reserved.
//

#import "NotifyModel.h"

@implementation NotifyModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    NSLog(@"WuluFMSHOrder UndefinedKey:%@", key);
}

- (void)setNilValueForKey:(NSString *)key {
    NSLog(@"WuluFMSHOrder setNilValueForKey:%@", key);
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)modelWithDictionary:(NSDictionary *)modelDict {
    return [[self alloc] initWithDictionary:modelDict];
}

@end
