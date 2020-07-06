//
//  CountryService.m
//  Countries
//
//  Created by Alexander Porshnev on 7/5/20.
//  Copyright © 2020 Alexander Porshnev. All rights reserved.
//

#import "CountryService.h"
#import "FlagDownloadOperation.h"

@interface CountryService ()

@property (nonatomic, strong) NSURLSession *session;
@property (nonatomic, strong) id<ParserProtocol> parser;
@property (strong, nonatomic) NSOperationQueue *queue;
@property (strong, nonatomic) NSMutableDictionary<NSString *, NSArray<NSOperation *> *> *operations;

@end

@implementation CountryService

- (instancetype)initWithParser:(id<ParserProtocol>)parser {
    self = [super init];
    if (self) {
        _parser = parser;
        _queue = [NSOperationQueue new];
        _operations = [NSMutableDictionary new];
    }
    return self;
}

- (NSURLSession *)session {
    if (!_session) {
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        _session = [NSURLSession sessionWithConfiguration:configuration];
    }
    return _session;
}

- (void)loadCountries:(void(^)(NSArray<CountryItem *> *, NSError *))completion {
    NSURL *url = [NSURL URLWithString:@"https://en.wikipedia.org/w/api.php?action=parse&page=Gallery_of_sovereign_state_flags&format=json"];
        
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";

    NSURLSessionDataTask *dataTask = [self.session dataTaskWithRequest:request
                                                     completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error) {
            completion(nil, error);
            return;
        }
        [self.parser parseCountries:data completion:completion];
    }];
    [dataTask resume];
}

// Загружаем картинку по URL
- (void)loadImageForURL:(NSString *)url completion:(void (^)(UIImage *))completion {

    [self cancelDownloadingForUrl:url];
    // оперейшн для загрузки изображения
    FlagDownloadOperation *operation = [[FlagDownloadOperation alloc] initWithUrl:url];
    self.operations[url] = @[operation];
    operation.completion = ^(UIImage *image) {
        completion(image);
    };
    [self.queue addOperation:operation];
}

- (void)cancelDownloadingForUrl:(NSString *)url {
    NSArray<NSOperation *> *operations = self.operations[url];
    if (!operations) { return; }
    for (NSOperation *operation in operations) {
        [operation cancel];
    }
}

@end
