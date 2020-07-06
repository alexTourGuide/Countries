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

#pragma mark - Modify text

- (NSString *)countryNameFromItem:(NSString *)item {
    NSMutableString *countryName = [item mutableCopy];
    
    [self removeBeginningAndEnding:countryName];
    [countryName replaceOccurrencesOfString:@"_" withString:@" " options:NSCaseInsensitiveSearch range:NSMakeRange(0, countryName.length)];
    
    if ([countryName containsString:@"("]) {
        [self removeAdditionalTextInBrackets:countryName];
    }
    return countryName;
}

- (NSString *)countryNamePartOfURLFromItem:(NSString *)item {
    NSMutableString *countryName = [item mutableCopy];
    [self removeBeginningAndEnding:countryName];
    
    if ([countryName containsString:@"("]) {
        [self removeAdditionalTextInBrackets:countryName];
    }
    return [countryName localizedLowercaseString];
}

#pragma mark - Removing helpers

- (NSMutableString *)removeAdditionalTextInBrackets:(NSMutableString *)stringWithBrackets {
    NSRange openBracket = [stringWithBrackets rangeOfString:@"("];
    NSRange closeBracket = [stringWithBrackets rangeOfString:@")"];
    [stringWithBrackets deleteCharactersInRange:NSMakeRange(openBracket.location-1, closeBracket.location-openBracket.location+2)];
    return stringWithBrackets;
}

- (NSMutableString *)removeBeginningAndEnding:(NSMutableString *)stringToBeCutting {
    [stringToBeCutting replaceOccurrencesOfString:@"Flag_of_" withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, stringToBeCutting.length)];
    [stringToBeCutting replaceOccurrencesOfString:@".svg" withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, stringToBeCutting.length)];
    [stringToBeCutting replaceOccurrencesOfString:@"the_" withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, stringToBeCutting.length)];
    return stringToBeCutting;
}

@end
