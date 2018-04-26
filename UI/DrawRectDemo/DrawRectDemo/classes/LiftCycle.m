//
//  LiftCycle.m
//  DrawRectDemo
//
//  Created by fangyukui on 2018/4/24.
//  Copyright © 2018年 fangyukui. All rights reserved.
//

#import "LiftCycle.h"
#import "MyView.h"

@interface LiftCycle ()

@property (nonatomic,strong)MyView *myView;

@end

@implementation LiftCycle

+(void)load{
    NSLog(@"程序一启动所有的类被加载load");
}

+(void)initialize{
    NSLog(@"类发送init消息时, initialize");
}

-(void)loadView{
    [super loadView];
    NSLog(@"loadView");
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blueColor];
    MyView *myView  = [[MyView alloc]initWithFrame:CGRectMake(0, 0, 200, 200)];
    [self.view addSubview:myView];
    _myView = myView;
    
    NSLog(@"viewDidLoad");
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSLog(@"viewWillAppear");
}
-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    NSLog(@"viewWillLayoutSubviews");
    
}
-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    NSLog(@"viewDidLayoutSubviews");
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    NSLog(@"viewDidAppear");
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    NSLog(@"viewWillDisappear");
}


-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    NSLog(@"viewDidDisappear");
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    self.myView.frame = CGRectMake(100, 100, 300, 300);
//    self.myView.btn.frame = CGRectMake(2,2, 20, 20);
//    [self.myView sizeThatFits:CGSizeMake(400, 400)];
    
//    [self.myView setNeedsDisplay];
    [self.myView drawRect:CGRectMake(100, 100, 300, 300)];
    
}


@end
