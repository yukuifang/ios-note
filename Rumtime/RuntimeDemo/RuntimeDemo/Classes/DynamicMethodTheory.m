//
//  DynamicMethodTheory.m
//  RuntimeDemo
//
//  Created by fangyukui on 2018/4/23.
//  Copyright © 2018年 fangyukui. All rights reserved.
//

#import "DynamicMethodTheory.h"
#import <objc/runtime.h>
#import "Person.h"



@interface DynamicMethodTheory ()

@end

@implementation DynamicMethodTheory

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //执行foo函数
    [self performSelector:@selector(foo:) withObject:self];
}
+ (BOOL)resolveInstanceMethod:(SEL)sel {
    if (sel == @selector(foo:)) {
        //如果是执行foo函数，就动态解析，指定新的IMP
        class_addMethod([self class], sel, (IMP)fooMethod, "v@:");
        return YES;
      
    }
    return [super resolveInstanceMethod:sel];
}

void fooMethod(id obj, SEL _cmd) {
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
