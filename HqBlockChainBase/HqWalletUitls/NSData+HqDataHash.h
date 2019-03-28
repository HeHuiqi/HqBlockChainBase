//
//  NSData+HqDataHash.h
//  HqBlockChainBase
//
//  Created by hehuiqi on 3/28/19.
//  Copyright © 2019 hehuiqi. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


@interface NSData (HqDataHash)

- (NSString *)dataToString;
- (NSData *)SHA256;

@end

NS_ASSUME_NONNULL_END
