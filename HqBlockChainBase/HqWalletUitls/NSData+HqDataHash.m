//
//  NSData+HqDataHash.m
//  HqBlockChainBase
//
//  Created by hehuiqi on 3/28/19.
//  Copyright © 2019 hehuiqi. All rights reserved.
//

#import "NSData+HqDataHash.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSData (HqDataHash)



- (NSData *)SHA256 {
    NSMutableData *d = [NSMutableData dataWithLength:CC_SHA256_DIGEST_LENGTH];
    CC_SHA256(self.bytes, (CC_LONG) self.length, d.mutableBytes);
    
    return d;
}
- (NSString *)dataToString{
    NSString *str = [NSString stringWithFormat:@"%@",self];
    str = [str stringByReplacingOccurrencesOfString:@"<" withString:@""];
    str = [str stringByReplacingOccurrencesOfString:@">" withString:@""];
    str = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (str.length>0) {
        return str;
    }
    return nil;
}
@end
