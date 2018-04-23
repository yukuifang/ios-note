//
//  ViewController.m
//  RuntimeDemo
//
//  Created by fangyukui on 2018/4/23.
//  Copyright © 2018年 fangyukui. All rights reserved.
//

#import "ViewController.h"
#import "DynamicMethodTheory.h"
#import "BackupReciver.h"
#import "MessageDistribution.h"
@interface ViewController ()
@end

@implementation ViewController
- (IBAction)backupReciver:(id)sender {
    BackupReciver *vc =[[BackupReciver alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
}
- (IBAction)toMessageDistribution:(id)sender {
    MessageDistribution *vc = [[MessageDistribution alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (IBAction)toDynamicMethod:(id)sender {
    
    DynamicMethodTheory *vc = [[DynamicMethodTheory alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
@end
