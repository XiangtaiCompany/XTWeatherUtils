//
//  WeatherTool.m
//  YueWuYou
//
//  Created by 何凯楠 on 16/8/31.
//  Copyright © 2016年 HeXiaoBa. All rights reserved.
//

#import "XTWeatherUtils.h"
#import <AMapSearchKit/AMapSearchKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>

@interface XTWeatherUtils()<AMapSearchDelegate>

@property (nonatomic, nullable, copy) NSString *cityName;;
@property (nonatomic, nullable, strong) AMapSearchAPI *search;
@end

@implementation XTWeatherUtils

+ (instancetype)instancetypeAPIKey:(NSString *)apiKey {
    return [[XTWeatherUtils alloc] instancetypeAPIKey:apiKey];
}

- (instancetype)instancetypeAPIKey:(NSString *)apiKey {
    if (self == [super init]) {
        [AMapServices sharedServices].apiKey = apiKey;
        self.search = [[AMapSearchAPI alloc] init];
        self.search.delegate = self;
    }
    return self;
}

- (void)searchDistrictWithName:(NSString *)name
{
    AMapWeatherSearchRequest *request = [[AMapWeatherSearchRequest alloc] init];
    request.city = name;
    request.type = AMapWeatherTypeLive; //AMapWeatherTypeLive为实时天气；AMapWeatherTypeForecase为预报天气
    
    [self.search AMapWeatherSearch:request];
}

- (void)setCityName:(NSString *)cityName {
    _cityName = cityName;
    [self searchDistrictWithName:cityName];
}

- (void)onWeatherSearchDone:(AMapWeatherSearchRequest *)request response:(AMapWeatherSearchResponse *)response
{
    //如果是实时天气
    if(request.type == AMapWeatherTypeLive)
    {
        if(response.lives.count == 0)
        {
            return;
        }
        for (AMapLocalWeatherLive *live in response.lives) {
            if ([self.weatherDelegate respondsToSelector:@selector(getSearchCityWeather:temperature:windPower:)]) {
                [self.weatherDelegate getSearchCityWeather:live.weather temperature:live.temperature windPower:live.windPower];
            }
        }
    }
    //如果是预报天气
    else
    {
        if(response.forecasts.count == 0)
        {
            return;
        }
        for (AMapLocalWeatherForecast *forecast in response.forecasts) {
            NSLog(@"%@", forecast);
        }
    }
}

- (void)AMapSearchRequest:(id)request didFailWithError:(NSError *)error
{
    NSLog(@"Error: %@", error);
}


@end
