//
//  QImageURLProtocol.h
//  QImageURLProtocol
//
//  Created by ksnowlv on 14-8-5.
//  Copyright (c) 2014年 alibaba. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 *  用于测试的url
 */
static NSString *KPicBURL = @"http://g.hiphotos.baidu.com/image/h%3D800%3Bcrop%3D0%2C0%2C1280%2C800/sign=ee4c561ac1fdfc03fa78eeb8e404e4e6/a686c9177f3e6709ef8de51b39c79f3df9dc5540.jpg";
static NSString *KPicAURL = @"http://d.hiphotos.baidu.com/image/h%3D800%3Bcrop%3D0%2C0%2C1280%2C800/sign=ee81c70e83cb39dbdec06a56e02d6a56/b812c8fcc3cec3fdcf460491d488d43f869427dd.jpg";


@interface QImageURLProtocol : NSURLProtocol

@end
