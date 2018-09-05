#import "DDYEtherListVC.h"
#import "PAWebView.h"
#import "DDYEtherAddVC.h"
#import "DDYEtherListCell.h"
#import "Masonry.h"

static inline UIColor *barTinColor(){return [UIColor colorWithRed:20./255. green:130./255. blue:1 alpha:1];}

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
        _tableView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
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
    [self loadLocalData];
    [self.navigationController.navigationBar setBarTintColor:barTinColor()];
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];
    [self adjustView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DDYEtherListCell *cell = [DDYEtherListCell cellWithTableView:tableView];
    cell.model = self.dataArray[indexPath.row];
    __weak __typeof (self)weakSelf = self;
    [cell setScanBlock:^(NSString *url) {
        __strong __typeof (weakSelf)strongSelf = weakSelf;
        [strongSelf openURL:url];
    }];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self pushAddVCWithModel:self.dataArray[indexPath.row]];
}

- (void)loadLocalData {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        self.dataArray = [NSMutableArray arrayWithArray:[DDYEtherModel loadData]];
        [self sortModelArray];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    });
}

- (void)handleAdd {
    [self pushAddVCWithModel:nil];
}

- (void)pushAddVCWithModel:(DDYEtherModel *)model {
    __weak __typeof (self)weakSelf = self;
    DDYEtherAddVC *vc = [[DDYEtherAddVC alloc] init];
    [vc setModel:model];
    [vc setFinishBlock:^(DDYEtherModel *model) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            __strong __typeof (weakSelf)strongSelf = weakSelf;
            DDYEtherModel *existModel;
            for (DDYEtherModel *tempModel in strongSelf.dataArray) {
                if ([tempModel.address isEqualToString:model.address]) {
                    existModel = tempModel;
                }
            }
            if (model) {
                if (existModel) {
                    NSUInteger index = [strongSelf.dataArray indexOfObject:existModel];
                    [strongSelf.dataArray replaceObjectAtIndex:index withObject:model];
                } else {
                    [strongSelf.dataArray insertObject:model atIndex:0];
                }
                [strongSelf sortModelArray];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [strongSelf.tableView reloadData];
                    [DDYEtherModel saveModel:model];
                });
            }
            
        });
    }];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)openURL:(NSString *)url {
    PAWebView *webView = [PAWebView shareInstance];
    webView.openCache = YES;
    [webView loadRequestURL:[NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]
                                                    cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                                timeoutInterval:20.0f]];
    [self.navigationController pushViewController:webView animated:YES];
}

- (void)adjustView {
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationController.navigationBar.translucent = NO;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.mas_topLayoutGuide);
        make.bottom.mas_equalTo(self.mas_bottomLayoutGuide);
    }];
}

- (void)sortModelArray {
    NSArray *sortArray = [self.dataArray sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        DDYEtherModel *model1 = (DDYEtherModel *)obj1;
        DDYEtherModel *model2 = (DDYEtherModel *)obj2;
        return model1.sortTime<model2.sortTime ? NSOrderedDescending : model1.sortTime>model2.sortTime ? NSOrderedAscending : NSOrderedSame;
    }];
    self.dataArray = [NSMutableArray arrayWithArray:sortArray];
}

@end
