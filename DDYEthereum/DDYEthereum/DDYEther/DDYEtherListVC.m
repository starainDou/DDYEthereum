#import "DDYEtherListVC.h"
#import "DDYEtherScanVC.h"
#import "DDYEtherAddVC.h"
#import "DDYEtherListCell.h"

@interface DDYEtherListVC ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation DDYEtherListVC

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        _tableView.estimatedRowHeight = 70;
        _tableView.rowHeight = UITableViewAutomaticDimension;
    }
    return _tableView;
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                                           target:self
                                                                                           action:@selector(handleAdd)];
    [self.view addSubview:self.tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DDYEtherListCell *cell = [DDYEtherListCell cellWithTableView:tableView];
    cell.model = self.dataArray[indexPath.row];
    return cell;
}

- (void)loadLocalData {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        self.dataArray = [NSMutableArray arrayWithArray:[DDYEtherModel loadData]];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    });
}

- (void)handleAdd {
    __weak __typeof (self)weakSelf = self;
    DDYEtherAddVC *addVC = [[DDYEtherAddVC alloc] init];
    [addVC setFinishBlock:^(DDYEtherModel *model) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            __strong __typeof (weakSelf)strongSelf = weakSelf;
            BOOL canAdd = YES;
            for (DDYEtherModel *tempModel in strongSelf.dataArray) {
                if ([tempModel.address isEqualToString:model.address]) {
                    canAdd = NO;
                }
            }
            if (canAdd) {
                [strongSelf.dataArray addObject:model];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [strongSelf.tableView reloadData];
            });
        });
    }];
    [self.navigationController pushViewController:addVC animated:YES];
}

@end
