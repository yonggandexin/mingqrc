//
//  NetworkHelper.m
//  mqrc
//
//  Created by VA on 2017/4/22.
//  Copyright © 2017年 kingman. All rights reserved.
//

#import "NetworkHelper.h"
#import "AFNetworking.h"
#import "NetworkDef.h"
#import "MQNetBaseModel.h"
#import "MQHeader.h"
@interface NetworkHelper ()
{
    AFHTTPSessionManager *_manager;
}

@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) NSString *clientId;

@end

static NetworkHelper *_instance;
static NSString *_pid = @"iosadmin";
static NSString *_password = @"ynyes3157517.com!!!@2017";

@implementation NetworkHelper

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    //    NSLog(@"%s", __FUNCTION__);
    //调用dispatch_once保证在多线程中也只被实例化一次
    static dispatch_once_t oneToken;
    dispatch_once(&oneToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}

+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //        NSLog(@"----- DataHelp init");
        _instance = [[NetworkHelper alloc] init];
    });
    return _instance;
}

- (instancetype)init {
    if (self = [super init]) {
        _manager = [AFHTTPSessionManager manager];
        _manager.requestSerializer = [AFJSONRequestSerializer serializer];
        _manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"application/xml", @"text/xml", @"text/plain",@"application/json",@"text/html"]];

        //设置请求超时
        [_manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
#ifdef DEBUG //调试
        _manager.requestSerializer.timeoutInterval = 20.f;
#else
        _manager.requestSerializer.timeoutInterval = 15.f;
#endif
        
        [_manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    }
    return self;
}

- (NSURLSessionDataTask *)postHttpToServerWithURL:(NSString *)urlString
                 withParameters:(id)aParameter
                        success:(void (^)(id))result
                        failure:(void (^)(id))failure {

    //设置请求头
    [self configRequestHeader];
    NSString *url = nil;
    if (_isDimo == YES) {
        url = AbsoluteDmo(urlString);
    }else{
        url = AbsolutePath(urlString);
    }
   return [_manager POST:url parameters:aParameter progress:^(NSProgress * _Nonnull uploadProgress) {
        ;
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
       //缓存用户cookie
        [self codingCookie:task];
       
        MQNetBaseModel *model = [MQNetBaseModel mj_objectWithKeyValues:responseObject];
        
        if (model.out_status == 1) {
            //请求成功
            result(model.out_bodydata);
        }else{
            failure(model.out_msg);
             [MBProgressHUD showAutoMessage:model.out_msg];
            //请求异常
            [self userAbnormal:model];
           
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
        if(![self isCancel:error]){
            [MBProgressHUD showAutoMessage:@"服务器繁忙，请稍后再试"];
        }
    }];
}

//判断请求失败的原因是否为手动取消请求
- (BOOL)isCancel:(NSError *)error
{
    NSDictionary *UserInfo = error.userInfo;
    NSString *cancelStr = [UserInfo objectForKey:@"NSLocalizedDescription"];
    return [cancelStr isEqualToString:@"cancelled"];
}
- (void)codingCookie:(NSURLSessionDataTask *)task
{
    NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
    NSDictionary *allHeaders = response.allHeaderFields;
    NSString *cookie = [allHeaders objectForKey:@"Set-Cookie"];
    if (cookie) {
        [[NSUserDefaults standardUserDefaults] setObject:cookie forKey:path_Cokiie];
    }
}

- (void)configRequestHeader
{
    NSString *cookie = [[NSUserDefaults standardUserDefaults] objectForKey:path_Cokiie];
    if (cookie) {
        [_manager.requestSerializer setValue:cookie forHTTPHeaderField:@"cookie"];
    }
}

- (void)uploadImage:(UIImage *)image
            success:(void (^) (id res))result
            failure:(void (^) (NSString *error))failure{
 
    NSString *pictureDataString = [image imageOfBase64];
    [[NetworkHelper shareInstance] postHttpToServerWithURL:API_SingleImgFileUpload withParameters:@{@"filedata":pictureDataString} success:^(id res) {
        XLOG(@"%@",res);
        result(res);
    } failure:^(id error) {
        XLOG(@"%@",error);
        failure(error);
    }];
}

- (void)userAbnormal:(MQNetBaseModel *)model
{
    [MBProgressHUD showAutoMessage:model.out_msg];
    if ([model.out_code isEqualToString:@"E800000"]||[model.out_code isEqualToString:@"E200001"]) {
        [MQLoginTool presentLogin];
    }
}

- (void)cancelRequest
{
    [_manager.tasks makeObjectsPerformSelector:@selector(cancel)];
}
@end
