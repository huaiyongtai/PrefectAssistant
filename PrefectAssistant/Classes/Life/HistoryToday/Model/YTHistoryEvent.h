//
//  YTHistoryEvent.h
//  PrefectAssistant
//
//  Created by HelloWorld on 16/4/5.
//  Copyright © 2016年 HelloWorld. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YTHistoryEvent : NSObject

//"title": "唐山煤矿瓦斯大爆炸",
//"year": "1920",
//"month": "10",
//"day": "14",
//"content": "<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1920年10月14日，唐山煤矿发生瓦斯爆炸，造成惨案。10月初，唐山煤矿工人即已发现瓦斯气含量过高，要求停工。比利时籍矿师却说：&ldquo;只知道要煤，不知道什么气不气，&rdquo;逼迫工人继续采煤。14日，煤矿发生巨大的瓦斯爆炸，工人当场死亡450人，伤百余人。<br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 惨案发生后，煤矿工人与各界人士十分愤慨，《劳动界》、《晨报》等纷纷予以报道，揭露资本家图财害命的行径。北京政府农商部调查后，亦承认是矿局责任，应该增加安全设备与措施；但又以该矿为中英合办企业，推托与外交部门协同办理。最后，外国资本家仅仅给每名死难矿工家属60元的抚恤金，将这一惨案草草了结。</p>"

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *date;

@property (nonatomic, copy) NSString *eId;

@end
