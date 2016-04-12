//
//  YTPostCodeQueryController.m
//  PrefectAssistant
//
//  Created by HelloWorld on 16/4/8.
//  Copyright © 2016年 HelloWorld. All rights reserved.
//

#import "YTPostCodeQueryController.h"
#import "YTAddressPickerView.h"
#import "YTProvince.h"
#import "YTPostCode.h"

@interface YTPostCodeQueryController () <UIPickerViewDelegate, UIPickerViewDataSource, UITableViewDataSource, UITableViewDelegate, YTAddressPickerViewDelegate>

@property (nonatomic, strong) NSArray<YTProvince *> *provinces;

@property (nonatomic, assign) NSInteger selectedProviceIdx;
@property (nonatomic, assign) NSInteger selectedCityIdx;
@property (nonatomic, assign) NSInteger selectedDistrictIdx;

@property (nonatomic, strong) NSArray *postCodes;


@property (nonatomic, weak) UILabel *provinceLabel;
@property (nonatomic, weak) UILabel *cityLabel;
@property (nonatomic, weak) UILabel *districtLabel;

@property (nonatomic, weak) UITableView *tableView;

@end

@implementation YTPostCodeQueryController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"邮编查询";
    [self.view setBackgroundColor:YTRandomColor];
    
    [self setupUIConfig];
}

- (NSArray<YTProvince *> *)provinces {
    
    if (_provinces ==nil) {
       
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Province.plist" ofType:nil];
        _provinces = [YTProvince mj_objectArrayWithKeyValuesArray:[NSArray arrayWithContentsOfFile:filePath]];
    }
    return _provinces;
}

- (void)setupUIConfig {
    
    UIButton *addressView = [UIButton buttonWithType:UIButtonTypeCustom]; {
        
        [addressView setFrame:CGRectMake(0, 64, YTSCREEN_W, 40)];
        [addressView setBackgroundColor:YTRandomColor];
        [addressView addTarget:self action:@selector(choiceAddress) forControlEvents:UIControlEventTouchUpInside];
        
        CGFloat width = (addressView.width-2) / 3;
        CGFloat height = addressView.height;
        
        UILabel *provinceLabel = [[UILabel alloc] init]; {
            [provinceLabel setFrame:CGRectMake(0, 0, width, height)];
            [provinceLabel setBackgroundColor:YTRandomColor];
            [provinceLabel setText:@"点击选择地址"];
        }
        [addressView addSubview:provinceLabel];
        self.provinceLabel = provinceLabel;
        
        CALayer *leftLineLayer = [[CALayer alloc] init]; {
            [leftLineLayer setFrame:CGRectMake(provinceLabel.rightX, 0, 1, height)];
            [leftLineLayer setBackgroundColor:YTRandomColor.CGColor];
        }
        [addressView.layer addSublayer:leftLineLayer];
        
        UILabel *cityLabel = [[UILabel alloc] init]; {
            [cityLabel setFrame:CGRectMake(CGRectGetMaxX(leftLineLayer.frame), 0, width, height)];
            [cityLabel setBackgroundColor:YTRandomColor];
        }
        [addressView addSubview:cityLabel];
        self.cityLabel = cityLabel;
        
        CALayer *rightLineLayer = [[CALayer alloc] init]; {
            [rightLineLayer setFrame:CGRectMake(cityLabel.rightX, 0, 1, height)];
            [rightLineLayer setBackgroundColor:YTRandomColor.CGColor];
        }
        [addressView.layer addSublayer:rightLineLayer];
        
        UILabel *districtLabel = [[UILabel alloc] init]; {
            [districtLabel setFrame:CGRectMake(CGRectGetMaxX(rightLineLayer.frame), 0, width, height)];
            [districtLabel setBackgroundColor:YTRandomColor];
        }
        [addressView addSubview:districtLabel];
        self.districtLabel = districtLabel;
    }
    [self.view addSubview:addressView];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, addressView.bottomY, YTSCREEN_W, YTSCREEN_H - addressView.bottomY)
                                                          style:UITableViewStylePlain]; {
        
        [tableView setBackgroundColor:YTRandomColor];
        [tableView setDelegate:self];
        [tableView setDataSource:self];
        
    }
    [self.view addSubview:tableView];
    self.tableView = tableView;
}
- (void)choiceAddress {
    
    self.selectedProviceIdx = 0;
    self.selectedCityIdx = 0;
    self.selectedDistrictIdx = 0;
    
    YTAddressPickerView *pickerView = [[YTAddressPickerView alloc] init];
    [pickerView setDelegate:self];
    [pickerView showPikerView];
    
}

#pragma mark - UITableViewDelegate UITableDateSoruceDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.postCodes.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YTPostCode *postCode = self.postCodes[indexPath.row];
    
    static NSString *reuseId = @"YTPostCodeCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseId];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    
    [cell.textLabel setText:[@"邮编：" stringByAppendingString:postCode.postNumber]];
    [cell.detailTextLabel setText:[NSString stringWithFormat:@"%@ %@ %@ %@", postCode.province, postCode.city, postCode.district, postCode.address]];
    
    return cell;
}

#pragma mark - UIPickerViewDelegate, UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    if (component == 0) {
        return self.provinces.count;
    } else if (component == 1) {
        YTProvince *province = self.provinces[self.selectedProviceIdx];
        return province.cities.count;
    } else {
        YTProvince *province = self.provinces[self.selectedProviceIdx];
        YTCity *city = province.cities[self.selectedCityIdx];
        return city.districts.count;
    }
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    
    UILabel *cell = (UILabel *)view;
    if (view == nil) {
        cell = [[UILabel alloc] init];
        [cell setFont:[UIFont systemFontOfSize:16]];
    }
   
    [cell setText:({
        NSString *text = nil;
        if (component == 0) {
            YTProvince *province = self.provinces[row];
            text = province.name;
        } else if (component == 1) {
            YTProvince *province = self.provinces[self.selectedProviceIdx];
            YTCity *city = province.cities[row];
            text =city.name;
        } else {
            YTProvince *province = self.provinces[self.selectedProviceIdx];
            YTCity *city = province.cities[self.selectedCityIdx];
            YTDistrict *district = city.districts[row];
            text =district.name;
        }
        text;
    })];
    return cell;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    if (component == 0) {
        
        self.selectedProviceIdx = row;
        self.selectedCityIdx = 0;
        self.selectedDistrictIdx = 0;
        
        [pickerView reloadComponent:1];
        [pickerView reloadComponent:2];
        [pickerView selectRow:0 inComponent:1 animated:YES];
        [pickerView selectRow:0 inComponent:2 animated:YES];
        
        
        YTProvince *province = self.provinces[row];
        self.provinceLabel.text = province.name;
        
        if (province.cities.count == 0) return;
        
        YTCity *city = province.cities[0];
        self.cityLabel.text = city.name;
        
        if (city.districts.count == 0) return;
        
        YTDistrict *district = city.districts[0];
        self.districtLabel.text = district.name;
        
    } else if (component == 1) {
        
        self.selectedCityIdx = row;
        self.selectedDistrictIdx = 0;
        
        [pickerView reloadComponent:2];
        [pickerView selectRow:0 inComponent:2 animated:YES];
        
        YTProvince *province = self.provinces[self.selectedProviceIdx];
        
        if (province.cities.count == 0) return;
        
        YTCity *city = province.cities[row];
        self.cityLabel.text = city.name;
        
        if (city.districts.count == 0) return;
        YTDistrict *district = city.districts[0];
        self.districtLabel.text = district.name;
        
    } else {
        self.selectedDistrictIdx = row;

        YTProvince *province = self.provinces[self.selectedProviceIdx];
        if (province.cities.count == 0) return;
        YTCity *city = province.cities[self.selectedCityIdx];
        if (city.districts.count == 0) return;
        
        YTDistrict *district = city.districts[row];
        self.districtLabel.text = district.name;
    }
}

#pragma mark - YTAddressPickerViewDelegate
- (void)addressPickerDidSelectedQueryAddress:(YTAddressPickerView *)picker {
    
    YTProvince *province = self.provinces[self.selectedProviceIdx];
    YTCity *city = province.cities[self.selectedCityIdx];
   
    YTDistrict *district = nil;
    if (city.districts.count) {
        district = city.districts[self.selectedDistrictIdx];
        self.districtLabel.text = district.name;
    } else {
        self.districtLabel.text = @"无";
    }
    self.provinceLabel.text = province.name;
    self.cityLabel.text = city.name;
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setValue:@"d6ba9692abd2fe847ef40312077fa940" forKey:@"key"];
    [parameters setValue:province.idString forKey:@"pid"];
    [parameters setValue:city.idString forKey:@"cid"];
    if (city.districts.count) {
        [parameters setObject:district.idString forKey:@"did"];
    }
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    [mgr GET:@"http://v.juhe.cn/postcode/search" parameters:parameters  progress:nil
     success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
         self.postCodes = [YTPostCode mj_objectArrayWithKeyValuesArray:responseObject[@"result"][@"list"]];
         [self.tableView reloadData];
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         NSLog(@"error:%@", error);
     }];
}


@end
