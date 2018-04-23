//
//  MessageDistribution.m
//  RuntimeDemo
//
//  Created by fangyukui on 2018/4/23.
//  Copyright © 2018年 fangyukui. All rights reserved.
//

#import "MessageDistribution.h"
#import "Person.h"
@interface MessageDistribution ()

@end

@implementation MessageDistribution

- (void)viewDidLoad {
    [super viewDidLoad];
    //执行foo函数
    [self performSelector:@selector(foo:) withObject:self];
}
+ (BOOL)resolveInstanceMethod:(SEL)sel {
    return YES;//返回YES，进入下一步转发
}

- (id)forwardingTargetForSelector:(SEL)aSelector {
    return nil;//返回nil，进入下一步转发
}
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    if ([NSStringFromSelector(aSelector) isEqualToString:@"foo:"]) {
        //签名，进入forwardInvocation
        return [NSMethodSignature signatureWithObjCTypes:"v@:"];
        
    }
    return [super methodSignatureForSelector:aSelector];
}
/*
如果在上一步还不能处理未知消息，则唯一能做的就是启用完整的消息转发机制了。 首先它会发送-methodSignatureForSelector:消息获得函数的参数和返回值类型。如果-methodSignatureForSelector:返回nil ，Runtime则会发出 -doesNotRecognizeSelector: 消息，程序这时也就挂掉了。如果返回了一个函数签名，Runtime就会创建一个NSInvocation 对象并发送 -forwardInvocation:消息给目标对象。
 */
- (void)forwardInvocation:(NSInvocation *)anInvocation {
    SEL sel = anInvocation.selector;
    Person *p = [Person new];
    if([p respondsToSelector:sel]) {
        [anInvocation invokeWithTarget:p];
    }
    else {
        [self doesNotRecognizeSelector:sel];
    }
    
}



@end
