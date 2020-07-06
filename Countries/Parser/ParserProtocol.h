//
//  ParserProtocol.h
//  Countries
//
//  Created by Alexander Porshnev on 7/5/20.
//  Copyright © 2020 Alexander Porshnev. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CountryItem;

NS_ASSUME_NONNULL_BEGIN

@protocol ParserProtocol <NSObject>

- (void)parseCountries:(NSData *)data completion:(void(^)(NSArray<CountryItem *> *, NSError *))completion;

@end

NS_ASSUME_NONNULL_END
