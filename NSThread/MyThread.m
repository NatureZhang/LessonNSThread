//
//  MyThread.m
//  NSThread
//
//  Created by zhangdong on 16/5/16.
//  Copyright © 2016年 zhangdong. All rights reserved.
//

#import "MyThread.h"

@implementation MyThread

- (void)main {
    @autoreleasepool {
        NSLog(@"starting thread 。。。。。。");
        NSTimer *timer = [NSTimer timerWithTimeInterval:1.0
                                                 target:self
                                               selector:@selector(doTimerTask)
                                               userInfo:nil
                                                repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
        
        // 如果当前线程不被取消，则进入循环
        while (!self.isCancelled) {
            [self doOtherTask];
            
            // 
            // runLoop 开始执行
//            BOOL ret = [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
            
//            NSLog(@"after runloop counting....:%d", ret);
        }
        
        NSLog(@"finishing thread ......");
    }
}

- (void)doTimerTask {
    NSLog(@"do timer task");
    
    //    添加RunLoop停止代码，使NSRunLoop 的runMode:(NSString *)mode beforeDate:(NSDate *)limitDate方法返回
    //   停止代码必须在runloop运行接口为runMode:下才能用
    //    这行代码写在 timer的触发事件中
    CFRunLoopStop(CFRunLoopGetCurrent());
}

- (void)doOtherTask {
    NSLog(@"do other task");
}
@end
