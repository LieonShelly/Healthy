//
//  PWStorageManager.m
//  ParallelWorld
//
//  Created by Zhouqingquan on 2017/6/23.
//  Copyright © 2017年 PXSJ. All rights reserved.
//

#import "PWStorageManager.h"




#define kService_PW_UserCenter              @"pw_usercenter"
#define kLogin_Err_Count                    @"pw_login_err_count_for_phone"
#define kLogin_Err_Date                     @"pw_login_err_date_for_phone"
#define kPhone_Verfy_Err_Count              @"pw_verfy_err_count_for_phone"
#define kPhone_Verfy_Err_Date               @"pw_verfy_err_date_for_phone"




#pragma mark - class extension
@interface PWStorageManager ()

@property (nonatomic, strong) NSUserDefaults *userDefaults;

@property (nonatomic, strong) NSMutableDictionary *cookieDic;



//keychain
@property (nonatomic, strong) NSArray *pswArray;
@end


@implementation PWStorageManager

+ (instancetype)shareInstance{
    static dispatch_once_t once;
    static PWStorageManager * obj = nil;
    dispatch_once(&once, ^{
        obj = [[PWStorageManager alloc] init];
    });
    
    return obj;
}

- (instancetype)init {
    if (self = [super init]) {
        self.userDefaults = [NSUserDefaults standardUserDefaults];
    }
    
    return self;
}



#pragma mark - HTTP Cookie
- (void)clearHTTPCookie{
    NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];
    for (NSHTTPCookie *item in cookies) {
        [[NSHTTPCookieStorage sharedHTTPCookieStorage] deleteCookie:item];
    }
}

#pragma mark - file
//创建并返回路径         /cache/pw_main_dir/
- (NSString *)getPWRootPath{
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    NSString *rootPath = [cachePath stringByAppendingPathComponent:PW_Path_Root];
    /*
     防止被iCloud备份
     NSURL *rootPathURL = [NSURL fileURLWithPath:rootPath];
     [rootPathURL setResourceValue:[NSNumber numberWithBool:YES] forKey:NSURLIsExcludedFromBackupKey error:nil];
     */
    BOOL bFlag = YES;
    NSError *error = nil;
    if (![[NSFileManager defaultManager] fileExistsAtPath:rootPath isDirectory:&bFlag]) {
        bFlag = [[NSFileManager defaultManager] createDirectoryAtPath:rootPath withIntermediateDirectories:YES attributes:nil error:&error];
    }
    return rootPath;
    
}

- (NSString *)getModulePathByModule:(PWModuleType)moduleType{
    NSString *rootPath = [self getPWRootPath];
    NSString *destPath = @"";
    
    if (moduleType==PWModuleTypeLogin){
        destPath = [rootPath stringByAppendingPathComponent:PW_Path_LoginModule];
    }
    else if (moduleType==PWModuleType3DWorld){
        destPath = [rootPath stringByAppendingPathComponent:PW_Path_3DWorldModule];
    }
    else if (moduleType==PWModuleType3DCity){
        destPath = [rootPath stringByAppendingPathComponent:PW_Path_3DCityModule];
    }
    else if (moduleType==PWModuleTypeSearch){
        destPath = [rootPath stringByAppendingPathComponent:PW_Path_SearchModule];
    }
    else if (moduleType==PWModuleTypeSettings){
        destPath = [rootPath stringByAppendingPathComponent:PW_Path_SettingsModule];
    }
    else if (moduleType == PWModuleTypeIM){
        destPath = [rootPath stringByAppendingPathComponent:PW_Path_IMModule];
    }
    else{
        destPath = [rootPath stringByAppendingPathComponent:PW_Path_Common];
    }
    
    BOOL bFlag = YES;
    NSError *error = nil;
    if (![[NSFileManager defaultManager] fileExistsAtPath:destPath isDirectory:&bFlag]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:destPath withIntermediateDirectories:YES attributes:nil error:&error];
    }
    
    return destPath;
}
@end
