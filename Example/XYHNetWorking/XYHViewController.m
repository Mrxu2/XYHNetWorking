//
//  XYHViewController.m
//  XYHNetWorking
//
//  Created by 13779928250@163.com on 04/11/2023.
//  Copyright (c) 2023 13779928250@163.com. All rights reserved.
//

#import "XYHViewController.h"
#import <XNetworkManager.h>
#import "XYHViewModel.h"
@interface XYHViewController ()
@property(nonatomic,copy)XYHViewModel *model;
@end

@implementation XYHViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[[XNetworkManager defaultManager]registerWithApiUrl:@"https://autumnfish.cn" userToken:@"" userSecret:@"" refreshToken:@"" appVersion:@""] setIsOpenApiLog:YES];
    [self.model.subject subscribeNext:^(id  _Nullable x) {
        
    }];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(XYHViewModel *)model{
    if(!_model){
        _model = [[XYHViewModel alloc]init];
    }
    return _model;
}
@end
