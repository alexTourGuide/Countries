//
//  CountryItem.h
//  Countries
//
//  Created by Alexander Porshnev on 7/5/20.
//  Copyright © 2020 Alexander Porshnev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CountryItem : NSObject

@property (nonatomic, strong) NSString *countryName;
@property (nonatomic, strong) NSString *countryCapital;
@property (nonatomic, strong) NSString *countryNamePartOfURL;
@property (nonatomic, strong) UIImage *flagImage;

- (instancetype)initWithName:(NSString *)countyName capital:(NSString *)countryCapital;
- (instancetype)initWithItem:(NSString *)item;

@end

NS_ASSUME_NONNULL_END
