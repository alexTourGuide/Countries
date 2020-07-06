//
//  CoutryTableViewController.m
//  Countries
//
//  Created by Alexander Porshnev on 7/5/20.
//  Copyright © 2020 Alexander Porshnev. All rights reserved.
//

#import "CoutryTableViewController.h"
#import "CountryTableViewCell.h"
#import "CountryService.h"
#import "CountryItem.h"
#import "CountryJSONParser.h"
#import "InfoCountryViewController.h"

static NSString *kTableViewIndentifier = @"kTableViewIndentifier";

@interface CoutryTableViewController ()

@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;
@property (nonatomic, strong) NSArray<CountryItem *> *dataSource;
@property (strong, nonatomic) CountryService *countryService;

@end

@implementation CoutryTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self fillInitialDataSource];
    self.title = @"List of countries";
    self.dataSource = [NSArray new];
    self.countryService = [[CountryService alloc] initWithParser:[CountryJSONParser new]];
    [self.tableView registerClass:CountryTableViewCell.class forCellReuseIdentifier:kTableViewIndentifier];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self addActivityIndicator];
    [self startLoading];
}

- (void)startLoading {
    __weak typeof(self) weakSelf = self;
    [self.activityIndicator startAnimating];
    [self.countryService loadCountries:^(NSArray<CountryItem *> *countries, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (error) {
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error"
                                                                                         message:[NSString stringWithFormat:@"%@", error]
                                                                                  preferredStyle:UIAlertControllerStyleAlert];
                [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
                [weakSelf presentViewController:alertController animated:YES completion:nil];
            } else {
                weakSelf.dataSource = countries;
                [weakSelf.tableView reloadData];
            }
            [weakSelf.activityIndicator stopAnimating];
        });
    }];
}

- (void)addActivityIndicator {
    self.activityIndicator = [UIActivityIndicatorView new];
    self.activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleLarge;
    [self.view addSubview:self.activityIndicator];
    self.activityIndicator.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [self.activityIndicator.centerYAnchor constraintEqualToAnchor:self.tableView.centerYAnchor],
        [self.activityIndicator.centerXAnchor constraintEqualToAnchor:self.tableView.centerXAnchor]
    ]];
}

- (void)loadImageForIndexPath:(NSIndexPath *)indexPath {
    __weak typeof(self) weakSelf = self;
    CountryItem *country = self.dataSource[indexPath.item];
    // Вызываем у countryService метод загрузки изображения по loadImageForURL:country.countryNamePartOfURL - и комлпишн, куда возвращается имейдж
    [self.countryService loadImageForURL:country.countryNamePartOfURL completion:^(UIImage *image) {
        dispatch_async(dispatch_get_main_queue(), ^{
            // UIImage *image мы устанавливаем в массив dataSource
            weakSelf.dataSource[indexPath.item].flagImage = image;
            // и перезагружаем ячейку по indexPath
            [weakSelf.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        });
    }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CountryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kTableViewIndentifier forIndexPath:indexPath];
    
    CountryItem *country = self.dataSource[indexPath.item];
    if (!country.flagImage) {
        [self loadImageForIndexPath:indexPath];
    }
    
    [cell configureWithCountry:country];
    
    return cell;
}


#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.navigationController pushViewController:[[InfoCountryViewController alloc] initWithPartOfURL:self.dataSource[indexPath.row].countryNamePartOfURL] animated:YES];
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    CountryItem *country = self.dataSource[indexPath.item];
    [self.countryService cancelDownloadingForUrl:country.countryNamePartOfURL];
}


#pragma mark - Data source init

- (void)fillInitialDataSource {
    self.dataSource = [NSMutableArray arrayWithArray:@[
        [[CountryItem alloc] initWithName:@"Belarus" capital:@"Minsk"],
        [[CountryItem alloc] initWithName:@"Russia" capital:@"Moskaw"],
        [[CountryItem alloc] initWithName:@"Poland" capital:@"Warsawa"],
        [[CountryItem alloc] initWithName:@"Germany" capital:@"Berlin"],
        [[CountryItem alloc] initWithName:@"Austria" capital:@"Vienna"],
    ]];
}

@end
