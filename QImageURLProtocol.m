//
//  QImageURLProtocol.m
//  QImageURLProtocol
//
//  Created by ksnowlv on 14-8-5.
//  Copyright (c) 2014年 alibaba. All rights reserved.
//

#import "QImageURLProtocol.h"

@interface QImageURLProtocol ()

@property (nonatomic, strong) NSURLConnection *connection;

@end

@implementation QImageURLProtocol

#pragma mark -----------NSURLProtocol-------------

+(BOOL)canInitWithRequest:(NSURLRequest *)request{
    NSLog(@"----origin request url = %@",request.URL.absoluteString);
    if ([self isQImageURLRequest:request]) {
        return YES;
    }
    return NO;
}

+(NSURLRequest *)canonicalRequestForRequest:(NSURLRequest *)request{
    NSMutableURLRequest *cdnRequest = [request mutableCopy];
    cdnRequest.URL = [self imagesForQImageURL:request.URL];
    //[NSURLProtocol setProperty:@"YES" forKey:@"QImageURL" inRequest:cdnRequest];
    return cdnRequest;
}

- (void)startLoading {
    self.connection = [NSURLConnection connectionWithRequest:[QImageURLProtocol canonicalRequestForRequest:self.request ] delegate:self];
}

- (void)stopLoading {
    [self.connection cancel];
    self.connection = nil;
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    [self.client URLProtocol:self didReceiveResponse:response cacheStoragePolicy:NSURLCacheStorageNotAllowed];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.client URLProtocol:self didLoadData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    [self.client URLProtocolDidFinishLoading:self];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    [self.client URLProtocol:self didFailWithError:error];
}

#pragma mark -----------------private method---------

+(BOOL)isQImageURLRequest:(NSURLRequest*)request{
    if ( [request.URL.host isEqualToString:@"d.hiphotos.baidu.com"]
        //&&nil == [NSURLProtocol propertyForKey:@"QImageURL" inRequest:request]
        )
    {
        NSLog(@"isQImageURLRequest");
        return YES;
    }
    
    return NO;
}


+(NSURL*)imagesForQImageURL:(NSURL*)url{
    //只要是KPicAURL，会被直接替换为KPicBURL
    if ([url.host isEqualToString:@"d.hiphotos.baidu.com" ]
        && [url.absoluteString isEqualToString:KPicAURL ]) {
         NSLog(@"----real request url = %@",KPicBURL);
        return [NSURL URLWithString:KPicBURL];
    };
    
    return url;
}

@end
