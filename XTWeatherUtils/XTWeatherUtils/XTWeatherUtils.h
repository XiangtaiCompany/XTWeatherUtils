//
//  WeatherTool.h
//  YueWuYou
//
//  Created by 何凯楠 on 16/8/31.
//  Copyright © 2016年 HeXiaoBa. All rights reserved.
//  查询天气工具类

#import <Foundation/Foundation.h>

@protocol XTWeatherUtilsDelgate <NSObject>

@optional
- (void)getSearchCityWeather:(NSString *)weather temperature:(NSString *)temperature windPower:(NSString *)windPower;

@end

@interface XTWeatherUtils : NSObject

+ (instancetype)instancetypeAPIKey:(NSString *)apiKey;

- (void)setCityName:(NSString *)cityName;

@property (nonatomic, weak) id<XTWeatherUtilsDelgate> weatherDelegate;

@end
