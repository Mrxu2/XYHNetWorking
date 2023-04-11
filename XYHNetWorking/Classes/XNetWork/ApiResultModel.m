//
//  ApiResultModel.m
//  XYHRACNetWork
//
//  Created by xyh on 2023/2/11.
//

#import "ApiResultModel.h"
#import <objc/runtime.h>
#import <MJExtension/MJExtension.h>
@implementation ApiResultModel
-(NSDictionary *)returnData
{
    if(!_returnData){
        _returnData = [[NSDictionary alloc]init];
    }
    return _returnData;
}

- (NSString *)description{
    
    NSDictionary *dic = [self mj_keyValues];
    return [dic mj_JSONString];
}
-(NSString *)debugDescription{
    NSDictionary *dic = [self mj_keyValues];
    return [dic mj_JSONString];
}


@end
