//
//  BackupReciver.m
//  RuntimeDemo
//
//  Created by fangyukui on 2018/4/23.
//  Copyright © 2018年 fangyukui. All rights reserved.
//

#import "BackupReciver.h"
#import <objc/runtime.h>
#import "Person.h"


@interface BackupReciver ()

@end

@implementation BackupReciver

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //执行foo函数
    [self performSelector:@selector(foo:) withObject:self];
}
+ (BOOL)resolveInstanceMethod:(SEL)sel {
    if (sel == @selector(foo:)) {
//        如果resolve方法返回 NO ，运行时就会移到下一步：forwardingTargetForSelector。
        return NO;

    }
    return [super resolveInstanceMethod:sel];
}

void fooMethod2(id obj, SEL _cmd) {
    //ViewController的foo函数
    NSLog(@"Doing ViewController foo");
}

- (id)forwardingTargetForSelector:(SEL)aSelector {

    NSLog(@"forwardingTargetForSelector 调用了");
    if (aSelector == @selector(foo:)) {
        //返回Person对象，让Person对象接收这个消息
        return [Person new];
    }
    return [super forwardingTargetForSelector:aSelector];
}



@end
