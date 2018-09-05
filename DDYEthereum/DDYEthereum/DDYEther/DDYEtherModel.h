#import <Foundation/Foundation.h>
#import <ethers/ethers.h>

#define DDYDocument [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]
#define DDYFileName [DDYDocument stringByAppendingPathComponent:@"/DDYEther.plist"]

@interface DDYEtherModel : NSObject

@property (nonatomic, strong) NSString *privateKey;

@property (nonatomic, strong) NSString *address;

@property (nonatomic, strong) NSString *profile;

@property (nonatomic, strong) NSString *personName;

@property (nonatomic, assign) NSInteger sortTime;

+ (NSArray <DDYEtherModel *>*)loadData;

+ (DDYEtherModel *)modelPrivateKey:(NSString *)privateKey profile:(NSString *)profile personName:(NSString *)personName;

+ (void)saveModel:(DDYEtherModel *)model;

@end
