#import "DDYEtherModel.h"

@implementation DDYEtherModel

+ (NSArray <DDYEtherModel *>*)loadData {
    NSMutableArray *dataArray = [NSMutableArray array];
    NSArray *tempArray = [NSArray arrayWithContentsOfFile:DDYFileName];
    for (NSDictionary *tempDict in tempArray) {
        @autoreleasepool {
            DDYEtherModel *model = [[DDYEtherModel alloc] init];
            model.privateKey = tempDict[@"privateKey"];
            model.password = tempDict[@"password"];
            model.address = tempDict[@"address"];
            model.profile = tempDict[@"profile"];
            [dataArray addObject:model];  
        }
    }
    return dataArray;
}

+ (DDYEtherModel *)changeModel:(NSString *)privateKey profile:(NSString *)profile {
    NSString *privateKey1 = [privateKey  stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *privateKey2 = [privateKey1 stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    NSString *privateKey3 = [privateKey2 stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    NSString *privateKey4 = [privateKey3 substringToIndex:64];
    NSString *privateKey5 = [@"0x" stringByAppendingString:privateKey4];
    NSData *data = [SecureData secureDataWithHexString:privateKey5].data;
    Account *account = [Account accountWithPrivateKey:data];
    
    DDYEtherModel *model = [[DDYEtherModel alloc] init];
    model.privateKey = privateKey;
    model.password = [privateKey3 substringFromIndex:64];
    model.address = account.address.checksumAddress;
    model.profile = profile;
    
    return model;
}

@end
