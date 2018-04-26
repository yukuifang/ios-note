//
//  ViewController.m
//  DrawRectDemo
//
//  Created by fangyukui on 2018/4/24.
//  Copyright © 2018年 fangyukui. All rights reserved.
//

#import "ViewController.h"
#import "LiftCycle.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}
- (IBAction)toLiftCycle:(id)sender {
    LiftCycle *vc  =[[LiftCycle alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
}





@end
