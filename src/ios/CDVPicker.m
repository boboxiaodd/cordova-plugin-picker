#import <Cordova/CDV.h>
#import "CDVPicker.h"
#import <BRPickerView/BRPickerView.h>

@implementation CDVPicker
-(void)open_datepicker:(CDVInvokedUrlCommand *)command
{
    NSDictionary *options = [command.arguments objectAtIndex: 0];
    BRDatePickerView *datePickerView = [[BRDatePickerView alloc]init];
    datePickerView.pickerMode = BRDatePickerModeYMD;
    datePickerView.title = [options valueForKey:@"title"];
    NSString * select = [options valueForKey:@"select"];
    NSString * max_date = [options valueForKey:@"max"];
    NSString * min_date = [options valueForKey:@"min"];
    if(select) datePickerView.selectDate = [self dateFromString:select];
    if(min_date) datePickerView.minDate = [self dateFromString:min_date];
    if(max_date) datePickerView.maxDate = [self dateFromString:max_date];
    datePickerView.pickerStyle.pickerColor = [UIColor whiteColor];
    datePickerView.pickerStyle.doneColor = [UIColor clearColor];
    datePickerView.pickerStyle.doneTextColor = [UIColor blackColor];
    datePickerView.pickerStyle.cancelColor = [UIColor clearColor];
    datePickerView.pickerStyle.cancelTextColor = [UIColor blackColor];
    datePickerView.pickerStyle.titleTextColor = [UIColor blackColor];
    datePickerView.pickerStyle.titleBarColor = [UIColor whiteColor];
    datePickerView.pickerStyle.separatorColor = [self colorWithHex:0xe9e9e9];
    datePickerView.pickerStyle.titleTextColor = [UIColor whiteColor];
    datePickerView.pickerStyle.selectRowTextColor = [UIColor blackColor];
    datePickerView.pickerStyle.pickerTextColor = [UIColor blackColor];
    datePickerView.pickerStyle.titleLineColor = [self colorWithHex:0xe9e9e9];

    datePickerView.isAutoSelect = NO;
    datePickerView.resultBlock = ^(NSDate *selectDate, NSString *selectValue) {
        [self send_event:command withMessage:@{@"result":selectValue} Alive:NO State:YES];
    };
    [datePickerView show];
}
-(void)open_datetimepikcer:(CDVInvokedUrlCommand *)command
{
    NSDictionary *options = [command.arguments objectAtIndex: 0];
    BRDatePickerView *datePickerView = [[BRDatePickerView alloc]init];
    datePickerView.pickerMode = BRDatePickerModeYMDHM;
    datePickerView.title = [options valueForKey:@"title"];
    NSString * select = [options valueForKey:@"select"];
    NSString * max_date = [options valueForKey:@"max"];
    NSString * min_date = [options valueForKey:@"min"];
    if(select) datePickerView.selectDate = [self dateFromString:select];
    if(min_date) datePickerView.minDate = [self dateFromString:min_date];
    if(max_date) datePickerView.maxDate = [self dateFromString:max_date];

    datePickerView.pickerStyle.pickerColor = [UIColor whiteColor];
    datePickerView.pickerStyle.doneColor = [UIColor clearColor];
    datePickerView.pickerStyle.doneTextColor = [UIColor blackColor];
    datePickerView.pickerStyle.cancelColor = [UIColor clearColor];
    datePickerView.pickerStyle.cancelTextColor = [UIColor blackColor];
    datePickerView.pickerStyle.titleTextColor = [UIColor blackColor];
    datePickerView.pickerStyle.titleBarColor = [UIColor whiteColor];
    datePickerView.pickerStyle.separatorColor = [self colorWithHex:0xe9e9e9];
    datePickerView.pickerStyle.titleTextColor = [UIColor whiteColor];
    datePickerView.pickerStyle.selectRowTextColor = [UIColor blackColor];
    datePickerView.pickerStyle.pickerTextColor = [UIColor blackColor];
    datePickerView.pickerStyle.titleLineColor = [self colorWithHex:0xe9e9e9];

    datePickerView.isAutoSelect = NO;
    datePickerView.resultBlock = ^(NSDate *selectDate, NSString *selectValue) {
        [self send_event:command withMessage:@{@"result":selectValue} Alive:NO State:YES];
    };
    [datePickerView show];
}

-(void)open_picker:(CDVInvokedUrlCommand *)command
{
    NSDictionary *options = [command.arguments objectAtIndex: 0];
    BRStringPickerView *stringPickerView = [[BRStringPickerView alloc]init];
    stringPickerView.pickerMode = BRStringPickerComponentSingle;
    stringPickerView.title = [options valueForKey:@"title"];
    stringPickerView.dataSourceArr = [options valueForKey:@"list"];
    stringPickerView.selectValue = [options valueForKey:@"select"];

    stringPickerView.pickerStyle.pickerColor = [UIColor whiteColor];
    stringPickerView.pickerStyle.doneColor = [UIColor clearColor];
    stringPickerView.pickerStyle.doneTextColor = [UIColor blackColor];
    stringPickerView.pickerStyle.cancelColor = [UIColor clearColor];
    stringPickerView.pickerStyle.cancelTextColor = [UIColor blackColor];
    stringPickerView.pickerStyle.titleTextColor = [UIColor blackColor];
    stringPickerView.pickerStyle.titleBarColor = [UIColor whiteColor];
    stringPickerView.pickerStyle.separatorColor = [self colorWithHex:0xe9e9e9];
    stringPickerView.pickerStyle.titleTextColor = [UIColor whiteColor];
    stringPickerView.pickerStyle.selectRowTextColor = [UIColor blackColor];
    stringPickerView.pickerStyle.pickerTextColor = [UIColor blackColor];
    stringPickerView.pickerStyle.titleLineColor = [self colorWithHex:0xe9e9e9];
    stringPickerView.isAutoSelect = NO;
    stringPickerView.resultModelBlock = ^(BRResultModel *resultModel) {
        [self send_event:command withMessage:@{@"value":resultModel.value} Alive:NO State:YES];
    };
    [stringPickerView show];
}

-(void)open_citypicker:(CDVInvokedUrlCommand *)command
{
    NSDictionary *options = [command.arguments objectAtIndex: 0];
    BRAddressPickerView *addressPickerView = [[BRAddressPickerView alloc]init];
    BOOL onlycity = [[options valueForKey:@"onlycity"] boolValue] || NO;
    if(onlycity){
        addressPickerView.pickerMode = BRAddressPickerModeCity;
    }else{
        addressPickerView.pickerMode = BRAddressPickerModeArea;
    }
    addressPickerView.title = [options valueForKey:@"title"];
    NSString * city = [options valueForKey:@"city"];
    if(city){
        addressPickerView.selectValues = [city componentsSeparatedByString:@","];
    }
    addressPickerView.resultBlock = ^(BRProvinceModel *province, BRCityModel *city, BRAreaModel *area) {
        [self send_event:command withMessage:@{@"province": province.name, @"city": city.name , @"area" : area.name} Alive:NO State:YES];
    };
    addressPickerView.pickerStyle.pickerColor = [UIColor whiteColor];
    addressPickerView.pickerStyle.doneColor = [UIColor clearColor];
    addressPickerView.pickerStyle.doneTextColor = [UIColor blackColor];
    addressPickerView.pickerStyle.cancelColor = [UIColor clearColor];
    addressPickerView.pickerStyle.cancelTextColor = [UIColor blackColor];
    addressPickerView.pickerStyle.titleTextColor = [UIColor blackColor];
    addressPickerView.pickerStyle.titleBarColor = [UIColor whiteColor];
    addressPickerView.pickerStyle.separatorColor = [self colorWithHex:0xe9e9e9];
    addressPickerView.pickerStyle.titleTextColor = [UIColor whiteColor];
    addressPickerView.pickerStyle.selectRowTextColor = [UIColor blackColor];
    addressPickerView.pickerStyle.pickerTextColor = [UIColor blackColor];
    addressPickerView.pickerStyle.titleLineColor = [self colorWithHex:0xe9e9e9];
    [addressPickerView show];
}

#pragma mark 公共方法

- (void)send_event:(CDVInvokedUrlCommand *)command withMessage:(NSDictionary *)message Alive:(BOOL)alive State:(BOOL)state{
    if(!command) return;
    CDVPluginResult* res = [CDVPluginResult resultWithStatus: (state ? CDVCommandStatus_OK : CDVCommandStatus_ERROR) messageAsDictionary:message];
    if(alive) [res setKeepCallbackAsBool:YES];
    [self.commandDelegate sendPluginResult: res callbackId: command.callbackId];
}
- (NSDate *) dateFromString:(NSString *)str
{
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy/MM/dd"];
    return [formatter dateFromString:str];
}
- (UIColor *) colorWithHex:(int)color {
    float red = (color & 0xff0000) >> 16;
    float green = (color & 0x00ff00) >> 8;
    float blue = (color & 0x0000ff);
    return [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:1];
}
@end
