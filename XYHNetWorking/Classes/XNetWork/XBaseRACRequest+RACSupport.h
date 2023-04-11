//
//  XBaseRACRequest+RACSupport.h
//  XYHRACNetWork
//
//  Created by xyh on 2023/2/11.
//

#import "XBaseRACRequest.h"

NS_ASSUME_NONNULL_BEGIN
@class RACSignal;

extern NSString *const RACAFNResponseObjectErrorKey;

@interface XBaseRACRequest (RACSupport)


/// 上传单张图片
+ (RACSignal *)rac_POST:(NSString *)path
                 params:(id)params
                  image:(UIImage *)image;
/// 上传多图
+ (RACSignal *)rac_POST:(NSString *)path
                 params:(id)params
                 images:(NSArray *)images;
/// 上传多图
/// imageDict：key为图片上传的表单名，value是图片
+ (RACSignal *)rac_POST:(NSString *)path
                 params:(id)params
              imageDict:(NSDictionary<NSString *, UIImage *> *)imageDict;
/// 上传视频
+ (RACSignal *)rac_POST:(NSString *)path
                 params:(id)params
                 videos:(NSArray *)videos;



/// A convenience around -GET:parameters:success:failure: that returns a cold signal of the
/// resulting JSON object and response headers or error.
+ (RACSignal *)rac_GET:(NSString *)path params:(id)params;
/// GET - BLOCK
+ (void)rac_GET:(NSString *)path params:(id)params withBlock:(void (^)(id result))block;

/// A convenience around -HEAD:parameters:success:failure: that returns a cold signal of the
/// resulting JSON object and response headers or error.
+ (RACSignal *)rac_HEAD:(NSString *)path params:(id)params;

/// A convenience around -POST:parameters:success:failure: that returns a cold signal of the
/// result.
+ (RACSignal *)rac_POST:(NSString *)path params:(id)params;
/// POST - BLOCK
+ (void)rac_POST:(NSString *)path
          params:(id)params withBlock:(void (^)(id result))block;

/// A convenience around -POST:parameters:constructingBodyWithBlock:success:failure: that returns a
/// cold signal of the resulting JSON object and response headers or error.
+ (RACSignal *)rac_POST:(NSString *)path
                 params:(id)params
constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block;

/// A convenience around -PUT:parameters:success:failure: that returns a cold signal of the
/// resulting JSON object and response headers or error.
+ (RACSignal *)rac_PUT:(NSString *)path params:(id)params;

/// A convenience around -PATCH:parameters:success:failure: that returns a cold signal of the
/// resulting JSON object and response headers or error.
+ (RACSignal *)rac_PATCH:(NSString *)path params:(id)params;

/// A convenience around -DELETE:parameters:success:failure: that returns a cold signal of the
/// resulting JSON object and response headers or error.
+ (RACSignal *)rac_DELETE:(NSString *)path params:(id)params;

@end

NS_ASSUME_NONNULL_END
