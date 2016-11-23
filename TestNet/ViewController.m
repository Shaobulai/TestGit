//
//  ViewController.m
//  TestNet
//
//  Created by StarJ on 2016/11/16.
//  Copyright © 2016年 StarJ. All rights reserved.
//

#import "ViewController.h"
#import "AFHTTPRequestOperationManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self downloadData] ;
}

- (void)downloadData
{
    NSDictionary *item = @{@"client":@{@"environment":@"sandbox",
                                       @"paypal_sdk_version":@"2.16.1",
                                       @"platform":@"iOS",
                                       @"product_name":@"PayPal iOS SDK"},
                           
                           @"response":@{@"create_time":@"2016-11-16T09:26:39Z",
                                         @"id":@"PAY-40D747302E1241936LAWCMDQ",
                                         @"intent":@"sale",
                                         @"state":@"approved"},
                           @"response_type":@"payment"} ;
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:item options:NSJSONWritingPrettyPrinted error:nil] ;
    NSString *jsonstr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] ;
    
    NSDictionary *parameters = @{@"item":jsonstr, @"oid":@"215", @"fee":@"0.44"};
    NSLog(@"parameters:%@",parameters) ;
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *getAppJson = @"http://www.tulip.city:8090/paypal" ;
    
    [manager POST:getAppJson parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
    id result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil] ;
         //获取字典中的值
         if ([result isKindOfClass:[NSDictionary class]])
         {
             NSDictionary *dic = result ;
             NSLog(@"通知:%@",dic) ;
        }
             
               }
          failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
                 NSLog(@"Error: %@", error);
     }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
