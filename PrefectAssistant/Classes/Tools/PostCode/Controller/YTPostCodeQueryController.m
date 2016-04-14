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
#import <MJRefresh.h>

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
    
    [self.view setBackgroundColor:YTColorBackground];
    
    UIButton *addressView = [UIButton buttonWithType:UIButtonTypeCustom]; {
        
        [addressView setFrame:CGRectMake(-1, HNav, YTSCREEN_W+2, 40)];
        [addressView addTarget:self action:@selector(choiceAddress) forControlEvents:UIControlEventTouchUpInside];
        [addressView setBackgroundColor:[UIColor whiteColor]];
        [addressView.layer setBorderWidth:HLineSeparate];
        [addressView.layer setBorderColor:YTColorLineSeparate];
        
        CGFloat width = (addressView.width-2) / 3;
        CGFloat height = addressView.height;
        
        UILabel *provinceLabel = [[UILabel alloc] init]; {
            [provinceLabel setFrame:CGRectMake(0, 0, width, height)];
            [provinceLabel setFont:[UIFont systemFontOfSize:15]];
            [provinceLabel setTextAlignment:NSTextAlignmentCenter];
            [provinceLabel setText:@"请选择"];
        }
        [addressView addSubview:provinceLabel];
        self.provinceLabel = provinceLabel;
        
        CGFloat lineY = 10.0f;
        CALayer *leftLineLayer = [[CALayer alloc] init]; {
            [leftLineLayer setFrame:CGRectMake(provinceLabel.rightX, lineY, 1, height-2*lineY)];
            [leftLineLayer setBackgroundColor:YTRandomColor.CGColor];
        }
        [addressView.layer addSublayer:leftLineLayer];
        
        UILabel *cityLabel = [[UILabel alloc] init]; {
            [cityLabel setFrame:CGRectMake(CGRectGetMaxX(leftLineLayer.frame), 0, width, height)];
            [cityLabel setFont:[UIFont systemFontOfSize:15]];
            [cityLabel setTextAlignment:NSTextAlignmentCenter];
            [cityLabel setText:@"请选择"];
        }
        [addressView addSubview:cityLabel];
        self.cityLabel = cityLabel;
        
        CALayer *rightLineLayer = [[CALayer alloc] init]; {
            [rightLineLayer setFrame:CGRectMake(cityLabel.rightX, lineY, 1, height-2*lineY)];
            [rightLineLayer setBackgroundColor:YTRandomColor.CGColor];
        }
        [addressView.layer addSublayer:rightLineLayer];
        
        UILabel *districtLabel = [[UILabel alloc] init]; {
            [districtLabel setFrame:CGRectMake(CGRectGetMaxX(rightLineLayer.frame), 0, width, height)];
            [districtLabel setFont:[UIFont systemFontOfSize:15]];
            [districtLabel setTextAlignment:NSTextAlignmentCenter];
            [districtLabel setText:@"请选择"];
        }
        [addressView addSubview:districtLabel];
        self.districtLabel = districtLabel;
    }
    [self.view addSubview:addressView];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, addressView.bottomY, YTSCREEN_W, YTSCREEN_H - addressView.bottomY)
                                                          style:UITableViewStylePlain]; {
        
        [tableView setBackgroundColor:YTColorBackground];
        [tableView setDelegate:self];
        [tableView setDataSource:self];
        [tableView setTableFooterView:[[UIView alloc] init]];
        [tableView setMj_header:[MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [self addressPickerDidSelectedQueryAddress:nil];
        }]];
        [tableView.mj_header beginRefreshing];
    }
    [self.view addSubview:tableView];
    self.tableView = tableView;
}
- (void)choiceAddress {
    
    YTAddressPickerView *pickerView = [[YTAddressPickerView alloc] init];
    [pickerView setDelegate:self];
    [pickerView showPikerView];
    
    [pickerView.picker selectRow:self.selectedProviceIdx inComponent:0 animated:YES];
    [pickerView.picker selectRow:self.selectedCityIdx inComponent:1 animated:YES];
    [pickerView.picker selectRow:self.selectedDistrictIdx inComponent:2 animated:YES];
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
        [cell.textLabel setTextColor:YTColorGrayText];
        [cell.textLabel setFont:[UIFont systemFontOfSize:15]];
        [cell.detailTextLabel setTextColor:YTColorTintText];
        [cell.detailTextLabel setFont:[UIFont systemFontOfSize:12]];
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
    [parameters setValue:APIPostCodeKey forKey:@"key"];
    [parameters setValue:province.idString forKey:@"pid"];
    [parameters setValue:city.idString forKey:@"cid"];
    if (city.districts.count) {
        [parameters setObject:district.idString forKey:@"did"];
    }
    
    [YTHTTPTool get:APIPostCodeSearchQ parameters:parameters success:^(id responseObject) {
        [self.tableView.mj_header endRefreshing];
        self.postCodes = [YTPostCode mj_objectArrayWithKeyValuesArray:responseObject[@"result"][@"list"]];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
       [self.tableView.mj_header endRefreshing];
    }];
}


@end
