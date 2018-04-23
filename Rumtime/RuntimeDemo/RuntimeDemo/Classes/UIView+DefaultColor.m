//
//  UIView+DefaultColor.m
//  RuntimeDemo
//
//  Created by fangyukui on 2018/4/23.
//  Copyright © 2018年 fangyukui. All rights reserved.
//

#import "UIView+DefaultColor.h"
#import <objc/runtime.h>

static char KDefaultColorKey;

@implementation UIView (DefaultColor)

@dynamic defaultColor;

-(void)setDefaultColor:(UIColor *)defaultColor{
    objc_setAssociatedObject(self, &KDefaultColorKey, defaultColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}
-(UIColor *)defaultColor{
    return objc_getAssociatedObject(self, &KDefaultColorKey);
}



@end
