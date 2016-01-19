//
//  GPAccessTokenParam.h
//  我的微博
//
//  Created by qianfeng on 16/1/12.
//  Copyright (c) 2016年 kelvin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GPAccessTokenParam : NSObject

/* client_id	true	string	申请应用时分配的AppKey */
@property (nonatomic, copy) NSString *client_id;
/* client_secret	true	string	申请应用时分配的AppSecret */
@property (nonatomic, copy) NSString *client_secret;
/* grant_type	true	string	请求的类型，填写authorization_code */
@property (nonatomic, copy) NSString *grant_type;
/* code	true	string	调用authorize获得的code值 */
@property (nonatomic, copy) NSString *code;
/* redirect_uri	true	string	回调地址，需需与注册应用里的回调地址一致 */
@property (nonatomic, copy) NSString *redirect_uri;


@end
