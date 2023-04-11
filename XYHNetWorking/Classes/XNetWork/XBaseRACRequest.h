//
//  XBaseRACRequest.h
//  XYHRACNetWork
//
//  Created by xyh on 2023/2/11.
//
#import <UIKit/UIKit.h>
#import <YTKNetwork/YTKNetwork.h>

NS_ASSUME_NONNULL_BEGIN

@interface XBaseRACRequest : YTKRequest

/// 请求接口
@property (nonatomic, copy) NSString *racPathURL;
/// 请求方法
@property (nonatomic, copy) NSString *racMethod;
/// 请求参数
@property (nonatomic, copy) NSDictionary *racParameters;
/// 上传的图片
@property (nonatomic, strong) UIImage *image;
/// 上传的视频
@property (nonatomic, strong) NSArray *videos;
/// 上传的多图。如果后端未指定图片的表单名，则使用该属性。
@property (nonatomic, strong) NSArray *images;
/// 上传多图，key为表单名，value为图片。如果你的后端要求你每张图都有对应的表单名，则使用该属性。
@property (nonatomic, strong) NSDictionary<NSString *, UIImage *> *imageDict;


@end

NS_ASSUME_NONNULL_END
