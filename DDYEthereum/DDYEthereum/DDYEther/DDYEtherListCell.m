#import "DDYEtherListCell.h"
#import "Masonry.h"

@interface DDYEtherListCell ()

@property (nonatomic, strong) UIView *backView;

@property (nonatomic, strong) UILabel *privateKeyLabel;

@property (nonatomic, strong) UILabel *addressLabel;

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

- (UILabel *)privateKeyLabel {
    if (!_privateKeyLabel) {
        _privateKeyLabel = [[UILabel alloc] init];
        [_privateKeyLabel setNumberOfLines:0];
        [_privateKeyLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    }
    return _privateKeyLabel;
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
        [self.contentView addSubview:self.privateKeyLabel];
        [self.contentView addSubview:self.addressLabel];
    }
    return self;
}

- (void)setModel:(DDYEtherModel *)model {
    _model = model;
    self.privateKeyLabel.text = _model.privateKey;
    self.addressLabel.text = _model.address;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.backView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(self.contentView).offset(10);
        make.right.bottom.mas_equalTo(self.contentView).offset(-10);
    }];
    [self.privateKeyLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(self.backView).offset(5);
        make.right.mas_equalTo(self.backView).offset(-5);
    }];
    [self.addressLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.backView).offset(5);
        make.top.mas_equalTo(self.privateKeyLabel.mas_bottom).offset(10);
        make.bottom.right.mas_equalTo(self.backView).offset(-5);
    }];
}

@end
