//
//  XNetworkManager.h
//  XYHRACNetWork
//
//  Created by xyh on 2023/2/11.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <ReactiveObjC/ReactiveObjC.h>
#import "ApiResultModel.h"

typedef NS_ENUM(NSInteger, XReachabilityStatus) {
    XReachabilityStatusUnknown          = -1,
    XReachabilityStatusNotReachable     = 0,
    XReachabilityStatusReachableViaWWAN = 1,
    XReachabilityStatusReachableViaWiFi = 2,
};

NS_ASSUME_NONNULL_BEGIN

@class RACSignal;
@class ApiResultModel;

@interface XNetworkManager : NSObject
@property(nonatomic,assign)BOOL isOpenApiLog;//是否开启接口日志
//当前网络状态
+ (XReachabilityStatus)getXReachabilityStatus;

+ (XNetworkManager *)defaultManager;


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
                appVersion:(NSString *)appVersion;


/// 创建检查网络信号
- (RACSignal *)startMonitoringNet;


/// GET接口调用-Block
/// @param method 接口名称
/// @param parameters 参数
/// @param block <#block description#>
- (void)httpGetWithMethod:(NSString *)method
           withParameters:(NSMutableDictionary *)parameters
                withBlock:(void (^)(ApiResultModel *result))block;


/// POST接口调用-Block
/// @param method 接口名称
/// @param parameters 参数
/// @param block <#block description#>
- (void)httpPostWithMethod:(NSString *)method
            withParameters:(NSMutableDictionary *)parameters
                 withBlock:(void (^)(ApiResultModel *result))block;


/// 上传图片
/// @param image 图片
/// @param method 接口名称
/// @param params <#params description#>
+ (RACSignal *)uploadImage:(UIImage *)image
                    Method:(NSString *)method
                    params:(NSDictionary *)params;



/// 上传多图 - 随机生成图片上传的表单名
/// @param images 图片数组
/// @param method 接口名称
/// @param params <#params description#>
+ (RACSignal *)uploadImages:(NSArray *)images
                     Method:(NSString *)method
                     params:(NSDictionary *)params;


/// 上传多图
/// @param imageDict 图片字典-key位表单名称
/// @param method 接口名称
/// @param params <#params description#>
+ (RACSignal *)uploadImageDict:(NSDictionary<NSString *, UIImage *> *)imageDict
                        Method:(NSString *)method
                        params:(NSDictionary *)params;


/// 上传视频
/// @param videos 视频数组
/// @param method 接口名称
/// @param params <#params description#>
+ (RACSignal *)uploadVideos:(NSArray *)videos
                     Method:(NSString *)method
                     params:(NSDictionary *)params;

/// GET响应式请求
/// @param method 接口名称
/// @param parameters 参数
- (RACSignal *)racGETWithMethod:(NSString *)method
                 withParameters:(NSMutableDictionary *)parameters;

///  POST响应式请求
/// @param method 接口名称
/// @param parameters 参数
- (RACSignal *)racPOSTWithMethod:(NSString *)method
                  withParameters:(NSMutableDictionary *)parameters;
@end

NS_ASSUME_NONNULL_END
