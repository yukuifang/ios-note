//
//  UIViewController+LifeCycleTracking.m
//  method_swizzling
//
//  Created by fangyukui on 2018/3/1.
//  Copyright © 2018年 fangyukui. All rights reserved.
//

#import "UIViewController+LifeCycleTracking.h"
#import <objc/message.h>
@implementation UIViewController (LifeCycleTracking)

+(void)load{
    
    
    //一次性代码是安全的
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        NSArray *liftMethods = @[@"viewDidLoad",@"viewWillAppear:",@"viewDidAppear:",@"viewWillDisappear:",@"viewDidDisappear:"];
        
        Class class = [self class];
        
        for (int i = 0; i< liftMethods.count; i++) {
            
            NSString *originLiftMethod = liftMethods[i];
            
            NSString *swizzledLiftMethod = [NSString stringWithFormat:@"yk_%@",originLiftMethod];
            
            SEL originSelector = NSSelectorFromString(originLiftMethod);
            
            SEL swizzledSelector = NSSelectorFromString(swizzledLiftMethod);
            
            Method originMethod =  class_getInstanceMethod(class, originSelector);
            
            Method swizzledMethod =  class_getInstanceMethod(class, swizzledSelector);
            
            //交换实现
            method_exchangeImplementations(originMethod, swizzledMethod);
        }
        
        
        
        
    });
    
}

-(void)yk_viewDidLoad{
    [self yk_viewDidLoad];
    
    NSLog(@"监听到viewDidLoad被调用%@" ,NSStringFromClass([self class]));
}

-(void)yk_viewWillAppear:(BOOL)animated{
    //调用原始viewWillAppear:方法,因为在load已经交换了，所以[self yk_viewWillAppear:animated];就是调用原始viewWillAppear:方法
    [self yk_viewWillAppear:animated];
//    NSLog(@"监听到viewWillAppear被调用");
}
-(void)yk_viewDidAppear:(BOOL)animated{
    [self yk_viewDidAppear:animated];
//    NSLog(@"监听到viewDidAppea被调用");
}

-(void)yk_viewWillDisappear:(BOOL)animated{
    [self yk_viewWillDisappear:animated];
//    NSLog(@"监听到viewWillDisappear被调用");
}
-(void)yk_viewDidDisappear:(BOOL)animated{
    [self yk_viewDidDisappear:animated];
//    NSLog(@"监听到viewDidDisappear被调用");
}


@end
