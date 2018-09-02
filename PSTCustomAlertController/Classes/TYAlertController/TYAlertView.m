//
//  TYAlertView.m
//  TYAlertControllerDemo
//
//  Created by tanyang on 15/9/7.
//  Copyright (c) 2015年 tanyang. All rights reserved.
//

#import "TYAlertView.h"
#import "UIView+TYAlertView.h"
#import "UIView+TYAutoLayout.h"
#import "UIView+borders.h"
#import <Masonry/Masonry.h>
#import "PSTAlertController.h"

@interface TYAlertView ()

// text content View
@property (nonatomic, weak) UIView *textContentView;
@property (nonatomic, weak) UILabel *titleLable;
@property (nonatomic, weak) UILabel *messageLabel;

@property (nonatomic, weak) UIView *textFieldContentView;
@property (nonatomic, weak) NSLayoutConstraint *textFieldTopConstraint;
@property (nonatomic, strong) NSMutableArray *textFields;
@property (nonatomic, strong) NSMutableArray *textFieldSeparateViews;

// button content View
@property (nonatomic, weak) UIView *buttonContentView;
@property (nonatomic, weak) NSLayoutConstraint *buttonTopConstraint;
@property (nonatomic, strong) NSMutableArray *buttons;
@property (nonatomic, strong) NSMutableArray *actions;
@property (nonatomic, assign) NSUInteger preferActionIndex;

@end

#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

#define IS_PAD (UI_USER_INTERFACE_IDIOM()== UIUserInterfaceIdiomPad)

#define UI_DESIGN_SCALE_RATE (IS_IPHONE ? [UIScreen mainScreen].bounds.size.width/375.0f : [UIScreen mainScreen].bounds.size.height/667.0f)
#define UI_SIZE(size) (ceil(size * UI_DESIGN_SCALE_RATE))


#define kAlertViewWidth UI_SIZE(280)
#define kContentViewEdge 22
#define kContentViewSpace 20
#define kContentViewTopSpace 27

#define kButtonsTopSpace (1.0f)

#define kTextLabelSpace  14

#define kButtonTagOffset 1000
#define kButtonSpace     1
#define kButtonViewEdge  0
#define KButtonHeight    57

#define kTextFieldOffset 10000
#define kTextFieldHeight 29
#define kTextFieldEdge  8
#define KTextFieldBorderWidth 0.5

#define kBorderColor [UIColor colorWithWhite:0xd7/255.0 alpha:1.0f]
#define kActionSheetTextColor [UIColor colorWithWhite:0x62/255.0 alpha:1.0f]
#define kActionDisableColor [UIColor colorWithWhite:0xA1/255.0 alpha:1.0f]

@implementation TYAlertView

#pragma mark - init

@dynamic title, message;

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self configureProperty];
        
        [self addContentViews];
        
        [self addTextLabels];
        
    }
    return self;
}

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message
{
    if (self = [self init]) {
        if (!title && message ) {
            title = message;
            message = nil;
            self.titleLable.font = [UIFont boldSystemFontOfSize:17.0f];
            _titleLable.numberOfLines = 0;
        }
        _titleLable.text = title;
        _messageLabel.text = message;
        
    }
    return self;
}

+ (instancetype)alertViewWithTitle:(NSString *)title message:(NSString *)message
{
    return [[self alloc]initWithTitle:title message:message];
}


- (void)setTitle:(NSString *)title
{
    _titleLable.text = title;
}

- (NSString *)title
{
    return _titleLable.text;
}

- (void)setMessage:(NSString *)message
{
    _messageLabel.text = message;
}

- (NSString*)message
{
    return _messageLabel.text;
}

#pragma mark - configure

- (void)configureProperty
{
    _clickedAutoHide = YES;
    self.backgroundColor = [UIColor whiteColor];
    _alertViewWidth = kAlertViewWidth;
    _contentViewSpace = kContentViewSpace;
    
    _textLabelSpace = kTextLabelSpace;
    _textLabelContentViewEdge = kContentViewEdge;
    
    _buttonHeight = KButtonHeight;
    _buttonSpace = kButtonSpace;
    _buttonContentViewEdge = kButtonViewEdge;
    _buttonContentViewTop = kContentViewSpace;
    _buttonCornerRadius = 4.0;
    _buttonFont = [UIFont boldSystemFontOfSize:14.0f];
    _buttonDefaultBgColor = [UIColor whiteColor];
    _buttonCancelBgColor = [UIColor whiteColor];
    _buttonDestructiveBgColor = [UIColor whiteColor];
    
    _textFieldHeight = kTextFieldHeight;
    _textFieldEdge = kTextFieldEdge;
    _textFieldBorderWidth = KTextFieldBorderWidth;
    _textFieldContentViewEdge = kContentViewEdge;
    
    _textFieldBorderColor = kBorderColor;
    _textFieldBackgroudColor = [UIColor whiteColor];
    _textFieldFont = [UIFont systemFontOfSize:14];
    
    _buttons = [NSMutableArray array];
    _actions = [NSMutableArray array];
}

- (UIColor *)buttonBgColorWithStyle:(TYAlertActionStyle)style
{
    switch (style) {
        case TYAlertActionStyleDefault:
            return _buttonDefaultBgColor;
        case TYAlertActionStyleCancel:
            return _buttonCancelBgColor;
        case TYAlertActionStyleDestructive:
            return _buttonDestructiveBgColor;
            
        default:
            return nil;
    }
}

#pragma mark - add contentview

- (void)addContentViews
{
    UIView *textContentView = [[UIView alloc]init];
    [self addSubview:textContentView];
    _textContentView = textContentView;
    
    UIView *textFieldContentView = [[UIView alloc]init];
    [self addSubview:textFieldContentView];
    _textFieldContentView = textFieldContentView;
    
    UIView *buttonContentView = [[UIView alloc]init];
    buttonContentView.userInteractionEnabled = YES;
    [self addSubview:buttonContentView];
    _buttonContentView = buttonContentView;
}

- (void)addTextLabels
{
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont boldSystemFontOfSize:14.0f];
    titleLabel.textColor = kActionSheetTextColor;
    [_textContentView addSubview:titleLabel];
    _titleLable = titleLabel;
    
    UILabel *messageLabel = [[UILabel alloc]init];
    messageLabel.numberOfLines = 0;
    //messageLabel.textAlignment = NSTextAlignmentCenter;
    messageLabel.font = [UIFont systemFontOfSize:14.0f];
    messageLabel.textColor = kActionSheetTextColor;
    
    [_textContentView addSubview:messageLabel];
    _messageLabel = messageLabel;
}

- (void)didMoveToSuperview
{
    if (self.superview) {
        [self layoutContentViews];
        [self layoutTextLabels];
    }
}

- (void)addAction:(PSTAlertAction *)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.clipsToBounds = YES;
    button.layer.cornerRadius = _buttonCornerRadius;
    [button setTitle:action.title forState:UIControlStateNormal];
    button.titleLabel.font = action.font ?: _buttonFont;
    [button setTitleColor: action.textColor ?: kActionSheetTextColor forState:UIControlStateNormal];
    [button setTitleColor:kActionDisableColor forState:UIControlStateDisabled];
    button.backgroundColor = [self buttonBgColorWithStyle:(TYAlertActionStyle)action.style];
    button.enabled = action.enabled;
    button.tag = kButtonTagOffset + _buttons.count;
    button.translatesAutoresizingMaskIntoConstraints = NO;
    [button addTarget:self action:@selector(actionButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    if (action.style == PSTAlertActionStyleCancel && self.preferredStyle == TYAlertControllerStyleActionSheet) {
        [button addViewBackedTopBorderWithHeight:1.0f andColor:kBorderColor];
    }
    switch (action.style) {
        case PSTAlertActionStyleCancel:
            [button setTitleColor:[UIColor colorWithWhite:0x9B/255.0 alpha:1.0f] forState:UIControlStateNormal];
            break;
        case PSTAlertActionStyleDestructive:
            [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            break;
        default:
            break;
    }
    [_buttonContentView addSubview:button];
    [_buttons addObject:button];
    [_actions addObject:action];
    
    if (_buttons.count == 1) {
        [self layoutContentViews];
        [self layoutTextLabels];
    }
    
    [self layoutButtons];
}

- (void)addTextFieldWithConfigurationHandler:(void (^)(UITextField *textField))configurationHandler
{
    if (_textFields == nil) {
        _textFields = [NSMutableArray array];
    }
    
    UITextField *textField = [[UITextField alloc]init];
    textField.tag = kTextFieldOffset + _textFields.count;
    textField.font = _textFieldFont;
    textField.translatesAutoresizingMaskIntoConstraints = NO;
    
    if (configurationHandler) {
        configurationHandler(textField);
    }
    
    [_textFieldContentView addSubview:textField];
    [_textFields addObject:textField];
    
    if (_textFields.count > 1) {
        if (_textFieldSeparateViews == nil) {
            _textFieldSeparateViews = [NSMutableArray array];
        }
        UIView *separateView = [[UIView alloc]init];
        separateView.backgroundColor = _textFieldBorderColor;
        separateView.translatesAutoresizingMaskIntoConstraints = NO;
        [_textFieldContentView addSubview:separateView];
        [_textFieldSeparateViews addObject:separateView];
    }
    
    [self layoutTextFields];
}

- (NSArray *)textFieldArray
{
    return _textFields;
}

#pragma mark - layout contenview

- (void)layoutSubviews
{
    [super layoutSubviews];
    if (TYAlertControllerStyleAlert == self.preferredStyle) {
        UIBezierPath * path = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(8, 8)];
        CAShapeLayer * layer = [[CAShapeLayer alloc]init];
        layer.frame = self.bounds;
        layer.path = path.CGPath;
        self.layer.mask = layer;
    }
}

- (void)layoutContentViews
{
    if (!_textContentView.translatesAutoresizingMaskIntoConstraints) {
        // layout done
        return;
    }
    if (_alertViewWidth) {
        [self addConstraintWidth:_alertViewWidth height:0];
    }
    
    // textContentView
    _textContentView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addConstraintWithView:_textContentView topView:self leftView:self bottomView:nil rightView:self edgeInset:UIEdgeInsetsMake( !self.title && !self.message && self.preferredStyle == TYAlertControllerStyleActionSheet? 0 : kContentViewTopSpace, _textLabelContentViewEdge, 0, -_textLabelContentViewEdge)];
    
    // textFieldContentView
    _textFieldContentView.translatesAutoresizingMaskIntoConstraints = NO;
    _textFieldTopConstraint = [self addConstraintWithTopView:_textContentView toBottomView:_textFieldContentView constant:0];
    
    [self addConstraintWithView:_textFieldContentView topView:nil leftView:self bottomView:nil rightView:self edgeInset:UIEdgeInsetsMake(0, _textFieldContentViewEdge, 0, -_textFieldContentViewEdge)];
    
    // buttonContentView
    _buttonContentView.translatesAutoresizingMaskIntoConstraints = NO;
    if (self.preferredStyle == TYAlertControllerStyleAlert) {
        [_buttonContentView addViewBackedTopBorderWithHeight:1.0f andColor:kBorderColor];
        for (NSUInteger i = 0; i < self.buttons.count; i++) {
            UIButton *button = [self.buttons objectAtIndex:i];
            if (i % 2 == 0) {
                [button addViewBackedRightBorderWithWidth:1.0f andColor:kBorderColor];
            }
            else{
                [button addViewBackedLeftBorderWithWidth:1.0f andColor:kBorderColor];
            }
        }
        
    }
    _buttonTopConstraint = [self addConstraintWithTopView:_textFieldContentView toBottomView:_buttonContentView constant: !self.title && !self.message? 0 : _buttonContentViewTop];
    
    [self addConstraintWithView:_buttonContentView topView:nil leftView:self bottomView:self rightView:self edgeInset:UIEdgeInsetsMake(0, _buttonContentViewEdge, 0, -_buttonContentViewEdge)];
}

- (void)layoutTextLabels
{
    if (!_titleLable.translatesAutoresizingMaskIntoConstraints && !_messageLabel.translatesAutoresizingMaskIntoConstraints) {
        // layout done
        return;
    }
    // title
    _titleLable.translatesAutoresizingMaskIntoConstraints = NO;
    [_textContentView addConstraintWithView:_titleLable topView:_textContentView leftView:_textContentView bottomView:nil rightView:_textContentView edgeInset:UIEdgeInsetsZero];
    
    // message
    _messageLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [_textContentView addConstraintWithTopView:_titleLable toBottomView:_messageLabel constant:!self.message ? 0 :_textLabelSpace];
    [_textContentView addConstraintWithView:_messageLabel topView:nil leftView:_textContentView bottomView:_textContentView rightView:_textContentView edgeInset:UIEdgeInsetsZero];
}

- (void)layoutButtons
{
    if (self.preferredStyle == TYAlertControllerStyleActionSheet) {
        [_buttons mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.equalTo(self.buttonContentView);
            make.height.mas_equalTo(KButtonHeight);
        }];
        UIButton *button = _buttons.firstObject;

        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.buttonContentView);
        }];
        for (NSUInteger i = 1; i < _buttons.count; i++) {
            UIButton *nextButton = _buttons[i];
            [self.buttonContentView addConstraintWithTopView:button toBottomView:nextButton constant:_buttonSpace];
            button = nextButton;
        }
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.buttonContentView);
        }];
        return;
    }
    UIButton *button = _buttons.lastObject;
    if (_buttons.count == 1) {
        _buttonTopConstraint.constant = -_buttonContentViewTop;
        [_buttonContentView addConstraintToView:button edgeInset:UIEdgeInsetsMake(kButtonsTopSpace, 0, 0, 0)];
        [button addConstraintWidth:0 height:_buttonHeight];
    }else if (_buttons.count == 2) {
        UIButton *firstButton = _buttons.firstObject;
        [_buttonContentView removeConstraintWithView:firstButton attribute:NSLayoutAttributeRight];
        [_buttonContentView addConstraintWithView:button topView:_buttonContentView leftView:nil bottomView:nil rightView:_buttonContentView edgeInset:UIEdgeInsetsMake(kButtonsTopSpace, 0, 0, 0)];
        [_buttonContentView addConstraintWithLeftView:firstButton toRightView:button constant:_buttonSpace];
        [_buttonContentView addConstraintEqualWithView:button widthToView:firstButton heightToView:firstButton];
        [_buttonContentView removeConstraintWithView:firstButton attribute:NSLayoutAttributeTop];
        NSArray<__kindof NSLayoutConstraint *> *constraints = [NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"V:|-%f-[firstButton]",kButtonsTopSpace] options:0 metrics:nil views:NSDictionaryOfVariableBindings(firstButton)];
        
        [_buttonContentView addConstraints:constraints];
    }else {
        if (_buttons.count == 3) {
            UIButton *firstBtn = _buttons[0];
            UIButton *secondBtn = _buttons[1];
            [_buttonContentView removeConstraintWithView:firstBtn attribute:NSLayoutAttributeRight];
            [_buttonContentView removeConstraintWithView:firstBtn attribute:NSLayoutAttributeBottom];
            [_buttonContentView removeConstraintWithView:secondBtn attribute:NSLayoutAttributeTop];
            [_buttonContentView addConstraintWithView:firstBtn topView:nil leftView:nil bottomView:nil rightView:_buttonContentView edgeInset:UIEdgeInsetsMake(kButtonsTopSpace, 0, 0, 0)];
            [_buttonContentView addConstraintWithTopView:firstBtn toBottomView:secondBtn constant:_buttonSpace];
            
        }
        
        UIButton *lastSecondBtn = _buttons[_buttons.count - 2];
        [_buttonContentView removeConstraintWithView:lastSecondBtn attribute:NSLayoutAttributeBottom];
        [_buttonContentView addConstraintWithTopView:lastSecondBtn toBottomView:button constant:_buttonSpace];
        [_buttonContentView addConstraintWithView:button topView:nil leftView:_buttonContentView bottomView:_buttonContentView rightView:_buttonContentView edgeInset:UIEdgeInsetsZero];
        [_buttonContentView addConstraintEqualWithView:button widthToView:nil heightToView:lastSecondBtn];
    }
}

- (void)layoutTextFields
{
    UITextField *textField = _textFields.lastObject;
    if (_textFields.count == 0){
        _textFieldTopConstraint.constant = 0;
    }
    if (_textFields.count == 1) {
        // setup textFieldContentView
        _textFieldContentView.backgroundColor = _textFieldBackgroudColor;
        _textFieldContentView.layer.masksToBounds = YES;
        _textFieldContentView.layer.cornerRadius = 4;
        _textFieldContentView.layer.borderWidth = _textFieldBorderWidth;
        _textFieldContentView.layer.borderColor = _textFieldBorderColor.CGColor;
        _textFieldTopConstraint.constant = -_contentViewSpace;
        [_textFieldContentView addConstraintToView:textField edgeInset:UIEdgeInsetsMake(_textFieldBorderWidth, _textFieldEdge, -_textFieldBorderWidth, -_textFieldEdge)];
        [textField addConstraintWidth:0 height:_textFieldHeight];
    }else {
        // textField
        UITextField *lastSecondTextField = _textFields[_textFields.count - 2];
        [_textFieldContentView removeConstraintWithView:lastSecondTextField attribute:NSLayoutAttributeBottom];
        [_textFieldContentView addConstraintWithTopView:lastSecondTextField toBottomView:textField constant:_textFieldBorderWidth];
        [_textFieldContentView addConstraintWithView:textField topView:nil leftView:_textFieldContentView bottomView:_textFieldContentView rightView:_textFieldContentView edgeInset:UIEdgeInsetsMake(0, _textFieldEdge, -_textFieldBorderWidth, -_textFieldEdge)];
        [_textFieldContentView addConstraintEqualWithView:textField widthToView:nil heightToView:lastSecondTextField];
        
        // separateview
        UIView *separateView = _textFieldSeparateViews[_textFields.count - 2];
        [_textFieldContentView addConstraintWithView:separateView topView:nil leftView:_textFieldContentView bottomView:nil rightView:_textFieldContentView edgeInset:UIEdgeInsetsZero];
        [_textFieldContentView addConstraintWithTopView:separateView toBottomView:textField constant:0];
        [separateView addConstraintWidth:0 height:_textFieldBorderWidth];
    }
}

#pragma mark - action

- (void)actionButtonClicked:(UIButton *)button
{
    PSTAlertAction *action = _actions[button.tag - kButtonTagOffset];
    
    if (_clickedAutoHide) {
        [self hideView];
    }
    
    if (action.handler) {
        action.handler(action);
    }
}

//- (void)dealloc
//{
//    NSLog(@"%@ dealloc",NSStringFromClass([self class]));
//}

@end
