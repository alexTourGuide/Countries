//
//  CountryTableViewCell.h
//  Countries
//
//  Created by Alexander Porshnev on 7/5/20.
//  Copyright © 2020 Alexander Porshnev. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CountryItem;

NS_ASSUME_NONNULL_BEGIN

@interface CountryTableViewCell : UITableViewCell

- (void)configureWithCountry:(CountryItem *)country;

@end

NS_ASSUME_NONNULL_END
