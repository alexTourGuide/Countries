//
//  CountryJSONParser.m
//  Countries
//
//  Created by Alexander Porshnev on 7/5/20.
//  Copyright © 2020 Alexander Porshnev. All rights reserved.
//

#import "CountryJSONParser.h"
#import "CountryItem.h"

@implementation CountryJSONParser

- (void)parseCountries:(NSData *)data completion:(void (^)(NSArray<CountryItem *> *, NSError *))completion {
    NSError *error;
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    
    if (error) {
        completion(nil, error);
        return;
    }
    NSArray *array = dictionary[@"parse"][@"images"];
    NSMutableArray<CountryItem *> *countries = [NSMutableArray new];
    for (NSString *item in array) {
        [countries addObject:[[CountryItem alloc] initWithItem:item]];
    }
    [countries removeObjectAtIndex:0];
    completion(countries, nil);
}

@end
