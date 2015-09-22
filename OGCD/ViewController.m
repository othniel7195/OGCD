//
//  ViewController.m
//  OGCD
//
//  Created by 赵锋 on 15/9/9.
//  Copyright (c) 2015年 赵锋. All rights reserved.
//

#import "ViewController.h"
#import "OGCDQueue.h"
#import "OGCDGroup.h"
#import "OGCDTimer.h"
#import "OGCDSemaphore.h"
@interface ViewController ()
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIImage     *image;
@property (nonatomic, strong) OGCDTimer *t;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //[self executeSerial];
   // [self executeConcurrent];
    //[self barrierExecute];
    
//    self.imageView        = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
//    self.imageView.center = self.view.center;
//    [self.view addSubview:self.imageView];
//    
//    
//    
//    [OGCDQueue executeInGlobalQueue:^{
// 
//        NSString *netUrlString = @"http://f.hiphotos.baidu.com/image/pic/item/e1fe9925bc315c60191d32308fb1cb1348547760.jpg";
//        NSURLRequest *request  = [NSURLRequest requestWithURL:[NSURL URLWithString:netUrlString]];
//        NSData       *picData  = [NSURLConnection sendSynchronousRequest:request
//                                                       returningResponse:nil
//                                                                   error:nil];
//        //UIImage *imgae = [[UIImage alloc] initWithData:picData];
//       // NSLog(@"---------");
//        
//        
//        [OGCDQueue executeInMainQueue:^{
//            
//            UIImage *imgae2 = [[UIImage alloc] initWithData:picData];
//            self.imageView.image = imgae2;
//            
//        }];
//        
//        
//    }];
    
   // [self group];
    
  //  [self timer];
    
    [self semaphore];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

//串行测试
- (void)executeSerial
{
    OGCDQueue *queue = [[OGCDQueue alloc] initSerial];
    
    [queue execute:^{
        NSLog(@"1");
    }];
    [queue execute:^{
        NSLog(@"2");
    }];
    [queue execute:^{
        sleep(1.f);
        NSLog(@"3");
    }];
    [queue execute:^{
        NSLog(@"4");
    }];
    
    //延迟
    [queue execute:^{
        NSLog(@"666");
    } afterDelay:2.5f];
    [queue execute:^{
        NSLog(@"777");
    } afterDelay:2.5f];
    
    [queue execute:^{
        NSLog(@"5");
    }];

    // 同步
    
    [queue syncExecute:^{
        NSLog(@"6668");
    }];
    [queue syncExecute:^{
        NSLog(@"7778");
    }];
}

//并行测试
- (void)executeConcurrent
{
    OGCDQueue *queue = [[OGCDQueue alloc] initConcurrent];
    
    [queue execute:^{
        NSLog(@"1");
    }];
    [queue execute:^{
        NSLog(@"2");
    }];
    [queue execute:^{
        sleep(1.f);
        NSLog(@"3");
    }];
    [queue execute:^{
        NSLog(@"4");
    }];
    //延迟
    [queue execute:^{
        NSLog(@"666");
    } afterDelay:2.5f];
    
    [queue execute:^{
        NSLog(@"777");
    } afterDelay:2.5f];
    
    [queue execute:^{
        NSLog(@"5");
    }];
    
    // 同步
    
    [queue syncExecute:^{
        sleep(2.0);
        NSLog(@"6668");
    }];
    [queue syncExecute:^{
        NSLog(@"7778");
    }];
}

- (void)barrierExecute
{
    OGCDQueue *queue = [[OGCDQueue alloc] initConcurrent];
    
    [queue execute:^{
        sleep(2.f);
        NSLog(@"1");
    }];
    [queue execute:^{
        NSLog(@"2");
    }];
    [queue barrierExecute:^{
        NSLog(@"--- barrier");
    }];
    [queue execute:^{
        sleep(1.0);
        NSLog(@"3");
    }];
    [queue execute:^{
        NSLog(@"4");
    }];
}

- (void)group
{
    OGCDGroup *g =[[OGCDGroup alloc] init];
    
    OGCDQueue *q = [[OGCDQueue alloc] initConcurrent];
    
    [q execute:^{
        NSLog(@"1");
    } inGroup:g];
    [q execute:^{
        NSLog(@"2");
    } inGroup:g];
    [q execute:^{
        NSLog(@"3");
    } inGroup:g];
    [q notify:^{
        NSLog(@"444");
    } inGroup:g];
    [q execute:^{
        NSLog(@"5");
    } inGroup:g];
}

- (void)timer
{
    self.t = [[OGCDTimer alloc] initWithQueue:[OGCDQueue mainQueue]];
    [self.t event:^{
        NSLog(@"哈哈哈");
    } timeInterval:3.0];
    [self.t start];
}

- (void)semaphore
{
    OGCDSemaphore *s =[[OGCDSemaphore alloc] initWithValue:0];
    
    [[OGCDQueue globalQueue] execute:^{
        
        NSLog(@"test 1");
        
        [s signal];
    }];
    
    [[OGCDQueue globalQueue] execute:^{
        
        NSLog(@"test 2");
    }];
    
    [[OGCDQueue globalQueue] execute:^{
        [s wait];
        NSLog(@"test 3");
        
    }];
}

@end
