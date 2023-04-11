//
//  ApiResultModel.h
//  XYHRACNetWork
//
//  Created by xyh on 2023/2/11.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ApiResultModel : NSObject

@property(strong,nonatomic)NSString *method;
@property(strong,nonatomic)NSString *code;
@property(strong,nonatomic)NSString *message;
@property(strong,nonatomic)NSDictionary *returnData;

@end

NS_ASSUME_NONNULL_END
