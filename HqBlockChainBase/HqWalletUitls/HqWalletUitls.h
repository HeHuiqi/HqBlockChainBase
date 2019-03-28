//
//  HqWalletUitls.h
//  HqBlockChainBase
//
//  Created by hehuiqi on 3/28/19.
//  Copyright © 2019 hehuiqi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSData+HqDataHash.h"
#import "NSString+HqString.h"

NS_ASSUME_NONNULL_BEGIN

@interface HqWalletUitls : NSObject

+ (NSData *)randomWithSize:(NSUInteger)size;
+ (NSArray *)toMnemonicArrayWithRandomData:(NSData *)data;

/*
 默认生成12个助记词
 */
+ (NSArray *)generateMnemonic;

/*
 @param size 取值 128、160、192、224、256
 */
+ (NSArray *)generateMnemonicWithRandomSize:(NSUInteger)size;
@end

NS_ASSUME_NONNULL_END

/*
 用法：
 1
     NSData *randomData = [HqWalletUitls randomWithSize:128];
     NSLog(@"randomData == %@",randomData.dataToString);
     NSArray *words = [HqWalletUitls toMnemonicArrayWithRandomData:randomData];
     NSLog(@"words==%@,count==%@",words,@(words.count));
 2
     NSArray *words =  [HqWalletUitls generateMnemonic];
     NSLog(@"words==%@,count==%@",words,@(words.count));
 
 */
