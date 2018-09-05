#import "DDYEtherAddVC.h"
#import "Masonry.h"

@interface DDYEtherAddVC ()<UITextViewDelegate>

@property (nonatomic, strong) UILabel *personNameLabel;

@property (nonatomic, strong) UITextView *personNameTextView;

@property (nonatomic, strong) UILabel *privateKeyLabel;

@property (nonatomic, strong) UITextView *privateKeyTextView;

@property (nonatomic, strong) UILabel *profileLabel;

@property (nonatomic, strong) UITextView *profileTextView;

@property (nonatomic, strong) UIButton *confirmButton;

@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation DDYEtherAddVC

- (UILabel *)personNameLabel {
    if (!_personNameLabel) {
        _personNameLabel = [[UILabel alloc] init];
        _personNameLabel.font = [UIFont boldSystemFontOfSize:16];
        _personNameLabel.textColor = [UIColor blackColor];
        _personNameLabel.textAlignment = NSTextAlignmentCenter;
        _personNameLabel.text = @"Person Name";
        _personNameLabel.numberOfLines = 0;
        _personNameLabel.preferredMaxLayoutWidth = [UIScreen mainScreen].bounds.size.width;
        [_personNameLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    }
    return _personNameLabel;
}

- (UILabel *)privateKeyLabel {
    if (!_privateKeyLabel) {
        _privateKeyLabel = [[UILabel alloc] init];
        _privateKeyLabel.font = [UIFont boldSystemFontOfSize:16];
        _privateKeyLabel.textColor = [UIColor blackColor];
        _privateKeyLabel.textAlignment = NSTextAlignmentCenter;
        _privateKeyLabel.text = @"Private Key";
        _privateKeyLabel.numberOfLines = 0;
        _privateKeyLabel.preferredMaxLayoutWidth = [UIScreen mainScreen].bounds.size.width;
        [_privateKeyLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    }
    return _privateKeyLabel;
}

- (UILabel *)profileLabel {
    if (!_profileLabel) {
        _profileLabel = [[UILabel alloc] init];
        _profileLabel.font = [UIFont boldSystemFontOfSize:16];
        _profileLabel.textColor = [UIColor blackColor];
        _profileLabel.textAlignment = NSTextAlignmentCenter;
        _profileLabel.text = @"Profile";
        _profileLabel.numberOfLines = 0;
        _profileLabel.preferredMaxLayoutWidth = [UIScreen mainScreen].bounds.size.width;
        [_profileLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    }
    return _profileLabel;
}

- (UITextView *)personNameTextView {
    if (!_personNameTextView) {
        _personNameTextView = [[UITextView alloc] init];
        _personNameTextView.delegate = self;
        _personNameTextView.showsVerticalScrollIndicator = NO;
        _personNameTextView.showsHorizontalScrollIndicator = NO;
        _personNameTextView.bounces = NO;
        _personNameTextView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _personNameTextView.layer.borderWidth = 0.5;
        _personNameTextView.font = [UIFont fontWithName:@"Courier" size:16];
    }
    return _personNameTextView;
}

- (UITextView *)privateKeyTextView {
    if (!_privateKeyTextView) {
        _privateKeyTextView = [[UITextView alloc] init];
        _privateKeyTextView.delegate = self;
        _privateKeyTextView.showsVerticalScrollIndicator = NO;
        _privateKeyTextView.showsHorizontalScrollIndicator = NO;
        _privateKeyTextView.bounces = NO;
        _privateKeyTextView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _privateKeyTextView.layer.borderWidth = 0.5;
        _privateKeyTextView.font = [UIFont systemFontOfSize:14];
    }
    return _privateKeyTextView;
}

- (UITextView *)profileTextView {
    if (!_profileTextView) {
        _profileTextView = [[UITextView alloc] init];
        _profileTextView.delegate = self;
        _profileTextView.showsVerticalScrollIndicator = NO;
        _profileTextView.showsHorizontalScrollIndicator = NO;
        _profileTextView.bounces = NO;
        _profileTextView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _profileTextView.layer.borderWidth = 0.5;
        _profileTextView.font = [UIFont systemFontOfSize:12];
    }
    return _profileTextView;
}

- (UIButton *)confirmButton {
    if (!_confirmButton) {
        _confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_confirmButton setTitle:@"OK" forState:UIControlStateNormal];
        [_confirmButton.titleLabel setFont:[UIFont boldSystemFontOfSize:20]];
        [_confirmButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_confirmButton setBackgroundColor:[UIColor lightGrayColor]];
        [_confirmButton addTarget:self action:@selector(handleConfirm:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmButton;
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        _scrollView.bounces = NO;
        _scrollView.contentSize = self.view.bounds.size;
        [_scrollView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)]];
    }
    return _scrollView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.personNameLabel];
    [self.scrollView addSubview:self.personNameTextView];
    [self.scrollView addSubview:self.privateKeyLabel];
    [self.scrollView addSubview:self.privateKeyTextView];
    [self.scrollView addSubview:self.profileLabel];
    [self.scrollView addSubview:self.profileTextView];
    [self.scrollView addSubview:self.confirmButton];
    [self addNotification];
    [self makeConstraint];
    [self adjustView];
}

- (void)setModel:(DDYEtherModel *)model {
    if (model) {
        _model = model;
        self.privateKeyTextView.text = model.privateKey;
        self.profileTextView.text = model.profile;
        self.personNameTextView.text = model.personName;
        self.privateKeyTextView.editable = NO;
    }
}

- (void)makeConstraint {
    
    [self.personNameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(10);
        make.right.mas_equalTo(self.view).offset(-10);
        make.top.mas_equalTo(self.scrollView.mas_top).offset(20);
    }];
    [self.personNameTextView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(10);
        make.right.mas_equalTo(self.view).offset(-10);
        make.top.mas_equalTo(self.personNameLabel.mas_bottom).offset(15);
        make.height.mas_equalTo(40);
    }];
    
    [self.privateKeyLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(10);
        make.right.mas_equalTo(self.view).offset(-10);
        make.top.mas_equalTo(self.personNameTextView.mas_bottom).offset(35);
    }];
    [self.privateKeyTextView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(10);
        make.right.mas_equalTo(self.view).offset(-10);
        make.top.mas_equalTo(self.privateKeyLabel.mas_bottom).offset(15);
        make.height.mas_equalTo(100);
    }];
    
    [self.profileLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(10);
        make.right.mas_equalTo(self.view).offset(-10);
        make.top.mas_equalTo(self.privateKeyTextView.mas_bottom).offset(35);
    }];
    [self.profileTextView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(10);
        make.right.mas_equalTo(self.view).offset(-10);
        make.top.mas_equalTo(self.profileLabel.mas_bottom).offset(15);
        make.height.mas_equalTo(100);
    }];
    
    [self.confirmButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(10);
        make.right.mas_equalTo(self.view).offset(-10);
        make.top.mas_equalTo(self.profileTextView.mas_bottom).offset(40);
        make.height.mas_equalTo(40);
        make.bottom.mas_equalTo(self.scrollView.mas_bottom).offset(-20);
    }];
}

- (void)handleConfirm:(UIButton *)button {
    if (self.privateKeyTextView.text.length>0 && self.finishBlock) {
        NSString *privateKey = self.privateKeyTextView.text;
        NSString *profile = self.profileTextView.text;
        NSString *personName = self.personNameTextView.text;
        self.finishBlock([DDYEtherModel modelPrivateKey:privateKey profile:profile personName:personName]);
    }
    if (![self.navigationController popViewControllerAnimated:YES]) {
        [self dismissViewControllerAnimated:YES completion:^{ }];
    }
}

- (void)tap {
    [self.view endEditing:NO];
}

#pragma mark - 通知 Notification
#pragma mark 注册通知
- (void)addNotification {
    // 键盘将要弹出通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    // 键盘将要收回通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

#pragma mark 键盘将要弹出通知响应
- (void)keyboardWillShow:(NSNotification *)notification {
    if ([notification.userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue].size.height > 0) {
        CGFloat keyboardH = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
        [UIView animateWithDuration:0.25 animations:^{
            self.scrollView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height-keyboardH);
        }];
    }
}

#pragma mark 键盘将要收回通知响应
- (void)keyboardWillHide:(NSNotification *)notification {
    [UIView animateWithDuration:0.25 animations:^{
        self.scrollView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    }];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)adjustView {
    if (@available(iOS 11.0, *)) {
        self.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationController.navigationBar.translucent = NO;
}

@end
