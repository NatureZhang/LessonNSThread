//
//  ViewController.m
//  NSThread
//
//  Created by zhangdong on 16/5/16.
//  Copyright © 2016年 zhangdong. All rights reserved.
//

#import "ViewController.h"
#import "MyThread.h"
//http://nsoio.github.io/2013/12/18/2013-12-18-multi-threading-programming-of-ios-part-1/
@interface ViewController ()

@property (nonatomic, strong) NSThread *thread;
//@property (nonatomic, strong) MyThread *thread;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

// 创建线程
- (void)createThread {
    
    /*
     
     创建线程的开销：iOS下构造内核数据结构（大约1KB）、栈空间（子线程512KB、主线程1MB），可以使用setStackSize自己设置，注意是4KB的倍数，最小16K，创建线程大约需要90毫秒
     
     */
    _thread = [[NSThread alloc] initWithTarget:self selector:@selector(runThread) object:nil];
    
//    _thread = [[MyThread alloc] init];
//    [_thread start];
}

- (void)runThread {
    
    // 每个线程都有自己的堆栈，这个值必须以字节为单位，并且是4KB的倍数，如果你要改变堆栈大小，你必须在开始线程之前设置这个属性
    NSLog(@"%lu", (unsigned long)[_thread stackSize]);
    
    // 通过 判断 isCancelled 来控制
    for (int i = 0 ; i < 10000 && ![[NSThread currentThread] isCancelled]; i ++) {
        
        // [NSThread currentThread] 获取当前线程
        // [NSThread sleepForTimeInterval:2]; 让线程休眠指定的时间间隔
        
        NSLog(@"runThread_%@_%d:%d", [NSThread currentThread], [NSThread isMainThread], i);
    }
    NSLog(@"%@", [_thread threadDictionary]);

    
    // 线程执行完成后，系统自动释放他所占用的内存空间
}

// 开始执行
- (IBAction)startThread:(id)sender {
    [_thread start];
}

// 停止执行
- (IBAction)cancleThread:(id)sender {
    
    /*
     直接 [_thread cancel] 并不能直接结束子线程
     
     cancel 只是改变 isCancelled 的状态
     
     可以在执行方法中通过判断 isCancelled 来控制方法的执行
     */

    
    if (!_thread.isCancelled) {
        [_thread cancel];
    }
    
    /*
     [NSThread exit]; 能够使线程退出，但是不能保证释放其在执行时，所持有的资源
     */
    
    NSLog(@"cancleThread_%@_%d", [NSThread currentThread], [NSThread isMainThread]);
    
}

@end
