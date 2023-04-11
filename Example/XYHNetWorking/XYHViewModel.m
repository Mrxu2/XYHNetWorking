//
//  XYHViewModel.m
//  XYHNetWorking_Example
//
//  Created by xyh on 2023/4/11.
//  Copyright © 2023 13779928250@163.com. All rights reserved.
//

#import "XYHViewModel.h"
@implementation XYHViewModel


-(id)init
{
    if(self = [super init]){
        [self x_initialize];
    }
    return self;
}
- (void)x_initialize {
    [self.refreshCom.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        if([x isKindOfClass:[ApiResultModel class]]){
            ApiResultModel *model = x;
            [self.subject sendNext:model];
        }
    }];
    
    [self.refreshCom execute:nil];
}
-(RACSubject *)subject
{
    if(!_subject){
        _subject = [[RACSubject alloc]init];
    }
    return _subject;
}
-(RACCommand *)refreshCom
{
    if(!_refreshCom){
        _refreshCom = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            NSMutableDictionary *params = [NSMutableDictionary dictionary];
            [params setValue:@"1" forKey:@"num"];
            return [[XNetworkManager defaultManager] racGETWithMethod:@"/api/joke/list" withParameters:params];
        }];
    }
    return _refreshCom;
}

@end
