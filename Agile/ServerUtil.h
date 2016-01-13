//
//  ServerUtil.h
//  WithPlanner
//
//  Created by QUI_MAC_17 on 2014. 7. 30..
//  Copyright (c) 2014년 KJStudio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "SBJson.h"
//#import "ScheduleData.h"

@interface ServerUtil : NSObject

+ (void)registerLogin:(NSString *)userId reponseHandler:(void (^)(NSDictionary *))handler;
+ (void)newTask:(NSString *)userId userTask:(NSString *)userTask projectId:(NSString *)projectId reponseHandler:(void (^)(NSDictionary *))handler;
+ (void)taskToLeft:(NSString *)taskId projectId:(NSString *)projectId userTask:(NSString *)userTask reponseHandler:(void (^)(NSDictionary *))handler;
+ (void)taskToRight:(NSString *)taskId projectId:(NSString *)projectId userTask:(NSString *)userTask reponseHandler:(void (^)(NSDictionary *))handler;
+ (void)loadTasks:(NSString *)projectId reponseHandler:(void (^)(NSDictionary *))handler;
+ (void)loadProjectList:(NSString *)userId reponseHandler:(void (^)(NSDictionary *))handler;
+ (void)searchProject:(NSString *)projectName reponseHandler:(void (^)(NSDictionary *))handler;
+ (void)creatProject:(NSString *)projectTitle password:(NSString *)password userId:(NSString *)userId reponseHandler:(void (^)(NSDictionary *))handler;
+ (void)getAllProject:(NSString *)userId reponseHandler:(void (^)(NSDictionary *))handler;
+ (void)enterProject:(NSString *)teamId userId:(NSString *)userId password:(NSString *)password reponseHandler:(void (^)(NSDictionary *))handler;
+ (void)deleteTask:(NSString *)taskId reponseHandler:(void (^)(NSDictionary *))handler;
+ (void)teaminfo:(NSString *)teamId reponseHandler:(void (^)(NSDictionary *))handler;
//+ (void)checkLogin:(NSString *)userId password:(NSString *)password  reponseHandler:(void (^)(NSDictionary *))handler ;
//+ (void)registerUserIdPw:(NSString *)userId password:(NSString *)password  name:(NSString *)name reponseHandler:(void (^)(NSDictionary *))handler;
//+ (void)registerFacebookUser:(NSString *)userId password:(NSString *)password  name:(NSString *)name reponseHandler:(void (^)(NSDictionary *))handler;
//+ (void)updateNameSexBirthDate:(NSString *)userId name:(NSString *)name  sex:(NSString *)sex birthDate:(NSString *)birthdate message:(NSString *)message reponseHandler:(void (^)(NSDictionary *))handler;
//+ (void)checkHostInfo:(NSString *)userId loginType:(NSString *)loginType reponseHandler:(void (^)(NSDictionary *))handler;
//+ (void)checkPerformerInfo:(NSString *)userId loginType:(NSString *)loginType reponseHandler:(void (^)(NSDictionary *))handler;
//+ (void)registerUserInfo:(NSString *)userId userName:(NSString *)userName loginType:(NSString *)loginType userType:(NSString *)userType os:(NSString *)os deviceToken:(NSString *)deviceToken phoneNum:(NSString *)phoneNum description:(NSString *)description imageURL:(NSString *)imageURL reponseHandler:(void (^)(NSDictionary *))handler;
//+ (void)registerUserInfoModify:(NSString *)userId userName:(NSString *)userName loginType:(NSString *)loginType userType:(NSString *)userType os:(NSString *)os deviceToken:(NSString *)deviceToken phoneNum:(NSString *)phoneNum description:(NSString *)description imageURL:(NSString *)imageURL reponseHandler:(void (^)(NSDictionary *))handler;
//+ (void)registerPerformerInfo:(NSString *)serverId teamName:(NSString *)teamName ownerId:(NSString *)ownerId belong:(NSString *)belong category:(NSString *)category location:(NSString *)location logoPhoto:(NSData *)logoPhoto reponseHandler:(void (^)(NSDictionary *))handler;
//+ (void)registerPerformanceInfo:(NSString *)teamId partId:(NSString *)partId performanceName:(NSString *)performanceName payment:(NSString *)payment youtubeId:(NSString *)youtubeId description:(NSString *)description reponseHandler:(void (^)(NSDictionary *))handler;
//+ (void)registerConcertHall:(NSString *)serverId hostId:(NSString *)hostId hallName:(NSString *)hallName phoneNum:(NSString *)phoneNum location:(NSString *)location geoLocation:(NSString *)geoLocation hallDesc:(NSString *)hallDesc logoPhoto:(NSData *)logoPhoto hallPhoto:(NSData *)hallPhoto responseHandler:(void (^)(NSDictionary *))handler;
//+ (void)registerConcert:(NSString *)hallId concertId:(NSString *)concertId concertName:(NSString *)concertName payment:(NSString *)payment concertDate:(NSString *)concertDate needCategories:(NSString *)needCategories description:(NSString *)description reponseHandler:(void (^)(NSDictionary *))handler;
//+ (void)registerPerformanceReply:(NSString *)userId performanceId:(NSString *)performanceId replyText:(NSString *)replyText reponseHandler:(void (^)(NSDictionary *))handler;
//+ (void)getPerformanceReplyList:(NSString *)performanceId forHandler:(void (^)(NSDictionary *))handler;
//+ (void)registerConcertReply:(NSString *)userId needConcertId:(NSString *)performanceId replyText:(NSString *)replyText reponseHandler:(void (^)(NSDictionary *))handler;
//+ (void)getConcertReplyList:(NSString *)needConcertId forHandler:(void (^)(NSDictionary *))handler;
//+ (void)getCompanyList:(NSString *)date forHandler:(void (^)(NSDictionary *))handler;
//+ (void)getDongariList:(NSString *)date userId:(NSString *)userId forHandler:(void (^)(NSDictionary *))handler;
//+ (void)getHostList:(NSString *)date forHandler:(void (^)(NSDictionary *))handler;
//+ (void)getHallList:(NSString *)userId forHandler:(void (^)(NSDictionary *))handler;
//+ (void)getPerformanceList:(NSString *)date forHandler:(void (^)(NSDictionary *))handler;
//+ (void)deleteReply:(NSString *)replyId forHandler:(void (^)(NSDictionary *))handler;
//+ (void)deletePerformance:(NSString *)performanceId forHandler:(void (^)(NSDictionary *))handler;
//+ (void)deleteConcert:(NSString *)concertId forHandler:(void (^)(NSDictionary *))handler;
//+ (void)pushTeamToConcert:(NSString *)performanceId concertId:(NSString *)concertId userId:(NSString *)userId receiverId:(NSString *)receiveId forHandler:(void (^)(NSDictionary *))handler;
//+ (void)pushConcertToTeam:(NSString *)performanceId concertId:(NSString *)concertId userId:(NSString *)userId receiverId:(NSString *)receiveId forHandler:(void (^)(NSDictionary *))handler;
//+ (void)getPushData:(NSString *)userId forHandler:(void (^)(NSDictionary *))handler;
//+ (void)requestAccept:(NSString *)connectId forHandler:(void (^)(NSDictionary *))handler;
//+ (void)requestCancle:(NSString *)connectId forHandler:(void (^)(NSDictionary *))handler;
//+ (void)likePart:(NSString *)userId performanceId:(NSString *)performanceId dongariId:(NSString *)dongariId forHandler:(void (^)(NSDictionary *))handler;
//+ (void)unlikePart:(NSString *)userId performanceId:(NSString *)performanceId dongariId:(NSString *)dongariId forHandler:(void (^)(NSDictionary *))handler;
//+ (void)contactOk:(NSString *)userId userType:(NSString *)userType forHandler:(void (^)(NSDictionary *))handler;
//+ (void)contactDeny:(NSString *)id forHandler:(void (^)(NSDictionary *))handler;
//+ (void)getUserInfo:(NSString *)userId forHandler:(void (^)(NSDictionary *))handler;
//+ (void)findFriendsByInput:(NSString *)myId input:(NSString *)input  reponseHandler:(void (^)(NSDictionary *))handler;
//+ (void)findFacebookFriendsByUserId:(NSString *)myId input:(NSString *)input  reponseHandler:(void (^)(NSDictionary *))handler;
//+ (void)getFollowingStoreList:(NSString *)input reponseHandler:(void (^)(NSDictionary *))handler;f
//+ (void)getFriendsList:(NSString *)input reponseHandler:(void (^)(NSDictionary *))handler;
//+ (void)getFriendsSchduleById:(NSString *)input reponseHandler:(void (^)(NSDictionary *))handler;
//+ (void)getSchedulesByHost:(NSString *)host reponseHandler:(void (^)(NSDictionary *))handler;
//+ (void)getRequestedUsers:(NSString *)input reponseHandler:(void (^)(NSDictionary *))handler;
////+ (void)registerOrUpdateSchedule:(ScheduleData *)s reponseHandler:(void (^)(NSDictionary *))handler;
//+ (void)shareSchedule:(NSString *)userId schedule_id:(NSString *)schedule_id reponseHandler:(void (^)(NSDictionary *))handler;
//+ (void)getAllCompanySchedule:(NSString *)date  responseHandler:(void (^)(NSDictionary *))handler;
//+ (void)cancleFriendsRequest:(NSString *)user1Id user2Id:(NSString *)user2Id  reponseHandler:(void (^)(NSDictionary *))handler;
//+ (void)refuseFriendsRequest:(NSString *)user1Id user2Id:(NSString *)user2Id  reponseHandler:(void (^)(NSDictionary *))handler;
//+ (void)acceptFriendsRequest:(NSString *)user1Id user2Id:(NSString *)user2Id  reponseHandler:(void (^)(NSDictionary *))handler;
//+ (void)checkFollowCompanyRequest:(NSString *)user1Id user2Id:(NSString *)user2Id  reponseHandler:(void (^)(NSDictionary *))handler;
//+ (void)followCompanyRequest:(NSString *)user1Id user2Id:(NSString *)user2Id  reponseHandler:(void (^)(NSDictionary *))handler;
//+ (void)unfollowCompanyRequest:(NSString *)user1Id user2Id:(NSString *)user2Id  reponseHandler:(void (^)(NSDictionary *))handler;
//+ (void)addFriendsRequest:(NSString *)user1Id user2Id:(NSString *)user2Id  reponseHandler:(void (^)(NSDictionary *))handler;
//+ (void)getMoreInfo:(NSString *)hostId scheduleId:(NSString *)schedule_id reponseHandler:(void (^)(NSDictionary *))handler;
//+ (void)getScheduleProfile:(NSString *)hostId reponseHandler:(void (^)(NSDictionary *))handler;
//+ (void)getSchedule:(NSString *)scheduleId responseHandler:(void (^)(NSDictionary *))handler;
//+(void)certificateSchedule:(NSString *)scheduleId userId:(NSString *)userId hostId:(NSString *)hostId certificateNum:(NSString *)certificateNum responseHandler:(void (^)(NSDictionary *))handler;
//+(void)logoutProcess:(NSString *)userId responseHandler:(void (^)(NSDictionary *))handler;
@end
