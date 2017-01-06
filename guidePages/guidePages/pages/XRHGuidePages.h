//
//  XRHGuidePages.h
//  guidePages
//
//  Created by Apple on 2017/1/6.
//  Copyright © 2017年 mgjr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XRHGuidePages : UIView

@property (strong, nonatomic) NSArray *imageDatas;
@property (copy, nonatomic) void (^buttonAction)();

- (instancetype)initWithImageDatas:(NSArray *)imageDatas completion:(void(^)(void))buttonAction;

@end
