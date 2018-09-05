#import "DDYEtherListCell.h"
#import "Masonry.h"

@interface DDYEtherListCell ()

@property (nonatomic, strong) UIView *backView;

@property (nonatomic, strong) UILabel *personNameLabel;

@property (nonatomic, strong) UILabel *profileLabel;

@property (nonatomic, strong) UILabel *addressLabel;

@property (nonatomic, strong) UILabel *privateKeyLabel;

@property (nonatomic, strong) UIButton *spectrumButton;

@property (nonatomic, strong) UIButton *ethereumButton;

@end

@implementation DDYEtherListCell

- (UIView *)backView {
    if (!_backView) {
        _backView = [[UIView alloc] init];
        _backView.layer.cornerRadius = 6;
        _backView.layer.masksToBounds = YES;
        _backView.backgroundColor = [UIColor whiteColor];
    }
    return _backView;
}

- (UILabel *)personNameLabel {
    if (!_personNameLabel) {
        _personNameLabel = [[UILabel alloc] init];
        [_personNameLabel setFont:[UIFont systemFontOfSize:16]];
        [_personNameLabel setNumberOfLines:0];
        [_personNameLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    }
    return _personNameLabel;
}

- (UILabel *)profileLabel {
    if (!_profileLabel) {
        _profileLabel = [[UILabel alloc] init];
        [_profileLabel setFont:[UIFont systemFontOfSize:12]];
        [_profileLabel setNumberOfLines:0];
        [_profileLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    }
    return _profileLabel;
}

- (UILabel *)addressLabel {
    if (!_addressLabel) {
        _addressLabel = [[UILabel alloc] init];
        [_addressLabel setFont:[UIFont systemFontOfSize:14]];
        [_addressLabel setNumberOfLines:0];
        [_addressLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    }
    return _addressLabel;
}

- (UILabel *)privateKeyLabel {
    if (!_privateKeyLabel) {
        _privateKeyLabel = [[UILabel alloc] init];
        [_privateKeyLabel setFont:[UIFont systemFontOfSize:12]];
        [_privateKeyLabel setNumberOfLines:0];
        [_privateKeyLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    }
    return _privateKeyLabel;
}

- (UIButton *)spectrumButton {
    if (!_spectrumButton) {
        _spectrumButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_spectrumButton setTitle:@"Spectrum" forState:UIControlStateNormal];
        [_spectrumButton.titleLabel setFont:[UIFont boldSystemFontOfSize:16]];
        [_spectrumButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_spectrumButton setBackgroundColor:[UIColor lightGrayColor]];
        [_spectrumButton setTag:100];
        [_spectrumButton addTarget:self action:@selector(handleButton:) forControlEvents:UIControlEventTouchUpInside];
        [_spectrumButton.layer setCornerRadius:4];
        [_spectrumButton.layer setMasksToBounds:YES];
    }
    return _spectrumButton;
}

- (UIButton *)ethereumButton {
    if (!_ethereumButton) {
        _ethereumButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_ethereumButton setTitle:@"Ethereum" forState:UIControlStateNormal];
        [_ethereumButton.titleLabel setFont:[UIFont boldSystemFontOfSize:16]];
        [_ethereumButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_ethereumButton setBackgroundColor:[UIColor lightGrayColor]];
        [_ethereumButton setTag:101];
        [_ethereumButton addTarget:self action:@selector(handleButton:) forControlEvents:UIControlEventTouchUpInside];
        [_ethereumButton.layer setCornerRadius:4];
        [_ethereumButton.layer setMasksToBounds:YES];
    }
    return _ethereumButton;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    NSString *cellID = NSStringFromClass([self class]);
    DDYEtherListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    return cell?cell:[[self alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView setBackgroundColor:[UIColor colorWithWhite:0.9 alpha:1]];
        [self.contentView addSubview:self.backView];
        [self.contentView addSubview:self.personNameLabel];
        [self.contentView addSubview:self.profileLabel];
        [self.contentView addSubview:self.privateKeyLabel];
        [self.contentView addSubview:self.addressLabel];
        [self.contentView addSubview:self.spectrumButton];
        [self.contentView addSubview:self.ethereumButton];
    }
    return self;
}

- (void)setModel:(DDYEtherModel *)model {
    _model = model;
    self.personNameLabel.text = _model.personName;
    self.addressLabel.text = _model.address;
    self.privateKeyLabel.text = _model.privateKey;
    [self layoutIfNeeded];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.backView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).offset(10);
        make.top.mas_equalTo(self.contentView).offset(15);
        make.right.mas_equalTo(self.contentView).offset(-10);
        make.bottom.mas_equalTo(self.contentView).offset(0);
    }];
    [self.personNameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.backView).offset(10);
        make.right.mas_equalTo(self.backView).offset(-10);
        make.top.mas_equalTo(self.backView).offset(10);
    }];
    
    [self.profileLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.backView).offset(10);
        make.right.mas_equalTo(self.backView).offset(-10);
        make.top.mas_equalTo(self.personNameLabel.mas_bottom).offset(10);
    }];
    [self.addressLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.backView).offset(10);
        make.right.mas_equalTo(self.backView).offset(-10);
        make.top.mas_equalTo(self.profileLabel.mas_bottom).offset(10);
    }];
    [self.privateKeyLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.backView).offset(10);
        make.right.mas_equalTo(self.backView).offset(-10);
        make.top.mas_equalTo(self.addressLabel.mas_bottom).offset(10);
    }];
    [self.spectrumButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.backView).offset(10);
        make.right.mas_equalTo(self.backView.mas_centerX).offset(-10);
        make.top.mas_equalTo(self.privateKeyLabel.mas_bottom).offset(15);
        make.height.mas_equalTo(30);
    }];
    [self.ethereumButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.backView.mas_centerX).offset(10);
        make.right.mas_equalTo(self.backView).offset(-10);
        make.top.mas_equalTo(self.spectrumButton.mas_top);
        make.height.mas_equalTo(30);
        make.bottom.right.mas_equalTo(self.backView).offset(-15);
    }];
}

- (void)handleButton:(UIButton *)button {
    NSString *spectrumURL = [NSString stringWithFormat:@"http://spectrum.pub/address.html?address=%@",_model.address];
    NSString *ethereumURL = [NSString stringWithFormat:@"https://etherscan.io/address/%@", _model.address];
    if (self.scanBlock) {
        self.scanBlock(button.tag == 100 ? spectrumURL : ethereumURL);
    }
}

@end
