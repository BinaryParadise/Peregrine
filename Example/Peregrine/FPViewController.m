//
//  FPViewController.m
//  Peregrine
//
//  Created by Rake Yang on 05/06/2019.
//  Copyright (c) 2019 BinaryParadise. All rights reserved.
//

#import "FPViewController.h"
#import <Peregrine/Peregrine.h>

@interface FPViewController ()

@end

@implementation FPViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    NSString *str = PCH_Test(@"xxxxx");
    
    [PGRouterManager openURL:@"ap://sdyxz/mwq/rb?tt=1" completion:^(BOOL ret, id object) {
        
    }];
    
    [PGRouterManager<NSString *> openURL:@"" completion:^(BOOL ret, NSString *object) {
        
    }];
}

+ (id)flajelijeajglasej:(NSDictionary *)dict __attribute__((pe_routed("ap://sdyxz/mwq"))) {
    NSLog(@"It's work.");
    return nil;
}

- (void)ddddd __deprecated {
    
}

@end
