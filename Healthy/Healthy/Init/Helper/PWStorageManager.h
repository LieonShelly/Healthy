//
//  PWStorageManager.h
//  ParallelWorld
//
//  Created by Zhouqingquan on 2017/6/23.
//  Copyright © 2017年 PXSJ. All rights reserved.
//

#import <Foundation/Foundation.h>


#define kDeviceToken                        @"pw_deviceToken"
#define kPhoneNumberLast                    @"pw_last_phone_no"
#define kLoginErrInfo                       @"pw_login_err_info"
#define kRegisterCodeInfo                   @"pw_register_code_request_info"



//文件存放统一路径
#define PW_Path_Root                        @"pw_main_dir"

#define PW_Path_Common                      @"common"
#define PW_Path_LoginModule                 @"login"
#define PW_Path_3DWorldModule               @"3D_world"
#define PW_Path_3DCityModule                @"3D_city"
#define PW_Path_SearchModule                @"search"
#define PW_Path_SettingsModule              @"settings"
#define PW_Path_IMModule                    @"IM"

#define PW_Login_Error_Info_Path            @"pw_login_err_info.plist"
#define PW_Phone_VerfyCode_Info_path        @"pw_phone_verfycode_info.plist"



typedef NS_ENUM(NSInteger) {
    PWModuleTypeDefault     = -1,
    
    PWModuleTypeLogin       = 1,
    PWModuleType3DWorld     = 2,
    PWModuleType3DCity      = 3,
    PWModuleTypeSearch      = 4,
    PWModuleTypeSettings    = 5,
    PWModuleTypeIM          = 6,
}PWModuleType;




@interface PWStorageManager : NSObject

+ (instancetype)shareInstance;


/*
 HTTP Cookie
 */
- (void)clearHTTPCookie;        //一般来说，appWillterminate应该clearHTTPCookie

/*
 file
 */
//创建并返回路径         /cache/sr_plugin_dir/
- (NSString *)getPWRootPath;
- (NSString *)getModulePathByModule:(PWModuleType)moduleType;

@end
