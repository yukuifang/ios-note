//
//  MyView.m
//  DrawRectDemo
//
//  Created by fangyukui on 2018/4/24.
//  Copyright © 2018年 fangyukui. All rights reserved.
//

#import "MyView.h"

@implementation MyView

/*
 Only override drawRect: if you perform custom drawing.
 An empty implementation adversely affects performance during animation.

*/

- (void)drawRect:(CGRect)rect {
    NSLog(@"view drawRect");
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    [self addSubview:btn];
    btn.backgroundColor = [UIColor orangeColor];
    _btn = btn;
//    self.contentMode = UIViewContentModeRedraw;
    
}

@end
