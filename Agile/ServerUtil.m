//
//  ServerUtil.m
//  WithPlanner
//
//  Created by QUI_MAC_17 on 2014. 7. 30..
//  Copyright (c) 2014년 KJStudio. All rights reserved.
//

#import "ServerUtil.h"
//#import "ScheduleData.h"

@implementation ServerUtil

+ (void)baseRequestForPath:(NSString *)path parameters:(NSDictionary *)params reponseHandler:(void (^)(NSDictionary *))handler {
    NSURL *url = [NSURL URLWithString:@"https://agile-jackiehoon-1.c9users.io/"];
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
    
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"POST" path:path parameters:params];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Request Successful: %@", operation.responseString);
        NSDictionary *dic = [[[SBJsonParser alloc] init] objectWithString:operation.responseString];
        if (handler != nil)
            handler(dic);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
    }];
    [operation start];
}

+ (void)registerLogin:(NSString *)userId reponseHandler:(void (^)(NSDictionary *))handler {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:userId forKey:@"fid"];
    [self baseRequestForPath:@"/mob/ios_login" parameters:params reponseHandler:handler];
}

+ (void)newTask:(NSString *)userId userTask:(NSString *)userTask projectId:(NSString *)projectId reponseHandler:(void (^)(NSDictionary *))handler {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:userId forKey:@"user_id"];
    [params setObject:userTask forKey:@"user_content"];
    [params setObject:projectId forKey:@"team_id"];
    [self baseRequestForPath:@"/mob/new_cont" parameters:params reponseHandler:handler];
}

+ (void)taskToLeft:(NSString *)taskId projectId:(NSString *)projectId userTask:(NSString *)userTask reponseHandler:(void (^)(NSDictionary *))handler {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:taskId forKey:@"cont_id"];
    [params setObject:projectId forKey:@"team_id"];
    [params setObject:userTask forKey:@"user_cont"];
    [self baseRequestForPath:@"/home/to_left" parameters:params reponseHandler:handler];
}

+ (void)taskToRight:(NSString *)taskId projectId:(NSString *)projectId userTask:(NSString *)userTask reponseHandler:(void (^)(NSDictionary *))handler {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:taskId forKey:@"cont_id"];
    [params setObject:projectId forKey:@"team_id"];
    [params setObject:userTask forKey:@"user_cont"];
    [self baseRequestForPath:@"/home/to_right" parameters:params reponseHandler:handler];
}

+ (void)loadTasks:(NSString *)projectId reponseHandler:(void (^)(NSDictionary *))handler {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:projectId forKey:@"team_id"];
    [self baseRequestForPath:@"/mob/content" parameters:params reponseHandler:handler];
}

+ (void)loadProjectList:(NSString *)userId reponseHandler:(void (^)(NSDictionary *))handler {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:userId forKey:@"id"];
    [self baseRequestForPath:@"/mob/select_team" parameters:params reponseHandler:handler];
}

+ (void)searchProject:(NSString *)projectName reponseHandler:(void (^)(NSDictionary *))handler {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:projectName forKey:@"teamname"];
    [self baseRequestForPath:@"/mob/search_team" parameters:params reponseHandler:handler];
}

+ (void)creatProject:(NSString *)projectTitle password:(NSString *)password userId:(NSString *)userId reponseHandler:(void (^)(NSDictionary *))handler {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:projectTitle forKey:@"title"];
    [params setObject:password forKey:@"password"];
    [params setObject:userId forKey:@"id"];
    [self baseRequestForPath:@"/mob/new_team" parameters:params reponseHandler:handler];
}

+ (void)getAllProject:(NSString *)userId reponseHandler:(void (^)(NSDictionary *))handler {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:userId forKey:@"id"];
    [self baseRequestForPath:@"/mob/getAllTeam" parameters:params reponseHandler:handler];
}

+ (void)enterProject:(NSString *)teamId userId:(NSString *)userId password:(NSString *)password reponseHandler:(void (^)(NSDictionary *))handler {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:teamId forKey:@"id"];
    [params setObject:userId forKey:@"user_id"];
    [params setObject:password forKey:@"password"];
    [self baseRequestForPath:@"/mob/enterTeam" parameters:params reponseHandler:handler];
}

+ (void)deleteTask:(NSString *)taskId reponseHandler:(void (^)(NSDictionary *))handler {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:taskId forKey:@"cont_id"];
    [self baseRequestForPath:@"/mob/deleteCont" parameters:params reponseHandler:handler];
}

+ (void)teaminfo:(NSString *)teamId reponseHandler:(void (^)(NSDictionary *))handler {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:teamId forKey:@"team_id"];
    [self baseRequestForPath:@"/mob/teaminfo" parameters:params reponseHandler:handler];
}
//
//+ (void)checkLogin:(NSString *)userId password:(NSString *)password  reponseHandler:(void (^)(NSDictionary *))handler {
//    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
//    [params setObject:userId forKey:@"username"];
//    [params setObject:password forKey:@"password"];
//    
//    if ([GeneralUtil isRegistered]) {
//        if ([GeneralUtil deviceToken] == nil) {
//            
//            [params setObject:@"testToken" forKey:@"registration_id"];
//        }
//        else
//        {
//            [params setObject:[GeneralUtil deviceToken] forKey:@"registration_id"];
//            
//        }
//    }
//    else
//    {
//        [params setObject:@"testToken" forKey:@"registration_id"];
//    }
//    
//    [self baseRequestForPath:@"/ci/auth/checkLoginForApp" parameters:params reponseHandler:handler];
//}
//
//+ (void)registerUserIdPw:(NSString *)userId password:(NSString *)password  name:(NSString *)name reponseHandler:(void (^)(NSDictionary *))handler {
//    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
//    [params setObject:userId forKey:@"username"];
//    [params setObject:password forKey:@"password"];
//    [params setObject:name forKey:@"name"];
//    NSString *token = [GeneralUtil deviceToken];
//    NSLog(@"regiID = %@", [GeneralUtil deviceToken]);
//    // 시뮬레이터에선 디바이스토큰이 안되서 일단 이렇게 testToken이란 문자를 넣었다.
//    
//    if (token == nil) {
//        token = @"testToken";
//    }
//    [self baseRequestForPath:@"/ci/members/registerForApp" parameters:params reponseHandler:handler];
//}
//
//+ (void)checkHostInfo:(NSString *)userId loginType:(NSString *)loginType reponseHandler:(void (^)(NSDictionary *))handler {
//    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
//    [params setObject:userId forKey:@"userId"];
//    [params setObject:loginType forKey:@"loginType"];
//    
//    [self baseRequestForPath:@"ci/gb_dongari/get_hall_and_concert_by_host" parameters:params reponseHandler:handler];
//}
//
//+ (void)checkPerformerInfo:(NSString *)userId loginType:(NSString *)loginType reponseHandler:(void (^)(NSDictionary *))handler {
//    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
//    [params setObject:userId forKey:@"userId"];
//    [params setObject:loginType forKey:@"loginType"];
//    
//    [self baseRequestForPath:@"ci/gb_dongari/get_dongari_by_id" parameters:params reponseHandler:handler];
//}
//
//+ (void)registerUserInfo:(NSString *)userId userName:(NSString *)userName loginType:(NSString *)loginType userType:(NSString *)userType os:(NSString *)os deviceToken:(NSString *)deviceToken phoneNum:(NSString *)phoneNum description:(NSString *)description imageURL:(NSString *)imageURL reponseHandler:(void (^)(NSDictionary *))handler {
//    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
//    [params setObject:userId forKey:@"userId"];
//    [params setObject:userName forKey:@"userName"];
//    [params setObject:loginType forKey:@"loginType"];
//    [params setObject:userType forKey:@"userType"];
//    [params setObject:os forKey:@"os"];
//    [params setObject:deviceToken forKey:@"deviceToken"];
//    [params setObject:phoneNum forKey:@"phoneNum"];
//    [params setObject:description forKey:@"description"];
//    [params setObject:imageURL forKey:@"profilePhoto"];
//    
//    [self baseRequestForPath:@"ci/gb_dongari/registerForFacebookOrKAKAO" parameters:params reponseHandler:handler];
//}
//
//+ (void)registerUserInfoModify:(NSString *)userId userName:(NSString *)userName loginType:(NSString *)loginType userType:(NSString *)userType os:(NSString *)os deviceToken:(NSString *)deviceToken phoneNum:(NSString *)phoneNum description:(NSString *)description imageURL:(NSString *)imageURL reponseHandler:(void (^)(NSDictionary *))handler {
//    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
//    [params setObject:userId forKey:@"userId"];
//    [params setObject:userName forKey:@"userName"];
//    [params setObject:loginType forKey:@"loginType"];
//    [params setObject:userType forKey:@"userType"];
//    [params setObject:os forKey:@"os"];
//    [params setObject:deviceToken forKey:@"deviceToken"];
//    [params setObject:phoneNum forKey:@"phoneNum"];
//    [params setObject:description forKey:@"description"];
//    [params setObject:imageURL forKey:@"profilePhoto"];
//    
//    [self baseRequestForPath:@"ci/gb_dongari/updateForFacebookOrKAKAO" parameters:params reponseHandler:handler];
//}
//
//+ (void)registerPerformerInfo:(NSString *)serverId teamName:(NSString *)teamName ownerId:(NSString *)ownerId belong:(NSString *)belong category:(NSString *)category location:(NSString *)location logoPhoto:(NSData *)logoPhoto reponseHandler:(void (^)(NSDictionary *))handler {
//    
//    NSURL *url = [NSURL URLWithString:@"http://cho881020.cafe24.com/ci/gb_dongari/registerDongari"];
//    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
//    
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss.SSS"];
//    
//    NSString *stringFromDate = [formatter stringFromDate:[NSDate date]];
//    
//    NSString *uploadFileName = [NSString stringWithFormat:@"team_gongbackLogo_%@_%@.jpg",ownerId, stringFromDate];
//    
//    NSMutableURLRequest *request = [httpClient multipartFormRequestWithMethod:@"POST" path:@"/ci/gb_dongari/registerDongari" parameters:nil constructingBodyWithBlock:^(id <AFMultipartFormData>formData) {
//        [formData appendPartWithFileData:logoPhoto
//                                    name:@"logoPhoto"
//                                fileName:uploadFileName mimeType:@"image/jpg"];
//        
//        if(serverId != nil)
//        {
//            [formData appendPartWithFormData:[serverId dataUsingEncoding:NSUTF8StringEncoding]
//                                        name:@"id"];
//        }
//        
//        [formData appendPartWithFormData:[teamName dataUsingEncoding:NSUTF8StringEncoding]
//                                    name:@"teamName"];
//        
//        [formData appendPartWithFormData:[ownerId dataUsingEncoding:NSUTF8StringEncoding]
//                                    name:@"ownerId"];
//        
//        [formData appendPartWithFormData:[belong dataUsingEncoding:NSUTF8StringEncoding]
//                                    name:@"belong"];
//        
//        [formData appendPartWithFormData:[category dataUsingEncoding:NSUTF8StringEncoding]
//                                    name:@"category"];
//        
//        [formData appendPartWithFormData:[location dataUsingEncoding:NSUTF8StringEncoding]
//                                    name:@"location"];
//        
//    }];
//    
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"Request Successful: %@", operation.responseString);
//        NSDictionary *dic = [[[SBJsonParser alloc] init] objectWithString:operation.responseString];
//        if (handler != nil)
//            handler(dic);
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"%@", error);
//    }];
//    [operation start];
////    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
////    if(serverId != nil)
////    {
////        [params setObject:serverId forKey:@"id"];
////    }
////    [params setObject:teamName forKey:@"teamName"];
////    [params setObject:ownerId forKey:@"ownerId"];
////    [params setObject:belong forKey:@"belong"];
////    [params setObject:category forKey:@"category"];
////    [params setObject:location forKey:@"location"];
////    [params setObject:logoImageName forKey:@"logoImageName"];
////    
////    [self baseRequestForPath:@"ci/gb_dongari/registerDongari" parameters:params reponseHandler:handler];
//}
//
//+ (void)registerPerformanceInfo:(NSString *)teamId partId:(NSString *)partId performanceName:(NSString *)performanceName payment:(NSString *)payment youtubeId:(NSString *)youtubeId description:(NSString *)description reponseHandler:(void (^)(NSDictionary *))handler {
//    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
//    [params setObject:teamId forKey:@"teamId"];
//    [params setObject:partId forKey:@"id"];
//    [params setObject:performanceName forKey:@"performanceName"];
//    [params setObject:payment forKey:@"payment"];
//    [params setObject:youtubeId forKey:@"youtubeId"];
//    [params setObject:description forKey:@"description"];
//    
//    [self baseRequestForPath:@"ci/gb_dongari/registerPerformance" parameters:params reponseHandler:handler];
//}
//
//+ (void)registerConcertHall:(NSString *)serverId hostId:(NSString *)hostId hallName:(NSString *)hallName phoneNum:(NSString *)phoneNum location:(NSString *)location geoLocation:(NSString *)geoLocation hallDesc:(NSString *)hallDesc logoPhoto:(NSData *)logoPhoto hallPhoto:(NSData *)hallPhoto responseHandler:(void (^)(NSDictionary *))handler {
////    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
////    if(serverId != nil)
////    {
////        [params setObject:serverId forKey:@"id"];
////    }
////    [params setObject:hostId forKey:@"hostId"];
////    [params setObject:hallName forKey:@"hallName"];
////    [params setObject:phoneNum forKey:@"phoneNum"];
////    [params setObject:location forKey:@"location"];
////    [params setObject:geoLocation forKey:@"geoLocation"];
////    [params setObject:hallDesc forKey:@"hallDesc"];
////    [params setObject:logoPhoto forKey:@"logoPhoto"];
//    
//   
//    NSURL *url = [NSURL URLWithString:@"http://cho881020.cafe24.com/ci/gb_dongari/registerHall"];
//    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
//    
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss.SSS"];
//    
//    NSString *stringFromDate = [formatter stringFromDate:[NSDate date]];
//    NSString *uploadFileName = [NSString stringWithFormat:@"hall_gongbackLogo_%@_%@.jpg", hostId, stringFromDate];
//    
//    NSString *uploadHallFileName = [NSString stringWithFormat:@"hall_gongbackHallPhoto_%@_%@.jpg", hostId, stringFromDate];
//    
//    NSMutableURLRequest *request = [httpClient multipartFormRequestWithMethod:@"POST" path:@"/ci/gb_dongari/registerHall" parameters:nil constructingBodyWithBlock:^(id <AFMultipartFormData>formData) {
//        [formData appendPartWithFileData:logoPhoto
//                                    name:@"logoPhoto"
//                                fileName:uploadFileName mimeType:@"image/jpg"];
//        
//        [formData appendPartWithFileData:hallPhoto
//                                    name:@"hallPhoto"
//                                fileName:uploadHallFileName mimeType:@"image/jpg"];
//        
//        if(serverId != nil)
//        {
//        [formData appendPartWithFormData:[serverId dataUsingEncoding:NSUTF8StringEncoding]
//                                    name:@"id"];
//        }
//        
//        [formData appendPartWithFormData:[hostId dataUsingEncoding:NSUTF8StringEncoding]
//                                    name:@"hostId"];
//        
//        [formData appendPartWithFormData:[hallName dataUsingEncoding:NSUTF8StringEncoding]
//                                    name:@"hallName"];
//        
//        [formData appendPartWithFormData:[phoneNum dataUsingEncoding:NSUTF8StringEncoding]
//                                    name:@"phoneNum"];
//        
//        [formData appendPartWithFormData:[location dataUsingEncoding:NSUTF8StringEncoding]
//                                    name:@"location"];
//        
//        [formData appendPartWithFormData:[geoLocation dataUsingEncoding:NSUTF8StringEncoding]
//                                    name:@"geoLocation"];
//        
//        [formData appendPartWithFormData:[hallDesc dataUsingEncoding:NSUTF8StringEncoding]
//                                    name:@"hallDesc"];
//
//
//    }];
//    
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"Request Successful: %@", operation.responseString);
//        NSDictionary *dic = [[[SBJsonParser alloc] init] objectWithString:operation.responseString];
//        if (handler != nil)
//            handler(dic);
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"%@", error);
//    }];
//    [operation start];
//    
////    [self baseRequestForPath:@"ci/gb_dongari/registerHall" parameters:params reponseHandler:handler];
//}
//
//+ (void)registerConcert:(NSString *)hallId concertId:(NSString *)concertId concertName:(NSString *)concertName payment:(NSString *)payment concertDate:(NSString *)concertDate needCategories:(NSString *)needCategories description:(NSString *)description reponseHandler:(void (^)(NSDictionary *))handler {
//    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
//    [params setObject:hallId forKey:@"hallId"];
//    if (![concertId isEqualToString:@"none"]) {
//        [params setObject:concertId forKey:@"id"];
//    }
//    [params setObject:concertName forKey:@"concertName"];
//    [params setObject:payment forKey:@"payment"];
//    [params setObject:concertDate forKey:@"concertDate"];
//    [params setObject:needCategories forKey:@"needCategories"];
//    [params setObject:description forKey:@"description"];
//    
//    [self baseRequestForPath:@"ci/gb_dongari/registerNeedConcert" parameters:params reponseHandler:handler];
//}
//
//+ (void)registerPerformanceReply:(NSString *)userId performanceId:(NSString *)performanceId replyText:(NSString *)replyText reponseHandler:(void (^)(NSDictionary *))handler {
//    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
//    [params setObject:userId forKey:@"userId"];
//    [params setObject:performanceId forKey:@"performanceId"];
//    [params setObject:replyText forKey:@"content"];
//    
//    [self baseRequestForPath:@"ci/gb_dongari/registerPerformanceReply" parameters:params reponseHandler:handler];
//}
//
//+ (void)getPerformanceReplyList:(NSString *)performanceId forHandler:(void (^)(NSDictionary *))handler {
//    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
//    [params setObject:performanceId forKey:@"performanceId"];
//    [self baseRequestForPath:@"ci/gb_dongari/getReplyOfPerformance" parameters:params reponseHandler:handler];
//}
//
//+ (void)registerConcertReply:(NSString *)userId needConcertId:(NSString *)needConcertId replyText:(NSString *)replyText reponseHandler:(void (^)(NSDictionary *))handler {
//    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
//    [params setObject:userId forKey:@"userId"];
//    [params setObject:needConcertId forKey:@"needConcertId"];
//    [params setObject:replyText forKey:@"content"];
//    
//    [self baseRequestForPath:@"ci/gb_dongari/registerNeedConcertReply" parameters:params reponseHandler:handler];
//}
//
//+ (void)getConcertReplyList:(NSString *)needConcertId forHandler:(void (^)(NSDictionary *))handler {
//    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
//    [params setObject:needConcertId forKey:@"needConcertId"];
//    [self baseRequestForPath:@"ci/gb_dongari/getReplyOfNeedConcert" parameters:params reponseHandler:handler];
//}
////+ (void)registerFacebookUser:(NSString *)userId password:(NSString *)password  name:(NSString *)name reponseHandler:(void (^)(NSDictionary *))handler {
////    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
////    [params setObject:userId forKey:@"username"];
////    [params setObject:password forKey:@"password"];
////    [params setObject:name forKey:@"name"];
////    NSString *token = [GeneralUtil deviceToken];
////    NSLog(@"regiID = %@", [GeneralUtil deviceToken]);
////    // 시뮬레이터에선 디바이스토큰이 안되서 일단 이렇게 testToken이란 문자를 넣었다.
////
////    if (token == nil) {
////        token = @"testToken";
////    }
////    
////    [params setObject:token forKey:@"registration_id"];
////    [params setObject:@"1" forKey:@"isFacebookUser"];
////    [self baseRequestForPath:@"/ci/members/registerForFacebook" parameters:params reponseHandler:handler];
////}
////
////+ (void)updateNameSexBirthDate:(NSString *)userId name:(NSString *)name  sex:(NSString *)sex birthDate:(NSString *)birthdate message:(NSString *)message reponseHandler:(void (^)(NSDictionary *))handler {
////    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
////    [params setObject:userId forKey:@"username"];
////    [params setObject:sex forKey:@"sex"];
////    [params setObject:name forKey:@"name"];
////    [params setObject:birthdate forKey:@"birthdate"];
////    [params setObject:message forKey:@"message"];
////    [self baseRequestForPath:@"/ci/members/updateUserInfoAtSetProfile" parameters:params reponseHandler:handler];
////}
////
//+ (void)getCompanyList:(NSString *)date forHandler:(void (^)(NSDictionary *))handler {
//    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
//    [params setObject:date forKey:@"date"];
//    [self baseRequestForPath:@"/ci/company/get_stores" parameters:params reponseHandler:handler];
//}
//
//+ (void)getDongariList:(NSString *)date userId:(NSString *)userId forHandler:(void (^)(NSDictionary *))handler {
//    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
//    [params setObject:date forKey:@"date"];
//    [params setObject:userId forKey:@"userId"];
//    [self baseRequestForPath:@"ci/gb_dongari/get_dongari" parameters:params reponseHandler:handler];
//}
//
//+ (void)getHostList:(NSString *)date forHandler:(void (^)(NSDictionary *))handler {
//    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
//    [params setObject:date forKey:@"date"];
//    [self baseRequestForPath:@"ci/gb_dongari/get_concert" parameters:params reponseHandler:handler];
//}
//
//+ (void)getHallList:(NSString *)userId forHandler:(void (^)(NSDictionary *))handler {
//    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
//    [params setObject:userId forKey:@"userId"];
//    [self baseRequestForPath:@"ci/gb_dongari/getHallByUserId" parameters:params reponseHandler:handler];
//}
//
//+ (void)getPerformanceList:(NSString *)date forHandler:(void (^)(NSDictionary *))handler {
//    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
//    [params setObject:date forKey:@"date"];
//    [self baseRequestForPath:@"ci/gb_dongari/registerPerformance" parameters:params reponseHandler:handler];
//}
//
//+ (void)deleteReply:(NSString *)replyId forHandler:(void (^)(NSDictionary *))handler {
//    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
//    [params setObject:replyId forKey:@"replyId"];
//    [self baseRequestForPath:@"ci/gb_dongari/deleteGBPerformanceReply" parameters:params reponseHandler:handler];
//}
//
//+ (void)deletePerformance:(NSString *)performanceId forHandler:(void (^)(NSDictionary *))handler {
//    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
//    [params setObject:performanceId forKey:@"partId"];
//    [self baseRequestForPath:@"ci/gb_dongari/deleteGBPerformance" parameters:params reponseHandler:handler];
//}
//
//+ (void)deleteConcert:(NSString *)concertId forHandler:(void (^)(NSDictionary *))handler {
//    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
//    [params setObject:concertId forKey:@"concertId"];
//    [self baseRequestForPath:@"ci/gb_dongari/deleteGBNeedConcert" parameters:params reponseHandler:handler];
//}
//
//+ (void)pushTeamToConcert:(NSString *)performanceId concertId:(NSString *)concertId userId:(NSString *)userId receiverId:(NSString *)receiverId forHandler:(void (^)(NSDictionary *))handler {
//    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
//    [params setObject:performanceId forKey:@"performanceId"];
//    [params setObject:concertId forKey:@"needConcertId"];
//    [params setObject:userId forKey:@"userId"];
//    [params setObject:receiverId forKey:@"receiverId"];
//    [self baseRequestForPath:@"ci/gb_dongari/applyNeedConcert" parameters:params reponseHandler:handler];
//}
//
//+ (void)pushConcertToTeam:(NSString *)performanceId concertId:(NSString *)concertId userId:(NSString *)userId receiverId:(NSString *)receiverId forHandler:(void (^)(NSDictionary *))handler {
//    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
//    [params setObject:performanceId forKey:@"performanceId"];
//    [params setObject:concertId forKey:@"needConcertId"];
//    [params setObject:userId forKey:@"userId"];
//    [params setObject:receiverId forKey:@"receiverId"];
//    [self baseRequestForPath:@"ci/gb_dongari/requestPerformance" parameters:params reponseHandler:handler];
//}
//
//+ (void)getPushData:(NSString *)userId forHandler:(void (^)(NSDictionary *))handler {
//    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
//    [params setObject:userId forKey:@"userId"];
//    [self baseRequestForPath:@"ci/gb_dongari/getMyConnectList" parameters:params reponseHandler:handler];
//}
//
//+ (void)requestAccept:(NSString *)connectId forHandler:(void (^)(NSDictionary *))handler {
//    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
//    [params setObject:connectId forKey:@"id"];
//    [self baseRequestForPath:@"ci/gb_dongari/acceptRequest" parameters:params reponseHandler:handler];
//}
//
//+ (void)requestCancle:(NSString *)connectId forHandler:(void (^)(NSDictionary *))handler {
//    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
//    [params setObject:connectId forKey:@"id"];
//    [self baseRequestForPath:@"ci/gb_dongari/cancleRequest" parameters:params reponseHandler:handler];
//}
//
//+ (void)likePart:(NSString *)userId performanceId:(NSString *)performanceId dongariId:(NSString *)dongariId forHandler:(void (^)(NSDictionary *))handler {
//    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
//    [params setObject:userId forKey:@"userId"];
//    [params setObject:performanceId forKey:@"performanceId"];
//    [params setObject:dongariId forKey:@"dongariId"];
//    [self baseRequestForPath:@"ci/gb_dongari/likePart" parameters:params reponseHandler:handler];
//}
//
//+ (void)unlikePart:(NSString *)userId performanceId:(NSString *)performanceId dongariId:(NSString *)dongariId forHandler:(void (^)(NSDictionary *))handler {
//    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
//    [params setObject:userId forKey:@"userId"];
//    [params setObject:performanceId forKey:@"performanceId"];
//    [params setObject:dongariId forKey:@"dongariId"];
//    [self baseRequestForPath:@"ci/gb_dongari/unlikePart" parameters:params reponseHandler:handler];
//}
//
//+ (void)contactOk:(NSString *)id userType:(NSString *)userType forHandler:(void (^)(NSDictionary *))handler {
//    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
//    [params setObject:id forKey:@"id"];
//    [params setObject:userType forKey:@"userType"];
//    [self baseRequestForPath:@"ci/gb_dongari/setOkToConnect" parameters:params reponseHandler:handler];
//}
//
//+ (void)contactDeny:(NSString *)id forHandler:(void (^)(NSDictionary *))handler {
//    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
//    [params setObject:id forKey:@"id"];
//    [self baseRequestForPath:@"ci/gb_dongari/denyRequest" parameters:params reponseHandler:handler];
//}
//
//+ (void)getUserInfo:(NSString *)userId forHandler:(void (^)(NSDictionary *))handler {
//    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
//    [params setObject:userId forKey:@"userId"];
//    [self baseRequestForPath:@"ci/gb_dongari/getMyInfo" parameters:params reponseHandler:handler];
//}
//
//
//+ (void)registerOrUpdateSchedule:(ScheduleData *)s reponseHandler:(void (^)(NSDictionary *))handler {
//    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
//    
//    
//    if (s.serverId != nil) {
//        [params setObject:s.serverId forKey:@"id"];
//    }
//    
//    [params setObject:s.host forKey:@"host"];
//    [params setObject:s.title forKey:@"title"];
//    [params setObject:[NSNumber numberWithInt:0] forKey:@"is_allday"];
//    [params setObject:[s.start dateTimeString] forKey:@"start"];
//    [params setObject:[NSNumber numberWithInt:0] forKey:@"has_attendee"];
//    NSLog(@"attendees = %@", s.attendees);
//    if (s.hasAttendee && s.attendees.count > 0)
//        [params setObject:[s.attendees componentsJoinedByString:@","] forKey:@"attendees"];
//    if (s.end)
//        [params setObject:[s.end dateTimeString] forKey:@"end"];
//    
//    [params setObject:s.description forKey:@"description"];
//    
//    if (s.location)
//        [params setObject:s.location forKey:@"location"];
//    if (s.address)
//        [params setObject:s.address forKey:@"address"];
//    if (s.geolocation)
//        [params setObject:s.geolocation forKey:@"geolocation"];
//    
//    [params setObject:[NSNumber numberWithInt:s.openStatus] forKey:@"open_status"];
//    
//    
//    
//    
//    [self baseRequestForPath:@"/ci/schedules/register" parameters:params reponseHandler:handler];
//}
//
//
//
//+ (void)getSchedulesByHost:(NSString *)host reponseHandler:(void (^)(NSDictionary *))handler {
//    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
//    [params setObject:host forKey:@"host"];
//    [self baseRequestForPath:@"/ci/schedules/get_by_host" parameters:params reponseHandler:handler];
//    
//}
//
//
//+ (void)getAllCompanySchedule:(NSString *)date  responseHandler:(void (^)(NSDictionary *))handler {
//    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
//    [params setObject:date forKey:@"date"];
//    [self baseRequestForPath:@"/ci/schedules/get_all_company_schedule_by" parameters:params reponseHandler:handler];
//}
//
//+ (void)addFriendsRequest:(NSString *)user1Id user2Id:(NSString *)user2Id  reponseHandler:(void (^)(NSDictionary *))handler {
//    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
//    [params setObject:user1Id forKey:@"user1"];
//    [params setObject:user2Id forKey:@"user2"];
//    [self baseRequestForPath:@"/ci/members/add_friend" parameters:params reponseHandler:handler];
//}
//
//+ (void)cancleFriendsRequest:(NSString *)user1Id user2Id:(NSString *)user2Id  reponseHandler:(void (^)(NSDictionary *))handler {
//    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
//    [params setObject:user1Id forKey:@"user1"];
//    [params setObject:user2Id forKey:@"user2"];
//    [self baseRequestForPath:@"/ci/members/cancle_friend_request" parameters:params reponseHandler:handler];
//}
//
//
//+ (void)acceptFriendsRequest:(NSString *)user1Id user2Id:(NSString *)user2Id  reponseHandler:(void (^)(NSDictionary *))handler {
//    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
//    [params setObject:user1Id forKey:@"user1"];
//    [params setObject:user2Id forKey:@"user2"];
//    [self baseRequestForPath:@"/ci/members/accept_friends_request" parameters:params reponseHandler:handler];
//}
//
//
//+ (void)refuseFriendsRequest:(NSString *)user1Id user2Id:(NSString *)user2Id  reponseHandler:(void (^)(NSDictionary *))handler {
//    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
//    [params setObject:user1Id forKey:@"user1"];
//    [params setObject:user2Id forKey:@"user2"];
//    [self baseRequestForPath:@"/ci/members/refuse_friends_request" parameters:params reponseHandler:handler];
//}
//
//+ (void)blockFriendsRequest:(NSString *)user1Id user2Id:(NSString *)user2Id  reponseHandler:(void (^)(NSDictionary *))handler {
//    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
//    [params setObject:user1Id forKey:@"user1"];
//    [params setObject:user2Id forKey:@"user2"];
//    [self baseRequestForPath:@"/ci/members/block_friends_request" parameters:params reponseHandler:handler];
//}
//
//+ (void)followCompanyRequest:(NSString *)user1Id user2Id:(NSString *)user2Id  reponseHandler:(void (^)(NSDictionary *))handler {
//    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
//    [params setObject:user1Id forKey:@"user1"];
//    [params setObject:user2Id forKey:@"user2"];
//    [self baseRequestForPath:@"/ci/members/follow_company_request" parameters:params reponseHandler:handler];
//}
//
//+ (void)unfollowCompanyRequest:(NSString *)user1Id user2Id:(NSString *)user2Id  reponseHandler:(void (^)(NSDictionary *))handler {
//    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
//    [params setObject:user1Id forKey:@"user1"];
//    [params setObject:user2Id forKey:@"user2"];
//    [self baseRequestForPath:@"/ci/members/unfollow_company_request" parameters:params reponseHandler:handler];
//}
//
//+ (void)checkFollowCompanyRequest:(NSString *)user1Id user2Id:(NSString *)user2Id  reponseHandler:(void (^)(NSDictionary *))handler {
//    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
//    [params setObject:user1Id forKey:@"user1"];
//    [params setObject:user2Id forKey:@"user2"];
//    [self baseRequestForPath:@"/ci/members/check_follow_company_request" parameters:params reponseHandler:handler];
//}
//
//+ (void)findFriendsByInput:(NSString *)myId input:(NSString *)input  reponseHandler:(void (^)(NSDictionary *))handler {
//    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
//    [params setObject:myId forKey:@"userId"];
//    [params setObject:input forKey:@"input"];
//    [self baseRequestForPath:@"/ci/members/find_friends_and_status" parameters:params reponseHandler:handler];
//}
//
//+ (void)findFacebookFriendsByUserId:(NSString *)myId input:(NSString *)input  reponseHandler:(void (^)(NSDictionary *))handler {
//    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
//    [params setObject:myId forKey:@"userId"];
//    [params setObject:input forKey:@"input"];
//    [self baseRequestForPath:@"/ci/members/find_facebookfriends_and_status" parameters:params reponseHandler:handler];
//}
//
//+ (void)getFriendsSchduleById:(NSString *)input reponseHandler:(void (^)(NSDictionary *))handler {
//    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
//    [params setObject:input forKey:@"userId"];
//    [self baseRequestForPath:@"/ci/schedules/get_friends_schedule_list" parameters:params reponseHandler:handler];
//}
//
//+ (void)shareSchedule:(NSString *)userId schedule_id:(NSString *)schedule_id reponseHandler:(void (^)(NSDictionary *))handler {
//    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
//    [params setObject:userId forKey:@"userId"];
//    [params setObject:schedule_id forKey:@"schedule_id"];
//    [self baseRequestForPath:@"/ci/schedules/share_schedule" parameters:params reponseHandler:handler];
//}
//
//+ (void)getRequestedUsers:(NSString *)input reponseHandler:(void (^)(NSDictionary *))handler {
//    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
//    [params setObject:input forKey:@"input"];
//    [self baseRequestForPath:@"/ci/members/get_requested_users" parameters:params reponseHandler:handler];
//}
//
//+ (void)getFriendsList:(NSString *)input reponseHandler:(void (^)(NSDictionary *))handler {
//    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
//    [params setObject:input forKey:@"userId"];
//    [self baseRequestForPath:@"/ci/members/get_friends_list" parameters:params reponseHandler:handler];
//}
//
//+ (void)getFollowingStoreList:(NSString *)input reponseHandler:(void (^)(NSDictionary *))handler {
//    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
//    [params setObject:input forKey:@"userId"];
//    [self baseRequestForPath:@"/ci/members/get_following_stores" parameters:params reponseHandler:handler];
//}
//
//+ (void)getMoreInfo:(NSString *)hostId scheduleId:(NSString *)schedule_id  reponseHandler:(void (^)(NSDictionary *))handler {
//    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
//    [params setObject:hostId forKey:@"hostId"];
//    [params setObject:[GeneralUtil getUserId] forKey:@"userId"];
//    [params setObject:schedule_id forKey:@"schedule_id"];
//    [self baseRequestForPath:@"/ci/schedules/get_more_info" parameters:params reponseHandler:handler];
//}
//
//+ (void)getScheduleProfile:(NSString *)hostId reponseHandler:(void (^)(NSDictionary *))handler {
//    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
//    [params setObject:hostId forKey:@"hostId"];
//    [self baseRequestForPath:@"/ci/schedules/get_schedule_profile" parameters:params reponseHandler:handler];
//}
//
//+ (void)getSchedule:(NSString *)scheduleId responseHandler:(void (^)(NSDictionary *))handler {
//    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
//    [params setObject:scheduleId forKey:@"schedule_id"];
//    [self baseRequestForPath:@"/ci/schedules/get" parameters:params reponseHandler:handler];
//}
//
//+(void)certificateSchedule:(NSString *)scheduleId userId:(NSString *)userId hostId:(NSString *)hostId certificateNum:(NSString *)certificateNum responseHandler:(void (^)(NSDictionary *))handler {
//    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
//    [params setObject:scheduleId forKey:@"scheduleId"];
//    [params setObject:hostId forKey:@"hostId"];
//    [params setObject:userId forKey:@"userId"];
//    [params setObject:certificateNum forKey:@"certificationNum"];
//    [self baseRequestForPath:@"/ci/schedules/certificateSchedule" parameters:params reponseHandler:handler];
//    
//}
//
//
//+(void)logoutProcess:(NSString *)userId responseHandler:(void (^)(NSDictionary *))handler {
//    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
//    [params setObject:userId forKey:@"username"];
//    [self baseRequestForPath:@"/ci/auth/logoutProcessForApp" parameters:params reponseHandler:handler];
//    
//}
//
@end
