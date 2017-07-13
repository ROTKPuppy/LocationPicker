//
//  ZJLocationPickerViewController.m
//  LocationPicker
//
//  Created by 郑键 on 2017/7/11.
//  Copyright © 2017年 inborn. All rights reserved.
//

#import "ZJLocationPickerViewController.h"
#import "ZJAddressTableViewCell.h"
#import "ZJAddressModel.h"
#import "UIView+Extension.h"
#import <Masonry/Masonry.h>

@interface ZJLocationPickerViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic,strong) NSArray * totleDataSouce;
@property (nonatomic,strong) NSArray * dataSouce;
@property (nonatomic,strong) NSArray * cityDataSouce;
@property (nonatomic,strong) NSArray * districtDataSouce;
@property (nonatomic,strong) NSArray * tableViews;
@property (nonatomic,strong) UIScrollView * locationContentView;
@property (nonatomic,strong) UIView * bgView;
@property (nonatomic,strong) UIScrollView * selectedContentView;
@property (nonatomic,strong) UIButton * seletedBtn;
@property (nonatomic,strong) UIView * btnIndicator;
@property (nonatomic,strong) NSArray * titleViewsArray;
@property (nonatomic,strong) NSString * titleText;
@property (nonatomic,strong) UIImage *closeImage;
@property (nonatomic,strong) UIColor *marginLineBackgroundColor;
@property (nonatomic,strong) UIColor *selectedTintColor;
@property (nonatomic,strong) UIImage *selectedImage;
@property (nonatomic,copy) SelectedCallBack selectedCallBack;
@end

@implementation ZJLocationPickerViewController

+ (instancetype)locationPickerViewController:(NSString *)title
                                  closeImage:(UIImage *)closeImage
                   marginLineBackgroundColor:(UIColor *)marginLineBackgroundColor
                           selectedTintColor:(UIColor *)selectedTintColor
                               selectedImage:(UIImage *)selectedImage
                            selectedCallBack:(SelectedCallBack)selectedCallBack
{
    ZJLocationPickerViewController *pickerController    = [[ZJLocationPickerViewController alloc] init];
    pickerController.titleText                          = title ? title : @"所在地区";
    pickerController.closeImage                         = closeImage ? closeImage : [self loadImage:@"public_off_n"];
    pickerController.marginLineBackgroundColor          = marginLineBackgroundColor ? marginLineBackgroundColor : [UIColor lightGrayColor];
    pickerController.selectedTintColor                  = selectedTintColor ? selectedTintColor : [UIColor redColor];
    pickerController.selectedImage                      = selectedImage ? selectedImage : [self loadImage:@"screen_selected_icon"];
    pickerController.selectedCallBack                   = selectedCallBack;
    return pickerController;
}

+ (UIImage *)loadImage:(NSString *)imageNamed
{
    NSString *imagePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:[NSString stringWithFormat:@"Image.bundle/%@", imageNamed]];
    return [UIImage imageWithContentsOfFile:imagePath];
}

- (void)setTotleDataSouce:(NSArray *)totleDataSouce
{
    _totleDataSouce = totleDataSouce;
    
    /**
     *  筛选出省及直辖市数据
     */
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"level == 1"];
    self.dataSouce = [totleDataSouce filteredArrayUsingPredicate: pre];
}

- (void)btnClick:(UIButton *)sender
{
    
    /**
     *  按钮状态
     */
    self.seletedBtn.selected = NO;
    sender.selected = YES;
    self.seletedBtn = sender;
    
    /**
     *  控制器view的滚动
     */
    CGPoint offset = self.locationContentView.contentOffset;
    offset.x = sender.tag * self.view.ex_width;
    [self.locationContentView setContentOffset:offset animated:YES];
    
}

- (void)closeButtonClick:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

/**
 读取json数据
 */
- (void)loadData
{
    NSString *jsonPath = [[NSBundle mainBundle] pathForResource:@"Cities" ofType:@"json"];
    NSData *data=[NSData dataWithContentsOfFile:jsonPath];
    NSError *error;
    NSArray * jsonObjectArray =[NSJSONSerialization JSONObjectWithData:data
                                                               options:kNilOptions
                                                                 error:&error];
    NSMutableArray *tempArray = [NSMutableArray array];
    for (NSDictionary * dict in jsonObjectArray) {
        ZJAddressModel * model = [[ZJAddressModel alloc] initWithDict:dict];
        [tempArray addObject:model];
    }
    self.totleDataSouce = tempArray;
}

/**
 配置视图界面
 */
- (void)setupUI
{
    self.view.backgroundColor = [UIColor clearColor];
    
    UILabel *titleLabel = [UILabel new];
    titleLabel.text = self.titleText;
    
    UIButton *closeButton = [UIButton new];
    closeButton.backgroundColor = [UIColor whiteColor];
    [closeButton addTarget:self
                    action:@selector(closeButtonClick:)
          forControlEvents:UIControlEventTouchUpInside];
    [closeButton setImage:self.closeImage
                 forState:UIControlStateNormal];
    
    UIView *marginLineView = [UIView new];
    marginLineView.backgroundColor = self.marginLineBackgroundColor;
    
    [self.view addSubview:self.bgView];
    [self.bgView addSubview:titleLabel];
    [self.bgView addSubview:closeButton];
    [self.bgView addSubview:self.selectedContentView];
    [self.bgView addSubview:marginLineView];
    [self.bgView addSubview:self.locationContentView];
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view).mas_offset(20);
    }];
    
    [closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(titleLabel);
        make.right.mas_equalTo(self.view).mas_offset(-10);
        make.width.height.mas_equalTo(25);
    }];
    
    [self.selectedContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(titleLabel.mas_bottom).mas_offset(20);
        make.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(44);
    }];
    
    [marginLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(12);
        make.right.mas_equalTo(self.view).mas_offset(-12);
        make.top.mas_equalTo(self.selectedContentView.mas_bottom);
        make.height.mas_equalTo(0.5);
    }];
    
    [self.locationContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.bgView);
        make.top.mas_equalTo(marginLineView.mas_bottom);
    }];
    
    [self.view layoutIfNeeded];
}

- (void)addTableView
{
    NSMutableArray *tempArray = [NSMutableArray array];
    for (NSInteger i = 0; i < 3; i++) {
        UITableView * tableView = [[UITableView alloc] initWithFrame: CGRectZero];
        [self.locationContentView addSubview:tableView];
        [tempArray addObject:tableView];
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.contentInset = UIEdgeInsetsMake(0, 0, 44, 0);
        [tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ZJAddressTableViewCell class]) bundle:nil] forCellReuseIdentifier:ZJAddressTableViewCellReId];
        [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(self.view);
            make.top.height.mas_equalTo(self.locationContentView);
            
            if (i == 0) {
                make.left.mas_equalTo(self.locationContentView);
            }else{
                UITableView *tempTableView = tempArray[i - 1];
                make.left.mas_equalTo(tempTableView.mas_right);
            }
        }];
    }
    self.tableViews = tempArray.copy;
}

/**
 三级选中title
 */
- (void)addSelectedTitleLabel
{
    NSMutableArray *tempArray = [NSMutableArray array];
    for (NSInteger i = 0; i<3; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"请选择" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:13.f];
        [btn setTitleColor:self.selectedTintColor forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = i;
        [tempArray addObject:btn];
        [self.selectedContentView addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.selectedContentView);
            if (i == 0) {
                make.left.mas_equalTo(self.selectedContentView).mas_offset(12.f);
            }else{
                make.left.mas_equalTo(self.selectedContentView.subviews[self.selectedContentView.subviews.count - 2].mas_right).mas_offset(34.f);
            }
        }];
        
        [self.selectedContentView layoutSubviews];
        
        /**
         *  默认选中第一个按钮
         */
        btn.alpha = 0;
        if (btn.tag == 0) {
            btn.selected = YES;
            self.seletedBtn = (UIButton *)btn;
            [btn.titleLabel sizeToFit];
            
            self.btnIndicator.ex_centerX = btn.ex_centerX;
            self.btnIndicator.ex_y = CGRectGetMaxY(btn.frame) - 2;
            btn.alpha = 1;
        }
    }
    
    self.titleViewsArray = tempArray.copy;
    [self setupIndicator];
}

/**
 配置指示器
 */
- (void)setupIndicator
{
    [self.selectedContentView addSubview:self.btnIndicator];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
    [self setupUI];
    [self addSelectedTitleLabel];
    [self addTableView];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - Delegate

#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if([self.tableViews indexOfObject:tableView] == 0){
        return self.dataSouce.count;
    }else if ([self.tableViews indexOfObject:tableView] == 1){
        return self.cityDataSouce.count;
    }else if ([self.tableViews indexOfObject:tableView] == 2){
        return self.districtDataSouce.count;
    }
    return self.dataSouce.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZJAddressTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ZJAddressTableViewCellReId forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    ZJAddressModel * model;
    
    if([self.tableViews indexOfObject:tableView] == 0){
        model = self.dataSouce[indexPath.row];
    }else if ([self.tableViews indexOfObject:tableView] == 1){
        model = self.cityDataSouce[indexPath.row];
    }else if ([self.tableViews indexOfObject:tableView] == 2){
        model = self.districtDataSouce[indexPath.row];
    }
    cell.selectedImage = self.selectedImage;
    cell.selectedTintColor = self.selectedTintColor;
    cell.addressModel = model;
    return cell;
}

#pragma mark UITableViewDelegate

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([self.tableViews indexOfObject:tableView] == 0){
        
        /**
         *  获取下一级别的数据源(市级别,如果是直辖市时,下级则为区级别)
         */
        ZJAddressModel * provinceModel = self.dataSouce[indexPath.row];
        NSPredicate *pre = [NSPredicate predicateWithFormat:@"sheng == %@ AND level == 2", [provinceModel.code substringWithRange:(NSRange){0,2}]];
        self.cityDataSouce = [self.totleDataSouce filteredArrayUsingPredicate: pre];
        
        /**
         *  判断是否是第一次选择,不是,则重新选择省,切换省.
         */
        NSIndexPath * indexPath0 = [tableView indexPathForSelectedRow];
        
        [self setupSelected:indexPath0
                  indexPath:indexPath
                      model:provinceModel
                 dataSource:self.cityDataSouce];
        
    }else if ([self.tableViews indexOfObject:tableView] == 1){
        
        ZJAddressModel * cityModel = self.cityDataSouce[indexPath.row];
        NSPredicate *pre = [NSPredicate predicateWithFormat:@"level = 3 AND sheng = %@ AND di = %@", cityModel.sheng, cityModel.di];
        self.districtDataSouce = [self.totleDataSouce filteredArrayUsingPredicate: pre];
        
        NSIndexPath * indexPath0 = [tableView indexPathForSelectedRow];
        
        [self setupSelected:indexPath0
                  indexPath:indexPath
                      model:cityModel
                 dataSource:self.districtDataSouce];
        
        
    }else if ([self.tableViews indexOfObject:tableView] == 2){
        
        ZJAddressModel * districtModel = self.districtDataSouce[indexPath.row];
        UIButton *titleButton = self.titleViewsArray.lastObject;
        [titleButton setTitle:districtModel.name forState:UIControlStateNormal];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            /**
             *  选中完成回调
             */
            if (self.selectedCallBack) {
                self.selectedCallBack([self setUpAddress]);
                [self dismissViewControllerAnimated:YES completion:nil];
            }else{
                NSLog(@"没有实现block");
            }
        });
    }
    return indexPath;
}

/**
 配置选中的地址

 @return 选中的地址
 */
- (NSString *)setUpAddress
{
    NSMutableString * addressStr = [[NSMutableString alloc] init];
    for (UIButton * btn  in self.titleViewsArray) {
        if ([btn.currentTitle isEqualToString:@"县"] || [btn.currentTitle isEqualToString:@"市辖区"] ) {
            continue;
        }
        [addressStr appendString:btn.currentTitle];
        [addressStr appendString:@" "];
    }
    return addressStr;
}

/**
 选中后配置界面
 */
- (void)setupSelected:(NSIndexPath *)selectedIndexPath
            indexPath:(NSIndexPath *)indexPath
                model:(ZJAddressModel *)model
           dataSource:(NSArray *)dataSource
{
    NSInteger index = self.locationContentView.contentOffset.x / self.view.ex_width;
    index += 1;
    
    if ([selectedIndexPath compare:indexPath] == NSOrderedSame && selectedIndexPath) {
        [self.locationContentView setContentOffset:CGPointMake(self.view.ex_width * index, 0) animated:YES];
        
    }else{
        
        [dataSource enumerateObjectsUsingBlock:^(ZJAddressModel *  _Nonnull obj,
                                                 NSUInteger idx,
                                                 BOOL * _Nonnull stop) {
            if (obj.isSelected) {
                obj.isSelected = NO;
                *stop = YES;
            }
        }];
        
        self.locationContentView.contentSize = CGSizeMake(self.view.ex_width * (index + 1), 0);
        
        UITableView *tempTableView = self.tableViews[index];
        [tempTableView reloadData];
        [self.locationContentView setContentOffset:CGPointMake(self.view.ex_width * index, 0) animated:YES];
        
        /**
         *  赋值当前的btn
         *  隐藏后面的btn 并重新修改title为 请选择
         */
        [self.titleViewsArray enumerateObjectsUsingBlock:^(UIButton *  _Nonnull obj,
                                                           NSUInteger idx,
                                                           BOOL * _Nonnull stop) {
            if (index >= idx) {
                obj.alpha = 1;
                if ((index - 1) == idx) {
                    [obj setTitle:model.name forState:UIControlStateNormal];
                }
                if (index == idx) {
                    [obj setTitle:@"请选择" forState:UIControlStateNormal];
                }
                
            }else{
                obj.alpha = 0;
                [obj setTitle:@"请选择" forState:UIControlStateNormal];
            }
        }];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZJAddressModel * model;
    if([self.tableViews indexOfObject:tableView] == 0){
        model = self.dataSouce[indexPath.row];
    }else if ([self.tableViews indexOfObject:tableView] == 1){
        model = self.cityDataSouce[indexPath.row];
    }else if ([self.tableViews indexOfObject:tableView] == 2){
        model = self.districtDataSouce[indexPath.row];
    }
    model.isSelected = YES;
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    [tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZJAddressModel * model;
    if([self.tableViews indexOfObject:tableView] == 0){
        model = self.dataSouce[indexPath.row];
    }else if ([self.tableViews indexOfObject:tableView] == 1){
        model = self.cityDataSouce[indexPath.row];
    }else if ([self.tableViews indexOfObject:tableView] == 2){
        model = self.districtDataSouce[indexPath.row];
    }
    model.isSelected = NO;
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma  mark <UIScrollViewDelegate>

/**
 *  滚动监听
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if ([scrollView isKindOfClass:[UITableView class]]) {
        return;
    }
    
    /**
     *  让我们的标签进行颜色值的变化及缩放
     */
    float value = scrollView.contentOffset.x / scrollView.bounds.size.width;
    
    /**
     *  左边的索引
     */
    int leftIndex = scrollView.contentOffset.x / scrollView.bounds.size.width;
    
    /**
     *  右边的索引=左边的索引 + 1;
     */
    int rightIndex = leftIndex + 1;
    
    UIButton *leftButton = self.selectedContentView.subviews[leftIndex];
    UIButton *rightButton = self.selectedContentView.subviews[rightIndex];
    
    /**
     *  右边的比率
     */
    CGFloat rightScale = value - leftIndex;
    
    /**
     *  左边的比率
     */
    CGFloat leftScale = 1- rightScale;
    
    if (rightScale > leftScale) {
        
        /**
         *  修改按钮状态
         */
        self.seletedBtn.selected = NO;
        rightButton.selected = YES;
        self.seletedBtn = rightButton;
        
        if (self.selectedContentView.contentSize.width >= [UIScreen mainScreen].bounds.size.width) {
            [self scrollTitlesViewWithSelectedButton:rightButton];
        }
    }else{
        // 修改按钮状态
        self.seletedBtn.selected = NO;
        leftButton.selected = YES;
        self.seletedBtn = leftButton;
        
        if (self.selectedContentView.contentSize.width >= [UIScreen mainScreen].bounds.size.width) {
            [self scrollTitlesViewWithSelectedButton:leftButton];
        }
        
        // 动画
        [UIView animateWithDuration:0.25 animations:^{
            
            self.btnIndicator.ex_centerX = leftButton.ex_centerX;
        }];
    }
}

- (void)scrollTitlesViewWithSelectedButton:(UIButton *)sender
{
    /**
     *  计算channelScrollView应该滚动的偏移量
     */
    CGFloat needScrollOffsetX = sender.center.x - self.selectedContentView.bounds.size.width * 0.5;
    
    if (needScrollOffsetX < 0) {
        needScrollOffsetX = 0;
    }
    
    CGFloat maxScrollOffsetX = self.selectedContentView.contentSize.width - self.selectedContentView.bounds.size.width ;
    
    if (needScrollOffsetX > maxScrollOffsetX) {
        needScrollOffsetX = maxScrollOffsetX;
    }
    
    [self.selectedContentView setContentOffset:CGPointMake(needScrollOffsetX, 0) animated:YES];
}

#pragma mark - Lazy

- (UIScrollView *)selectedContentView
{
    if (!_selectedContentView) {
        
        _selectedContentView = [UIScrollView new];
        _selectedContentView.backgroundColor = [UIColor whiteColor];
        
    }
    return _selectedContentView;
}

- (UIView *)bgView
{
    if (!_bgView) {
        
        _bgView = [UIView new];
        _bgView.backgroundColor = [UIColor whiteColor];
        UIBezierPath *fieldPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(5 , 5)];
        CAShapeLayer *fieldLayer = [[CAShapeLayer alloc] init];
        fieldLayer.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
        fieldLayer.path = fieldPath.CGPath;
        _bgView.layer.mask = fieldLayer;
    }
    return _bgView;
}

- (UIView *)btnIndicator
{
    if (_btnIndicator == nil) {
        _btnIndicator = [[UIView alloc] init];
        _btnIndicator.backgroundColor = [UIColor blackColor];
        
        _btnIndicator.ex_height = 2;
        _btnIndicator.ex_width = 15;
    }
    return _btnIndicator;
}

- (UIScrollView *)locationContentView
{
    if (!_locationContentView) {
        
        _locationContentView = [UIScrollView new];
        _locationContentView.backgroundColor = [UIColor whiteColor];
        _locationContentView.delegate = self;
        _locationContentView.pagingEnabled = YES;
        _locationContentView.showsHorizontalScrollIndicator = NO;
        _locationContentView.showsVerticalScrollIndicator = NO;
        _locationContentView.bounces = NO;
        
    }
    return _locationContentView;
}

@end
