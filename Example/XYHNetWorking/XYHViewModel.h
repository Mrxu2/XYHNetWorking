//
//  XYHViewModel.h
//  XYHNetWorking_Example
//
//  Created by xyh on 2023/4/11.
//  Copyright © 2023 13779928250@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <XNetworkManager.h>
NS_ASSUME_NONNULL_BEGIN

@interface XYHViewModel : NSObject
@property(nonatomic,strong)RACCommand *refreshCom;
@property(nonatomic,strong)RACSubject *subject;

@end

NS_ASSUME_NONNULL_END
