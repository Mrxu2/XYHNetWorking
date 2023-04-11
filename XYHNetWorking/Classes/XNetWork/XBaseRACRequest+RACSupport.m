//
//  XBaseRACRequest+RACSupport.m
//  XYHRACNetWork
//
//  Created by xyh on 2023/2/11.
//

#import "XBaseRACRequest+RACSupport.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import "ApiResultModel.h"
#import "XMacro.h"
#import <MJExtension/MJExtension.h>
#import "XNetworkManager.h"

@implementation XBaseRACRequest (RACSupport)


/// 上传图片
+ (RACSignal *)rac_POST:(NSString *)path
                 params:(id)params
                  image:(UIImage *)image {
    return [[XBaseRACRequest rac_requestPath:path method:@"POST" params:params withImages:@[image]]
            setNameWithFormat:@"%@ -rac_POST: %@, params: %@, image:", self.class, path, params];
}

/// 上传多图
+ (RACSignal *)rac_POST:(NSString *)path
                 params:(id)params
                 images:(NSArray *)images {
    return [[XBaseRACRequest rac_requestPath:path method:@"POST" params:params withImages:images]
            setNameWithFormat:@"%@ -rac_POST: %@, params: %@, images:", self.class, path, params];
}

/// 上传多图
+ (RACSignal *)rac_POST:(NSString *)path
                 params:(id)params
              imageDict:(NSDictionary<NSString *, UIImage *> *)imageDict {
    return [[XBaseRACRequest rac_requestPath:path method:@"POST" params:params imageDict:imageDict]
            setNameWithFormat:@"%@ -rac_POST: %@, params: %@, imageDict:", self.class, path, params];
}

/// 上传视频
+ (RACSignal *)rac_POST:(NSString *)path
                 params:(id)params
                 videos:(NSArray *)videos {
    return [[XBaseRACRequest rac_requestPath:path method:@"POST" params:params videos:videos]
            setNameWithFormat:@"%@ -rac_POST: %@, params: %@, videos:", self.class, path, params];
}

/// GET
+ (RACSignal *)rac_GET:(NSString *)path params:(id)params {
    return [[XBaseRACRequest rac_requestPath:path params:params method:@"GET"]
            setNameWithFormat:@"%@ -rac_GET: %@, params: %@", self.class, path, params];
}

/// POST
+ (RACSignal *)rac_POST:(NSString *)path
                 params:(id)params {
    return [[XBaseRACRequest rac_requestPath:path params:params method:@"POST"]
            setNameWithFormat:@"%@ -rac_POST: %@, params: %@", self.class, path, params];
}
/// GET - BLOCK
+ (void)rac_GET:(NSString *)path params:(id)params withBlock:(void (^)(id result))block{
    [XBaseRACRequest rac_requestPath:path params:params method:@"GET" withBlock:block];
}

/// POST - BLOCK
+ (void)rac_POST:(NSString *)path
                 params:(id)params withBlock:(void (^)(id result))block{
    return [XBaseRACRequest rac_requestPath:path params:params method:@"POST" withBlock:block];
}

/// HEAD
+ (RACSignal *)rac_HEAD:(NSString *)path params:(id)params {
    return [[XBaseRACRequest rac_requestPath:path params:params method:@"HEAD"]
            setNameWithFormat:@"%@ -rac_HEAD: %@, params: %@", self.class, path, params];
}

/// 上传数据
+ (RACSignal *)rac_POST:(NSString *)path
                 params:(id)params
constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block {
    return [[RACSignal createSignal:^(id<RACSubscriber> subscriber) {
        
        XBaseRACRequest * request = [XBaseRACRequest new];
        
        request.racPathURL = path;
        request.racMethod  = @"POST";
        request.racParameters = params;
        
        [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
            
        } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
            
        }];
        
        return [RACDisposable disposableWithBlock:^{
            [request stop];
        }];
        
        
    }] setNameWithFormat:@"%@ -rac_POST: %@, parameters: %@, constructingBodyWithBlock:", self.class, path, params];
    ;
}

/// PUT
+ (RACSignal *)rac_PUT:(NSString *)path params:(id)params {
    return [[XBaseRACRequest rac_requestPath:path params:params method:@"PUT"]
            setNameWithFormat:@"%@ -rac_PUT: %@, params: %@", self.class, path, params];
}

/// PATCH
+ (RACSignal *)rac_PATCH:(NSString *)path params:(id)params {
    return [[XBaseRACRequest rac_requestPath:path params:params method:@"PATCH"]
            setNameWithFormat:@"%@ -rac_PATCH: %@, params: %@", self.class, path, params];
}

/// DELETE
+ (RACSignal *)rac_DELETE:(NSString *)path params:(id)params {
    return [[XBaseRACRequest rac_requestPath:path params:params method:@"DELETE"]
            setNameWithFormat:@"%@ -rac_DELETE: %@, params: %@", self.class, path, params];
}

+ (RACSignal *)rac_requestPath:(NSString *)path
                        params:(id)params
                        method:(NSString *)method {

    return [RACSignal createSignal:^(id<RACSubscriber> subscriber) {

        XBaseRACRequest * req = [XBaseRACRequest new];

        req.racPathURL = path;
        req.racMethod  = method;
        req.racParameters = params;

        [req startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {

            [XBaseRACRequest ALTKLogWithRequest:request];
            [XBaseRACRequest requestResultSuccessWithRequest:request subscribe:subscriber];
            
        } failure:^(__kindof YTKBaseRequest * _Nonnull request) {

            [XBaseRACRequest ALTKLogWithRequest:request];
            [XBaseRACRequest requestResultFailureWithRequest:request subscribe:subscriber isNetError:YES];
        }];

        return [RACDisposable disposableWithBlock:^{
            //信号结束停止请求
            [req stop];
        }];
    }];
}


+ (void)rac_requestPath:(NSString *)path
                        params:(id)params
                        method:(NSString *)method withBlock:(void (^)(id result))block{

    XBaseRACRequest * req = [XBaseRACRequest new];
    req.racPathURL = path;
    req.racMethod  = method;
    req.racParameters = params;
    [req startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {

        [XBaseRACRequest ALTKLogWithRequest:request];
        if(block){
            block([XBaseRACRequest requestResultSuccessWithRequest:request]);
        }
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [XBaseRACRequest ALTKLogWithRequest:request];
        if(block){
            block([XBaseRACRequest requestResultSuccessWithRequest:request]);
        }
//        [XBaseRACRequest ALTKLogWithRequest:request];
//        id requestData = [XBaseRACRequest requestResultFailureWithRequest:request isNetError:YES];
    }];
}

#pragma mark - private

/// 上传视频
+ (RACSignal *)rac_requestPath:(NSString *)path
                        method:(NSString *)method
                        params:(id)params
                    videos:(NSArray *)videos {
    return [RACSignal createSignal:^(id<RACSubscriber> subscriber) {
        
        XBaseRACRequest * req = [XBaseRACRequest new];
        
        req.racPathURL = path;
        req.racMethod  = method;
        req.racParameters = params;
        req.videos = videos;
        
        [req startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
            
            [self ALTKLogWithRequest:request];
            
            [XBaseRACRequest requestResultSuccessWithRequest:request subscribe:subscriber];
        } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
            
            [self ALTKLogWithRequest:request];
            
            [XBaseRACRequest requestResultFailureWithRequest:request subscribe:subscriber isNetError:YES];
        }];
        
        return [RACDisposable disposableWithBlock:^{
            //信号结束停止请求
            [req stop];
        }];
    }];
}

/// 上传单图
+ (RACSignal *)rac_requestPath:(NSString *)path
                        method:(NSString *)method
                        params:(id)params
                     withImage:(UIImage *)image {
    
    return [RACSignal createSignal:^(id<RACSubscriber> subscriber) {
        
        XBaseRACRequest * req = [XBaseRACRequest new];
        
        req.racPathURL = path;
        req.racMethod  = method;
        req.racParameters = params;
        req.image = image;
        
        [req startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
            
            [self ALTKLogWithRequest:request];
            
            [XBaseRACRequest requestResultSuccessWithRequest:request subscribe:subscriber];
        } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
            
            [self ALTKLogWithRequest:request];
            
            [XBaseRACRequest requestResultFailureWithRequest:request subscribe:subscriber isNetError:YES];
        }];
        
        return [RACDisposable disposableWithBlock:^{
            //信号结束停止请求
            [req stop];
        }];
    }];
}

/// 上传多图
+ (RACSignal *)rac_requestPath:(NSString *)path
                        method:(NSString *)method
                        params:(id)params
                    withImages:(NSArray *)images {
    
    return [RACSignal createSignal:^(id<RACSubscriber> subscriber) {
        
        XBaseRACRequest * req = [XBaseRACRequest new];
        
        req.racPathURL = path;
        req.racMethod  = method;
        req.racParameters = params;
        req.images = images;
        
        [req startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
            
            [self ALTKLogWithRequest:request];
            
            [XBaseRACRequest requestResultSuccessWithRequest:request subscribe:subscriber];
        } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
            
            [self ALTKLogWithRequest:request];
            
            [XBaseRACRequest requestResultFailureWithRequest:request subscribe:subscriber isNetError:YES];
        }];
        
        return [RACDisposable disposableWithBlock:^{
            //信号结束停止请求
            [req stop];
        }];
    }];
}


/// 上传多图
+ (RACSignal *)rac_requestPath:(NSString *)path
                        method:(NSString *)method
                        params:(id)params
                     imageDict:(NSDictionary<NSString *, UIImage *> *)imageDict {
    return [RACSignal createSignal:^(id<RACSubscriber> subscriber) {
        
        XBaseRACRequest *req = [XBaseRACRequest new];
        
        req.racPathURL = path;
        req.racMethod  = method;
        req.racParameters = params;
        req.imageDict = imageDict;
        
        [req startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
            
            [self ALTKLogWithRequest:request];
            
            [XBaseRACRequest requestResultSuccessWithRequest:request subscribe:subscriber];
        } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
            
            [self ALTKLogWithRequest:request];

            [XBaseRACRequest requestResultFailureWithRequest:request subscribe:subscriber isNetError:YES];
        }];
        
        return [RACDisposable disposableWithBlock:^{
            //信号结束停止请求
            [req stop];
        }];
    }];
}

+ (void)requestResultSuccessWithRequest:(YTKBaseRequest *)request subscribe:(id<RACSubscriber>)subscriber {
    
    [subscriber sendNext:[XBaseRACRequest requestResultSuccessWithRequest:request]];
    [subscriber sendCompleted];
//    if ([TKResponseSuccessCode isEqualToString:NSStringFormat(@"%@", responseObject[@"code"])]) {
//
//        [subscriber sendNext:request.responseObject];
//        [subscriber sendCompleted];
//    } else {
//        [XBaseRACRequest requestResultFailureWithRequest:request subscribe:subscriber isNetError:NO];
//    }
}


+ (id)requestResultSuccessWithRequest:(YTKBaseRequest *)request {
    
    NSDictionary *responseObject = [request.responseObject copy];
    NSString *code = responseObject[@"code"];
    NSString *msg = responseObject[@"msg"];
    NSString *urlString = request.currentRequest.URL.absoluteString;

    ApiResultModel *model = [[ApiResultModel alloc]init];
    model.message = msg;
    model.code = code;
    model.method = urlString;
    model.returnData = responseObject;
    return model;
//    if ([TKResponseSuccessCode isEqualToString:NSStringFormat(@"%@", responseObject[@"code"])]) {
//        return responseObject;
//    } else {
//        return [XBaseRACRequest requestResultFailureWithRequest:request isNetError:NO];;
//    }
}

#warning 此处需要根据后端字段，指定msg和code
+ (void)requestResultFailureWithRequest:(YTKBaseRequest *)request
                              subscribe:(id<RACSubscriber>)subscriber
                             isNetError:(BOOL)isNetError {
    [subscriber sendNext:[XBaseRACRequest requestResultSuccessWithRequest:request]];
    [subscriber sendCompleted];
//    [subscriber sendError:[XBaseRACRequest requestResultFailureWithRequest:request isNetError:isNetError]];
//    [subscriber sendCompleted];
}

#pragma mark - log

+ (void)ALTKLogWithRequest:(YTKBaseRequest *)request {
    if([XNetworkManager  defaultManager].isOpenApiLog){
        NSMutableDictionary *bodyParam = [[request requestArgument] mutableCopy];
        NSString *urlString = request.currentRequest.URL.absoluteString;
        id requestBody = bodyParam.allValues.count ? bodyParam : @"请求体为空";
        id responseObject = request.responseObject;
        TKLog(@"【接口】- %@\n【参数】\n%@\n【响应结果】\n%@", urlString, requestBody, [responseObject mj_JSONString]);
    }
}

- (void)dealloc {
    TKLog(@"%@ is dealloc",NSStringFromClass([self class]));
}

@end
