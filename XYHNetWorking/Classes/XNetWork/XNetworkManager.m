//
//  XNetworkManager.m
//  XYHRACNetWork
//
//  Created by xyh on 2023/2/11.
//

#import "XNetworkManager.h"
#import <AFNetworking/AFNetworkReachabilityManager.h>
#import "XBaseRACRequest.h"
#import "XBaseRACRequest+RACSupport.h"
#import "XMacro.h"

@interface XNetworkManager ()
@property(nonatomic,copy)NSString *userToken;
@property(nonatomic,copy)NSString *userSecret;
@property(nonatomic,copy)NSString *refreshToken;
@property(nonatomic,copy)NSString *appVersion;
@end

@implementation XNetworkManager


static XNetworkManager * defaultManager = nil;
+ (XNetworkManager *)defaultManager {
    @synchronized(self) {
        if (defaultManager == nil) {
            defaultManager = [[XNetworkManager alloc] init];
            [defaultManager registerWithApiUrl:k_Base_Url userToken:@"" userSecret:@"" refreshToken:@"" appVersion:@""];
        }
    }
    return defaultManager;
}

+ (XReachabilityStatus)getXReachabilityStatus{
    return [[AFNetworkReachabilityManager sharedManager] networkReachabilityStatus];
}
/**
 注册接口配置信息

 @param apiUrl 接口调用地址
 @param userToken 动态令牌
 @param userSecret 动态密钥
 @param refreshToken 刷新令牌
 @param appVersion 版本号
 */
- (XNetworkManager *)registerWithApiUrl:(NSString *)apiUrl
                 userToken:(NSString *)userToken
                userSecret:(NSString *)userSecret
              refreshToken:(NSString *)refreshToken
                appVersion:(NSString *)appVersion{
    
    YTKNetworkConfig *config = [YTKNetworkConfig sharedConfig];
    config.baseUrl = apiUrl;
    self.userToken = userToken;
    self.userSecret = userSecret;
    self.refreshToken = refreshToken;
    self.appVersion = appVersion;
    return self;
}

/// 加密请求参数-信息
/// @param parameters <#parameters description#>
-(NSMutableDictionary *)encryptRegisterWithParameters:(NSMutableDictionary *)parameters{
    NSMutableDictionary *xParams = [[NSMutableDictionary alloc]initWithDictionary:[parameters copy]];
    return xParams;
}


/**
 创建检查网络信号
 
 @return <#return value description#>
 */
- (RACSignal *)startMonitoringNet{
    RACSignal * signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        
        [AFNetworkReachabilityManager.sharedManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            [subscriber sendNext:[NSString stringWithFormat:@"%ld",(long)status]];
        }];
        return nil;
    }];
    return signal;
}


/// GET接口调用-Block
/// @param method 接口名称
/// @param parameters 参数
/// @param block <#block description#>
- (void)httpGetWithMethod:(NSString *)method
           withParameters:(NSMutableDictionary *)parameters
                withBlock:(void (^)(ApiResultModel *result))block{
    NSMutableDictionary *xParams = [self encryptRegisterWithParameters:parameters];
    [XBaseRACRequest rac_GET:method params:xParams withBlock:^(ApiResultModel * _Nonnull result) {
        if (block) {
            block(result);
        }
    }];
}

/// POST接口调用-Block
/// @param method 接口名称
/// @param parameters 参数
/// @param block <#block description#>
- (void)httpPostWithMethod:(NSString *)method
            withParameters:(NSMutableDictionary *)parameters
                 withBlock:(void (^)(ApiResultModel *result))block{
    NSMutableDictionary *xParams = [[XNetworkManager defaultManager] encryptRegisterWithParameters:parameters];
    [XBaseRACRequest rac_POST:method params:xParams withBlock:^(id  _Nonnull result) {
        if(block){
            block(result);
        }
    }];
}


/// 上传图片
/// @param image 图片
/// @param method 接口名称
/// @param params <#params description#>
+ (RACSignal *)uploadImage:(UIImage *)image
                    Method:(NSString *)method
                    params:(NSDictionary *)params{
    
    NSMutableDictionary *xParams = [[XNetworkManager defaultManager] encryptRegisterWithParameters:[params mutableCopy]];
    return [XBaseRACRequest rac_POST:method params:xParams image:image];
}



/// 上传多图 - 随机生成图片上传的表单名
/// @param images 图片数组
/// @param method 接口名称
/// @param params <#params description#>
+ (RACSignal *)uploadImages:(NSArray *)images
                     Method:(NSString *)method
                     params:(NSDictionary *)params{
    NSMutableDictionary *xParams = [[XNetworkManager defaultManager] encryptRegisterWithParameters:[params mutableCopy]];
    return [XBaseRACRequest rac_POST:method params:xParams images:images];
}


/// 上传多图
/// @param imageDict 图片字典-key位表单名称
/// @param method 接口名称
/// @param params <#params description#>
+ (RACSignal *)uploadImageDict:(NSDictionary<NSString *, UIImage *> *)imageDict
                        Method:(NSString *)method
                        params:(NSDictionary *)params{
    NSMutableDictionary *xParams = [[XNetworkManager defaultManager] encryptRegisterWithParameters:[params mutableCopy]];
    return [XBaseRACRequest rac_POST:method params:xParams imageDict:imageDict];
}


/// 上传视频
/// @param videos 视频数组
/// @param method 接口名称
/// @param params <#params description#>
+ (RACSignal *)uploadVideos:(NSArray *)videos
                     Method:(NSString *)method
                     params:(NSDictionary *)params{
    NSMutableDictionary *xParams = [[XNetworkManager defaultManager] encryptRegisterWithParameters:[params mutableCopy]];
    return [XBaseRACRequest rac_POST:method params:xParams videos:videos];
}

/// GET响应式请求
/// @param method 接口名称
/// @param parameters 参数
- (RACSignal *)racGETWithMethod:(NSString *)method
                 withParameters:(NSMutableDictionary *)parameters{
    NSMutableDictionary *xParams = [[XNetworkManager defaultManager] encryptRegisterWithParameters:parameters];
    return [[[[XBaseRACRequest rac_GET:method params:xParams]
              map:^id(RACTuple *value) {
                  return value;
              }] catch:^(NSError *error) {
                  return [RACSignal error:error];
              }] replayLazily];
}

///  POST响应式请求
/// @param method 接口名称
/// @param parameters 参数
- (RACSignal *)racPOSTWithMethod:(NSString *)method
                  withParameters:(NSMutableDictionary *)parameters{
    NSMutableDictionary *xParams = [[XNetworkManager defaultManager] encryptRegisterWithParameters:parameters];
    return [[[[XBaseRACRequest rac_POST:method params:xParams]
              map:^id(RACTuple *value) {
                  return value;
              }] catch:^(NSError *error) {
                  return [RACSignal error:error];
              }] replayLazily];
}

@end
