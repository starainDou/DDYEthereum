#import <UIKit/UIKit.h>
#import "DDYEtherModel.h"

@interface DDYEtherListCell : UITableViewCell

@property (nonatomic, copy) void (^scanBlock)(NSString *url);

@property (nonatomic, strong) DDYEtherModel *model;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
