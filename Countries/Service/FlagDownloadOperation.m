//
//  FlagDownloadOperation.m
//  Countries
//
//  Created by Alexander Porshnev on 7/6/20.
//  Copyright © 2020 Alexander Porshnev. All rights reserved.
//

#import "FlagDownloadOperation.h"

@interface FlagDownloadOperation ()

@property (nonatomic, copy) NSString *url;

@end

@implementation FlagDownloadOperation

- (instancetype)initWithUrl:(NSString *)url {
    self = [super init];
    if (self) {
        _url = url;
    }
    return self;
}

- (void)main {
    __weak typeof(self) weakSelf = self;
    // т.к. операции у нас отменяются - мы должны проверять не отменена ли операция
    if (self.isCancelled) { return; }

    // Задаем URL из переданной стринги (которую мы получили из словаря по JSON)
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://ostranah.ru/media/flags/%@_flag.gif", self.url]];
    // Создаем NSURLSessionDataTask *dataTask с помощью [NSURLSession sharedSession]
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession]
                                      dataTaskWithURL:url
                                      completionHandler:^(NSData *data,
                                                          NSURLResponse *response,
                                                          NSError * error) {
        // т.к. операции у нас отменяются - мы должны проверять не отменена ли операция
        if (weakSelf.isCancelled) { return; }
        // если дата не пришла - возвращаемся из функции
        if (!data) { return; }
        // создаем изображение из imageWithData:data
        UIImage *image = [UIImage imageWithData:data];
        if (!image) { return; }
        // Устанавливаем изображение в проперти
        weakSelf.image = image;
        // в комплишн передаем image
        if (self.completion) {
            self.completion(image);
        }
    }];

    // т.к. операции у нас отменяются - мы должны проверять не отменена ли операция
    if (self.isCancelled) { return; }
    // запускаем dataTask
    [dataTask resume];
}

@end
