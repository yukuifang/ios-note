//
//  ViewController.m
//  TreadDemo
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
    
//    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//    dispatch_apply(10, queue, ^(size_t index) {
//        sleep(1);
//        NSLog(@"%zu", index);
//    });
//    NSLog(@"done");
    
//    //1.创建NSArray类对象
//    NSArray *array = @[@"a", @"b", @"c", @"d", @"e", @"f", @"g", @"h", @"i", @"j"];
//
//    //2.创建一个全局队列
//    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//
//    //3.通过dispatch_apply函数对NSArray中的全部元素进行处理,并等待处理完成,
//    dispatch_apply([array count], queue, ^(size_t index) {
//        NSLog(@"%zu: %@", index, [array objectAtIndex:index]);
//    });
//    NSLog(@"done");
    
    
    
//    NSArray *array = @[@"a", @"b", @"c", @"d", @"e", @"f", @"g", @"h", @"i", @"j"];
//    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//
//    dispatch_async(queue, ^{
//        dispatch_apply([array count], queue, ^(size_t index) {
//            NSLog(@"%zu: %@", index, [array objectAtIndex:index]);
//        });
//        NSLog(@"回到主线程执行用户界面更新等操作");
//        dispatch_async(dispatch_get_main_queue(), ^{
//            NSLog(@"回到主线程执行用户界面更新等操作");
//        });
//
//    });
    
    
}

@end
