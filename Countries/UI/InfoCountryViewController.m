//
//  InfoCountryViewController.m
//  Countries
//
//  Created by Alexander Porshnev on 7/5/20.
//  Copyright © 2020 Alexander Porshnev. All rights reserved.
//

#import "InfoCountryViewController.h"
#import <WebKit/WebKit.h>

@interface InfoCountryViewController () <WKNavigationDelegate>

@property (nonatomic, strong) WKWebView *webView;

@end

@implementation InfoCountryViewController

- (instancetype)initWithPartOfURL:(NSString *)partOfURL {
    self = [super init];
    if (self) {
        _url = [NSString stringWithFormat:@"https://en.wikipedia.org/wiki/%@", partOfURL];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupViews];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self loadPage];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.webView stopLoading];
}

#pragma mark - Setups

- (void)setupViews {
    self.webView = [WKWebView new];
    [self.view addSubview:self.webView];
    self.webView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [self.webView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
        [self.webView.topAnchor constraintEqualToAnchor:self.view.topAnchor],
        [self.webView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
        [self.webView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor],
    ]];
    
    self.webView.navigationDelegate = self;
}

#pragma mark - Helpers

- (void)loadPage {
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
    [self.webView allowsBackForwardNavigationGestures];
}

#pragma mark - WKNavigationDelegate methods

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    self.title = webView.title;
}


@end
