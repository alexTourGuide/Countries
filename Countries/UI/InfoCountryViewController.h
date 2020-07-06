//
//  InfoCountryViewController.h
//  Countries
//
//  Created by Alexander Porshnev on 7/5/20.
//  Copyright © 2020 Alexander Porshnev. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface InfoCountryViewController : UIViewController

@property (nonatomic, strong) NSString *url;

- (instancetype)initWithPartOfURL:(NSString *)partOfURL;

@end

NS_ASSUME_NONNULL_END
