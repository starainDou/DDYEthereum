#import <UIKit/UIKit.h>
#import "DDYEtherModel.h"

@interface DDYEtherAddVC : UIViewController

@property (nonatomic, strong) DDYEtherModel *model;

@property (nonatomic, copy) void (^finishBlock)(DDYEtherModel *model);

@end
