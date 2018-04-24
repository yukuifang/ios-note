//
//  ViewController.m
//  OptimizeDemo
//
//  Created by fangyukui on 2018/4/24.
//  Copyright © 2018年 fangyukui. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    dispatch_queue_t queue = dispatch_queue_create("queue", DISPATCH_QUEUE_CONCURRENT);
    for (int i = 0; i < 999; i++) {
        dispatch_async(queue, ^{
            
            NSLog(@"%d",i);
        });
    }
    dispatch_barrier_sync(queue, ^{
        NSLog(@"over");
    });
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
