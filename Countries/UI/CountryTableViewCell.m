//
//  CountryTableViewCell.m
//  Countries
//
//  Created by Alexander Porshnev on 7/5/20.
//  Copyright © 2020 Alexander Porshnev. All rights reserved.
//

#import "CountryTableViewCell.h"
#import "CountryItem.h"

@interface CountryTableViewCell ()

@property (nonatomic, strong) UILabel *countryNameLabel;
@property (nonatomic, strong) UILabel *capitalNameLabel;
@property (nonatomic, strong) UIImageView *flagImageView;

@end

@implementation CountryTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupViews];
}

#pragma mark - Setup Views

- (void)setupViews {
    self.countryNameLabel = [UILabel new];
    [self addSubview:self.countryNameLabel];
    self.countryNameLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.capitalNameLabel = [UILabel new];
    [self addSubview:self.capitalNameLabel];
    self.capitalNameLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.flagImageView = [UIImageView new];
    [self addSubview:self.flagImageView];
    self.flagImageView.translatesAutoresizingMaskIntoConstraints = NO;
    
    // Activate constraints
    [NSLayoutConstraint activateConstraints:@[
        [self.countryNameLabel.leadingAnchor constraintEqualToAnchor:self.safeAreaLayoutGuide.leadingAnchor constant:15.0],
        [self.countryNameLabel.centerYAnchor constraintEqualToAnchor:self.centerYAnchor],
        
        [self.capitalNameLabel.leadingAnchor constraintEqualToAnchor:self.safeAreaLayoutGuide.leadingAnchor constant:90.0],
        [self.capitalNameLabel.centerYAnchor constraintEqualToAnchor:self.centerYAnchor],
        
        [self.flagImageView.trailingAnchor constraintEqualToAnchor:self.safeAreaLayoutGuide.trailingAnchor constant:-15.0],
        [self.flagImageView.centerYAnchor constraintEqualToAnchor:self.centerYAnchor],
        [self.flagImageView.heightAnchor constraintEqualToAnchor:self.heightAnchor multiplier:0.7],
        [self.flagImageView.widthAnchor constraintEqualToAnchor:self.flagImageView.heightAnchor multiplier:1.4]
    ]];
}

- (void)configureWithCountry:(CountryItem *)country {
    self.countryNameLabel.text = country.countryName;
    self.capitalNameLabel.text = country.countryCapital;
    self.flagImageView.image = country.flagImage ? country.flagImage : [UIImage imageNamed:@"flag_placeholder"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
