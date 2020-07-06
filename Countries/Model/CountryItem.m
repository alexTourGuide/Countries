//
//  CountryItem.m
//  Countries
//
//  Created by Alexander Porshnev on 7/5/20.
//  Copyright © 2020 Alexander Porshnev. All rights reserved.
//

#import "CountryItem.h"

@implementation CountryItem

- (instancetype)initWithName:(NSString *)countyName capital:(nonnull NSString *)countryCapital {
    self = [super init];
    if (self) {
        _countryName = countyName;
        _countryCapital = countryCapital;
    }
    return self;
}

- (instancetype)initWithItem:(NSString *)item {
    self = [super init];
    if (self) {
        _countryName = [self countryNameFromItem:item];
        _countryNamePartOfURL = [self countryNamePartOfURLFromItem:item];
    }
    return self;
}

- (NSString *)countryNameFromItem:(NSString *)item {
    NSMutableString *countryName = [item mutableCopy];
    [countryName replaceOccurrencesOfString:@"Flag_of_" withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, countryName.length)];
    [countryName replaceOccurrencesOfString:@".svg" withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, countryName.length)];
    [countryName replaceOccurrencesOfString:@"the_" withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, countryName.length)];
    [countryName replaceOccurrencesOfString:@"_" withString:@" " options:NSCaseInsensitiveSearch range:NSMakeRange(0, countryName.length)];
    
    
    NSRange openBracket = [countryName rangeOfString:@"("];
    NSRange closeBracket = [countryName rangeOfString:@")"];
    if (!(openBracket.location == NSNotFound) && !(closeBracket.location == NSNotFound)) {
        [countryName deleteCharactersInRange:NSMakeRange(openBracket.location-1, closeBracket.location-openBracket.location+2)];
        return countryName;
    }
    
    return countryName;
}

- (NSString *)countryNamePartOfURLFromItem:(NSString *)item {
    NSMutableString *countryName = [item mutableCopy];
    [countryName replaceOccurrencesOfString:@"Flag_of_" withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, countryName.length)];
    [countryName replaceOccurrencesOfString:@".svg" withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, countryName.length)];
    [countryName replaceOccurrencesOfString:@"the_" withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, 4)];
    
    NSRange openBracket = [countryName rangeOfString:@"("];
    NSRange closeBracket = [countryName rangeOfString:@")"];
    if (!(openBracket.location == NSNotFound) && !(closeBracket.location == NSNotFound)) {
        [countryName deleteCharactersInRange:NSMakeRange(openBracket.location-1, closeBracket.location-openBracket.location+2)];
        NSString *lowercaceStr = [countryName localizedLowercaseString];
        return lowercaceStr;
    }
    
    NSString *lowercaceStr = [countryName localizedLowercaseString];
    return lowercaceStr;
}

@end
