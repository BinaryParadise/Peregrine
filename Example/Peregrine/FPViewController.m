//
//  FPViewController.m
//  Peregrine
//
//  Created by joengzi on 05/06/2019.
//  Copyright (c) 2019 joenggaa. All rights reserved.
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
    
    [FPRouterManager openURL:@"ap://sdyxz/gj" completion:^(BOOL success, NSDictionary * _Nonnull result) {
        
    }];
}

+ (id)flajelijeajglasej:(NSDictionary *)dict __attribute__((pe_routed("ap://sdyxz/gj"))) {
    return nil;
}

- (void)ddddd __deprecated {
    
}

@end
