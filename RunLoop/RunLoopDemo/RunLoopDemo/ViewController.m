//
//  ViewController.m
//  RunLoopDemo
//
//  Created by fangyukui on 2018/5/2.
//  Copyright © 2018年 fangyukui. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property(nonatomic,strong)NSThread *thread;
@property(nonatomic,strong)NSTimer *timer;
@property(nonatomic,strong)NSPort *port;
@property (weak, nonatomic) IBOutlet UIButton *removeTimerBtn;
@property (weak, nonatomic) IBOutlet UIButton *removeEventBtn;
@property (weak, nonatomic) IBOutlet UIButton *nonalEventBtn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    // 创建子线程并开启
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSThread *thread = [[NSThread alloc]initWithTarget:self selector:@selector(show) object:nil];
        self.thread = thread;
        [thread start];
    });
   
}
-(void)show
{
    // 注意：打印方法一定要在RunLoop创建开始运行之前，如果在RunLoop跑起来之后打印，RunLoop先运行起来，已经在跑圈了就出不来了，进入死循环也就无法执行后面的操作了。
    // 但是此时点击Button还是有操作的，因为Button是在RunLoop跑起来之后加入到子线程的，当Button加入到子线程RunLoop就会跑起来
    NSLog(@"%s",__func__);
    // 1.创建子线程相关的RunLoop，在子线程中创建即可，并且RunLoop中要至少有一个Timer 或 一个Source 保证RunLoop不会因为空转而退出，因此在创建的时候直接加入
    // 添加Source [NSMachPort port] 添加一个端口
    _port = [NSMachPort port];
    [[NSRunLoop currentRunLoop] addPort:_port forMode:NSDefaultRunLoopMode];
    // 添加一个Timer
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(timeComing) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    _timer = timer;
    //创建监听者
    CFRunLoopObserverRef observer = CFRunLoopObserverCreateWithHandler(CFAllocatorGetDefault(), kCFRunLoopAllActivities, YES, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
        switch (activity) {
            case kCFRunLoopEntry:
                NSLog(@"RunLoop进入");
                break;
            case kCFRunLoopBeforeTimers:
                NSLog(@"RunLoop要处理Timers了");
                break;
            case kCFRunLoopBeforeSources:
                NSLog(@"RunLoop要处理Sources了");
                break;
            case kCFRunLoopBeforeWaiting:
                NSLog(@"RunLoop要休息了\n\n\n");
                break;
            case kCFRunLoopAfterWaiting:
                NSLog(@"RunLoop醒来了");
                break;
            case kCFRunLoopExit:
                NSLog(@"RunLoop退出了");
                break;
                
            default:
                break;
        }
    });
    // 给RunLoop添加监听者
    CFRunLoopAddObserver(CFRunLoopGetCurrent(), observer, kCFRunLoopDefaultMode);
    // 2.子线程需要开启RunLoop
    [[NSRunLoop currentRunLoop]run];
    
    CFRelease(observer);
    NSLog(@"来到这里这辈子是不可能的。。");
}
- (IBAction)btnClick:(id)sender {
    [self performSelector:@selector(test) onThread:self.thread withObject:nil waitUntilDone:NO];
}
-(void)test
{
    NSLog(@"我被点击了，在线程%@",[NSThread currentThread]);
}
-(void)timeComing
{
    NSLog(@"时间到了，在线程%@",[NSThread currentThread]);
}
- (IBAction)removeTimer:(UIButton *)sender {
    [_timer invalidate];
    _timer = nil;
    
    
}
- (IBAction)removeEvent:(id)sender {

    [[NSRunLoop currentRunLoop]removePort:_port forMode:NSDefaultRunLoopMode];
    
}
@end




