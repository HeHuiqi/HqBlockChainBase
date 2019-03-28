//
//  ViewController.m
//  HqBlockChainBase
//
//  Created by hehuiqi on 3/28/19.
//  Copyright © 2019 hehuiqi. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSData *randomData = [HqWalletUitls randomWithSize:128];
    NSLog(@"randomData == %@",randomData.dataToString);
    NSArray *words = [HqWalletUitls toMnemonicArrayWithRandomData:randomData];
    NSLog(@"words==%@,count==%@",words,@(words.count));

//    NSArray *words =  [HqWalletUitls generateMnemonic];
//    NSLog(@"words==%@,count==%@",words,@(words.count));


}


@end
