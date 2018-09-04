#import <Foundation/Foundation.h>
#import <ethers/ethers.h>

#define DDYDocument [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]
#define DDYFileName [DDYDocument stringByAppendingPathComponent:@"DDYEther.plist"]

@interface DDYEtherModel : NSObject

@property (nonatomic, strong) NSString *privateKey;

@property (nonatomic, strong) NSString *password;

@property (nonatomic, strong) NSString *address;

@property (nonatomic, strong) NSString *profile;

+ (NSArray <DDYEtherModel *>*)loadData;

+ (DDYEtherModel *)changeModel:(NSString *)privateKey profile:(NSString *)profile;

@end
