//
//  UIImage+image.m
//  微博个人详情界面
//
//  Created by 熊欣 on 16/6/13.
//  Copyright © 2016年 熊欣. All rights reserved.
//

#import "UIImage+image.h"

@implementation UIImage (image)

+ (UIImage *)imageWithColor:(UIColor *)color
{
    // ----先设定一个矩形
    CGRect rect = CGRectMake(0, 0, 1, 1);
    
    // ----开启图形上下文
    UIGraphicsBeginImageContext(rect.size);
    // ----获取图形上下文
    CGContextRef ref = UIGraphicsGetCurrentContext();
    // ----填充颜色
    CGContextSetFillColorWithColor(ref, color.CGColor);
    // ----渲染上下文
    CGContextFillRect(ref, rect);
    
    // ----新建一个图形对象从图形上下文
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // ----结束图形上下文
    UIGraphicsEndImageContext();
    
    return newImage;
    
}

@end
