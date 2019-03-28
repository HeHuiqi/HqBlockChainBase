//
//  NSString+HqString.h
//  HqBlockChainBase
//
//  Created by hehuiqi on 3/28/19.
//  Copyright © 2019 hehuiqi. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (HqString)
/*
 二进制字符串转十进制
 @param binary 二进制数
 @return 十进制数
 */
+ (NSString *)getBinaryByHex:(NSString *)hex;
+ (NSString *)getBinaryStrByHexStr:(NSString *)hexStr;

/*
 二进制字符串转十进制
 @param binary 二进制数
 @return 十进制数
 */
+ (NSInteger)getDecimalByBinary:(NSString *)binary;

@end

NS_ASSUME_NONNULL_END
