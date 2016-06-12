//
//  XWSandBox.m
//  XWCarCost
//
//  Created by smile.zhang on 15/7/29.
//  Copyright (c) 2015年 Zhang Xiaowei. All rights reserved.
//

#import "XWSandBoxHelper.h"

@implementation XWSandBoxHelper

+ (BOOL)addArray:(NSArray *)arr fileName:(NSString *)fileName{
    if (fileName == nil || arr == nil || arr.count == 0) {
        return NO;
    }
    return [arr writeToFile:[self filePathWithFileName:fileName] atomically:YES];
}

+ (BOOL)addDict:(NSDictionary *)dict fileName:(NSString *)fileName{
    if (fileName == nil || dict == nil) {
        return NO;
    }
    //写进文件列表
    return [dict writeToFile:[self filePathWithFileName:fileName] atomically:YES];
}

+ (NSArray *)arrayWithFile:(NSString *)filePath{
    return [[NSArray alloc] initWithContentsOfFile:filePath];
}

+ (NSDictionary *)dictWithFile:(NSString *)filePath{
    return [[NSDictionary alloc] initWithContentsOfFile:filePath];
}

+ (NSString *)filePathWithFileName:(NSString *)fileName{
    // 取得主路径
    NSString * rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES) objectAtIndex:0];
    // 取得数据plist路径
    return [rootPath stringByAppendingPathComponent:fileName];
}

// 删除沙盒中的文件
+ (BOOL)deleteFile:(NSString *)filePath{
    NSError *err = nil;
    if (nil == filePath) {
        return NO;
    }
    NSFileManager *appFileManager = [NSFileManager defaultManager];
    if (![appFileManager fileExistsAtPath:filePath]) {
        return YES;
    }
    if (![appFileManager isDeletableFileAtPath:filePath]) {
        return NO;
    }
    return [appFileManager removeItemAtPath:filePath error:&err];
}

+ (BOOL)deleteFileWithName:(NSString *)fileName {
    return [self deleteFile:[self filePathWithFileName:fileName]];
}


+ (NSString *)homePath{
    return NSHomeDirectory();
}

+ (NSString *)appPath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSApplicationDirectory, NSUserDomainMask, YES);
    return [paths objectAtIndex:0];
}

+ (NSString *)docPath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [paths objectAtIndex:0];
}

+ (NSString *)libPrefPath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    return [[paths objectAtIndex:0] stringByAppendingFormat:@"/Preference"];
}

+ (NSString *)libCachePath{
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    return [[paths objectAtIndex:0] stringByAppendingFormat:@"/Caches"];
}

+ (NSString *)tmpPath{
    return [NSHomeDirectory() stringByAppendingFormat:@"/tmp"];
}

+ (BOOL)hasLive:(NSString *)path{
    if ([[NSFileManager defaultManager] fileExistsAtPath:path] == NO){
        return [[NSFileManager defaultManager] createDirectoryAtPath:path
                                         withIntermediateDirectories:YES
                                                          attributes:nil
                                                               error:NULL];
    }
    
    return NO;
}
@end
