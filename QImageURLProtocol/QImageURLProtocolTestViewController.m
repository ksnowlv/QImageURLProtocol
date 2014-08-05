//
//  QImageURLProtocolTestViewController.m
//  QImageURLProtocol
//
//  Created by ksnowlv on 14-8-5.
//  Copyright (c) 2014年 alibaba. All rights reserved.
//

#import "QImageURLProtocolTestViewController.h"
#import "QImageURLProtocol.h"

@interface QImageURLProtocolTestViewController ()

@property(nonatomic, strong) NSOperationQueue *imageDownloadQueue;
@property(nonatomic, strong) IBOutlet UIImageView *imageView;
@end

@implementation QImageURLProtocolTestViewController

//- (id)init
//{
//    self = [super init];
//    
//    if (self) {
//    }
//    
//    return self;
//}

- (void)dealloc
{
    [NSURLProtocol unregisterClass:[QImageURLProtocol class]];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [NSURLProtocol registerClass:[QImageURLProtocol class]];
    _imageDownloadQueue = [[NSOperationQueue alloc] init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)requestImageEvent:(id)sender
{
    NSURLRequest *request = [ NSURLRequest requestWithURL:[NSURL URLWithString:KPicAURL]];
    [NSURLConnection sendAsynchronousRequest:request queue:_imageDownloadQueue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if (nil == connectionError) {
            
            UIImage *image = [UIImage imageWithData:data];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                _imageView.image = image;
            });
        }
        
    }];
}

@end
