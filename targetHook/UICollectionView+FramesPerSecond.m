//
//  UICollectionView+FramesPerSecond.m
//  AHPerformanceSDKFramework
//
//  Created by dpei on 2/13/19.
//  Copyright © 2019 Autohome. All rights reserved.
//

#import "UICollectionView+FramesPerSecond.h"
#import <objc/runtime.h>

@implementation UICollectionView(FramesPerSecond)

+ (void)load {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        Method originMethod2 = class_getInstanceMethod(NSClassFromString(@"UICollectionViewCellAccessibilityElement"), @selector(accessibilityLabel));
        Method replaceMethod2= class_getInstanceMethod([self class], @selector(newPerformanceAccessibilityLabel));
        if (class_addMethod(NSClassFromString(@"UICollectionViewCellAccessibilityElement"), @selector(newPerformanceAccessibilityLabel), method_getImplementation(replaceMethod2), method_getTypeEncoding(replaceMethod2))) {
            method_exchangeImplementations(originMethod2, replaceMethod2);
        }
        
        Method originMethod3 = class_getInstanceMethod(NSClassFromString(@"UICollectionViewCellAccessibilityElement"), @selector(cell));
        Method replaceMethod3= class_getInstanceMethod([self class], @selector(newPerformanceCell));
        if (class_addMethod(NSClassFromString(@"UICollectionViewCellAccessibilityElement"), @selector(newPerformanceCell), method_getImplementation(replaceMethod3), method_getTypeEncoding(replaceMethod3))) {
            method_exchangeImplementations(originMethod3, replaceMethod3);
        }
    });
    
    
}
-(NSObject *)newPerformanceCell
{
    return nil;
}
-(NSString *)newPerformanceAccessibilityLabel
{
    return @"";
}

@end
