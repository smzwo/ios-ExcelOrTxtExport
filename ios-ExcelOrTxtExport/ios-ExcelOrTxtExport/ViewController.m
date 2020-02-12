//
//  ViewController.m
//  ios-ExcelOrTxtExport
//
//  Created by 孙明喆 on 2020/2/12.
//  Copyright © 2020 孙明喆. All rights reserved.
//

#import "ViewController.h"
#import "dataToSave.h"
// 由于LibXL文件太大，没有放入，因此需要自己下载后导入工程即可
#import <LibXL/LibXL.h>

@interface ViewController () <UIDocumentInteractionControllerDelegate>

@property (nonatomic, strong) NSArray *nameArray;
@property (nonatomic, strong) NSArray *sexArray;
@property (nonatomic, strong) NSArray *ageArray;
@property (nonatomic, strong) NSArray *cityArray;
@property (nonatomic, strong) NSArray *schoolArray;
@property (nonatomic, strong) NSArray *phoneArray;
@property (nonatomic, strong) UIDocumentInteractionController *documentIc;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.nameArray = @[@"张三", @"李四", @"王五", @"赵六", @"孙七"];
    self.sexArray = @[@"男", @"女", @"男", @"女", @"男"];
    self.ageArray = @[@"19", @"18", @"20", @"20", @"19"];
    self.cityArray = @[@"北京", @"北京", @"北京", @"深dq圳", @"杭sdq州"];
    self.phoneArray = @[@"21.351231245", @"\n", @"0.9934174", @"1351351.124125", @"13777777777"];

    
    UIButton *exportBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    exportBtn.frame = CGRectMake(100, 100, 200, 30);
    [exportBtn setTitle:@"导出excel表格数据" forState: UIControlStateNormal];
    [exportBtn setTitleColor:[UIColor brownColor] forState:UIControlStateNormal];
    [exportBtn addTarget:self action:@selector(exportBtnDidClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:exportBtn];
}

- (void)exportBtnDidClick {
    NSString* filePath = [ExcelDataSave save:self.nameArray, self.sexArray, self.ageArray, self.cityArray, self.phoneArray, nil];
//    NSString *filePath = [dataToSave saveToTxt:self.nameArray, self.sexArray, self.ageArray, self.cityArray, self.phoneArray, nil];

    // 调用safari分享功能将文件分享出去
    UIDocumentInteractionController *documentIc = [UIDocumentInteractionController interactionControllerWithURL:[NSURL fileURLWithPath:filePath]];

    // 记得要强引用UIDocumentInteractionController,否则控制器释放后再次点击分享程序会崩溃
    self.documentIc = documentIc;

    // 如果需要其他safari分享的更多交互,可以设置代理
    documentIc.delegate = self;

    // 设置分享显示的矩形框
    CGRect rect = CGRectMake(0, 0, 300, 300);
    [documentIc presentOpenInMenuFromRect:rect inView:self.view animated:YES];
    [documentIc presentPreviewAnimated:YES];
}


@end
