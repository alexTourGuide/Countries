//
//  FlagDownloadOperation.h
//  Countries
//
//  Created by Alexander Porshnev on 7/6/20.
//  Copyright © 2020 Alexander Porshnev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FlagDownloadOperation : NSOperation

@property (nonatomic, strong) UIImage *image;
@property (nonatomic, copy) void(^completion)(UIImage *);

- (instancetype)initWithUrl:(NSString *)url;

@end

NS_ASSUME_NONNULL_END
