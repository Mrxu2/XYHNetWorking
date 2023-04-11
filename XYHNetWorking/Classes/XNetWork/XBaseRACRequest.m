//
//  XBaseRACRequest.m
//  XYHRACNetWork
//
//  Created by xyh on 2023/2/11.
//

#import "XBaseRACRequest.h"
#import "XMacro.h"
#import <AFNetworking/AFURLRequestSerialization.h>

@implementation XBaseRACRequest

//请求时，可以使用它来构造HTTP主体。默认值为nil。可进行token的加密处理
- (AFConstructingBlock)constructingBodyBlock {
    __weak typeof(self) weakSelf = self;
    if (_image) {
        return ^(id<AFMultipartFormData> formData) {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            NSData *data = UIImageJPEGRepresentation(strongSelf.image, 0.9);
            NSString *fileName = [NSString stringWithFormat:@"%@.png", [XBaseRACRequest _fileName]];
            NSString *name = @"files";
            NSString *type = @"image/jpeg";
            [formData appendPartWithFileData:data name:name fileName:fileName mimeType:type];
        };
    } else if (_videos){
        return ^(id<AFMultipartFormData> formData) {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            for (NSInteger i = 0; i < strongSelf.videos.count; i ++) {
                NSData * data = strongSelf.videos[i];
                NSString *fileName = [NSString stringWithFormat:@"%@.mp4", [XBaseRACRequest _fileName]];
                NSString *name = [NSString stringWithFormat:@"file%@", @(i + 1)];
                NSString *type = @"application/octet-stream";
                [formData appendPartWithFileData:data name:name fileName:fileName mimeType:type];
            }
            
        };
    } else if (_images){
        return ^(id<AFMultipartFormData> formData) {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            for (NSInteger i = 0; i < strongSelf.images.count; i ++) {
                UIImage * image = strongSelf.images[i];
                NSData *data = UIImageJPEGRepresentation(image, 0.9);
                NSString *fileName = [NSString stringWithFormat:@"%@.png", [XBaseRACRequest _fileName]];
                NSString *name = [NSString stringWithFormat:@"file%@", @(i + 1)];
                NSString *type = @"image/jpeg";
                [formData appendPartWithFileData:data name:name fileName:fileName mimeType:type];
            }
        };
    } else if (_imageDict) {
        return ^(id<AFMultipartFormData> formData) {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            NSArray *keys = strongSelf.imageDict.allKeys;
            for (NSInteger i = 0; i < keys.count; i ++) {
                NSString *key = keys[i];
                UIImage *image = strongSelf.imageDict[key];
                NSData *data = UIImageJPEGRepresentation(image, 0.9);
                NSString *fileName = [NSString stringWithFormat:@"%@.png", key];
                NSString *type = @"image/jpeg";
                [formData appendPartWithFileData:data name:key fileName:fileName mimeType:type];
            }
        };
    } else {
        return nil;
    }
}

/// 请求的接口
- (NSString *)requestUrl {
    return self.racPathURL;
}

/// 请求的数据类型
- (YTKRequestSerializerType)requestSerializerType {
    return YTKRequestSerializerTypeHTTP;
}

/// 请求的方式
- (YTKRequestMethod)requestMethod {
    if ([self.racMethod isEqualToString:@"GET"]) {
        return YTKRequestMethodGET;
    }
    
    if ([self.racMethod isEqualToString:@"HEAD"]) {
        return YTKRequestMethodHEAD;
    }
    
    if ([self.racMethod isEqualToString:@"POST"])  {
        return YTKRequestMethodPOST;
    }
    
    if ([self.racMethod isEqualToString:@"PUT"])
    {
        return YTKRequestMethodPUT;
    }
    
    if ([self.racMethod isEqualToString:@"PATCH"])
    {
        return YTKRequestMethodPATCH;
    }
    
    if ([self.racMethod isEqualToString:@"DELETE"])
    {
        return YTKRequestMethodDELETE;
    }
    
    return YTKRequestMethodPOST;
}

/// 返回请求的参数
- (NSDictionary *)requestArgument {
    return self.racParameters;
}

/// 设置请求超时时间
- (NSTimeInterval)requestTimeoutInterval {
    return 10;
}

/// 缓存时间
- (NSInteger)cacheTimeInSeconds {
    return 0;
}

- (void)dealloc {
    NSLog(@"%@ is dealloc",NSStringFromClass([self class]));
}

#pragma mark - Private Methods

+ (NSString *)_fileName {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyyMMddHHmmss";
    return [formatter stringFromDate:[NSDate date]];
}

@end
