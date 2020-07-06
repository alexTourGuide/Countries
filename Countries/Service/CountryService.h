//
//  CountryService.h
//  Countries
//
//  Created by Alexander Porshnev on 7/5/20.
//  Copyright © 2020 Alexander Porshnev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ParserProtocol.h"

@class CountryItem;

NS_ASSUME_NONNULL_BEGIN

@interface CountryService : NSObject

- (instancetype)initWithParser:(id<ParserProtocol>)parser;

- (void)loadCountries:(void(^)(NSArray<CountryItem *> *, NSError *))completion;
- (void)loadImageForURL:(NSString *)url completion:(void(^)(UIImage *))completion;
- (void)cancelDownloadingForUrl:(NSString *)url;

@end

NS_ASSUME_NONNULL_END
