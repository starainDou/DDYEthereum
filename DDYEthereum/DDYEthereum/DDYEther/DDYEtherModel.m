#import "DDYEtherModel.h"

@implementation DDYEtherModel

+ (NSArray <DDYEtherModel *>*)loadData {
    NSMutableArray *dataArray = [NSMutableArray array];
    NSDictionary *dataDict = [NSDictionary dictionaryWithContentsOfFile:DDYFileName];
    for (NSString *privateKey in dataDict.allKeys) {
        @autoreleasepool {
            DDYEtherModel *model = [[DDYEtherModel alloc] init];
            model.privateKey = privateKey;
            model.address = dataDict[privateKey][@"address"];
            model.profile = dataDict[privateKey][@"profile"];
            model.personName = dataDict[privateKey][@"personName"];
            model.sortTime = [dataDict[privateKey][@"sortTime"] integerValue];
            [dataArray addObject:model];  
        }
    }
    return dataArray;
}

+ (DDYEtherModel *)modelPrivateKey:(NSString *)privateKey profile:(NSString *)profile personName:(NSString *)personName {
    NSString *privateKey1 = [privateKey  stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *privateKey2 = [privateKey1 stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    NSString *privateKey3 = [privateKey2 stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    if (privateKey3.length == 64) {
        NSString *privateKey4 = [@"0x" stringByAppendingString:privateKey3];
        NSData *data = [SecureData secureDataWithHexString:privateKey4].data;
        Account *account = [Account accountWithPrivateKey:data];
        if (account && account.address && account.address.checksumAddress) {
            DDYEtherModel *model = [[DDYEtherModel alloc] init];
            model.privateKey = privateKey;
            model.address = account.address.checksumAddress;
            model.profile = profile ? profile : @"[-暂无-]";
            model.personName = personName ? personName : @"[-暂无-]";
            model.sortTime = ceil([[NSDate date] timeIntervalSince1970]);
            return model;
        }
    }
    return nil;
}

+ (void)saveModel:(DDYEtherModel *)model {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSMutableDictionary *dataDict = [NSMutableDictionary dictionaryWithContentsOfFile:DDYFileName];
        if (!dataDict) dataDict = [NSMutableDictionary dictionary];
        NSMutableDictionary *tempDict = [NSMutableDictionary dictionary];
        tempDict[@"address"] = model.address;
        tempDict[@"profile"] = model.profile;
        tempDict[@"personName"] = model.personName;
        tempDict[@"sortTime"] = @(model.sortTime);
        dataDict[model.privateKey] = tempDict;
        [dataDict writeToFile:DDYFileName atomically:YES];
    });
}

@end
