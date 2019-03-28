//
//  HqWalletUitls.m
//  HqBlockChainBase
//
//  Created by hehuiqi on 3/28/19.
//  Copyright © 2019 hehuiqi. All rights reserved.
//

#import "HqWalletUitls.h"

//算法加密
#import <CommonCrypto/CommonDigest.h>
#define CC_XZEROMEM(p, n)    memset((p), 0, (n))

@implementation HqWalletUitls

/*
 创建随机种子
 熵(bits)     校验和(bits)     熵 + 校验和 (bits)     助记词长度
 128     4     132     12
 160     5     165     15
 192     6     198     18
 224     7     231     21
 256     8     264     24
 */
+ (NSData *)randomWithSize:(NSUInteger)size{
    
    //这里size要除以8,对与NSData是用十六进制表示的，一个十六进制表示4位二进制，在运算时，每两位十六进制
    //参与运算，即8位二进制
    size = size/8;
    OSStatus sanityCheck = noErr;
    uint8_t *bytes = NULL;
    bytes = malloc(size * sizeof(uint8_t));
    memset((void *) bytes, 0x0, size);
    sanityCheck = SecRandomCopyBytes(kSecRandomDefault, size, bytes);
    if (sanityCheck == errSecSuccess) {
        return [NSData dataWithBytes:bytes length:size];
    }
    
    return nil;
}
/*
 默认生成12个助记词
 */
+ (NSArray *)generateMnemonic{
    return [self generateMnemonicWithRandomSize:0];
}
/*
@param size 取值 128、160、192、224、256
 */
+ (NSArray *)generateMnemonicWithRandomSize:(NSUInteger)size{
    if (size == 0) {
        size = 128;
    }
    NSData *seed = [self randomWithSize:size];
    //转化为二进制字符串
    NSString *seedBinaryStr = [NSString getBinaryStrByHexStr:seed.dataToString];
    NSMutableString *result = [[NSMutableString alloc] initWithString:seedBinaryStr];

    NSMutableData *seedHash = [NSMutableData dataWithLength:CC_SHA256_DIGEST_LENGTH];
    CC_SHA256(seed.bytes, (CC_LONG)seed.length, seedHash.mutableBytes);
//    NSLog(@"seedHash = %@",seedHash.dataToString);
    
    //这里取了seedHash的前两位十六进制位，也就是8位二进制位
    NSData *checkData = [seedHash subdataWithRange:NSMakeRange(0, 1)];
//    NSLog(@"checkData = %@",checkData.dataToString);
    NSString *checkDataBinaryStr = [NSString getBinaryStrByHexStr:checkData.dataToString];

    //开始拼接seed和校验码

    //取seedHash二进制位的前（seed.length*8/32）位作为校验码
    NSUInteger checkNumLen = seed.length*8/32;
    NSString *checkNumHexStr = [checkDataBinaryStr substringToIndex:checkNumLen];
//    NSLog(@"checkNumHexStr = %@",checkNumHexStr);
    //拼接校验码
    [result appendString:checkNumHexStr];
    

    NSString *mnemonicBitStr = result;
//    NSLog(@"mnemonicBitStr = %@",mnemonicBitStr);
    NSMutableArray *generateWords = [[NSMutableArray alloc] initWithCapacity:0];
    NSArray *words = [self getWords];
    for (int i = 0; i<mnemonicBitStr.length/11; i++) {
        NSString *wordBitStr = [mnemonicBitStr substringWithRange:NSMakeRange(i*11, 11)];
        NSUInteger index = [NSString getDecimalByBinary:wordBitStr];
        [generateWords addObject:words[index]];
    }
//    NSLog(@"generateWords== %@",generateWords);
//    NSLog(@"generateWords.count== %@",@(generateWords.count));


    return generateWords;
    
}

+ (NSArray *)toMnemonicArrayWithRandomData:(NSData *)randomData {
    
    if ((randomData.length % 4) != 0 || randomData.length == 0) return nil; // data length must be a multiple of 32 bits
    
    NSArray *words = [self getWords];
    uint32_t n = (uint32_t) words.count, x;
    NSMutableArray *a = [[NSMutableArray alloc] initWithCapacity:randomData.length * 3 / 4];
    NSMutableData *d = [[NSMutableData alloc]initWithData:randomData];
    //当data是128位二进制时
    // data{length:16} data.SHA256{length:32} 16+32 = 48; 48/4 = 12;
    [d appendData:randomData.SHA256]; // append SHA256 checksum
    
    for (int i = 0; i < randomData.length * 3 / 4; i++) {
        x = CFSwapInt32BigToHost(*(const uint32_t *) ((const uint8_t *) d.bytes + i * 11 / 8));
        
        [a addObject:words[(x >> (sizeof(x) * 8 - (11 + ((i * 11) % 8)))) % n]];
    }
    
    CC_XZEROMEM(&x, sizeof(x));
    return a;
}
+ (NSArray *)getWords {
    
    NSString *lpath = [[NSBundle mainBundle] pathForResource:@"BIP39EnglishWords.plist" ofType:nil];
    NSArray *words = [[NSArray alloc] initWithContentsOfFile:lpath];
    return words;
}
@end
