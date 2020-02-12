//
//  dataToSave.m
//  ios-ExcelOrTxtExport
//
//  Created by 孙明喆 on 2020/2/12.
//  Copyright © 2020 孙明喆. All rights reserved.
//

#import "dataToSave.h"
#import <LibXL/LibXL.h>


@implementation dataToSave

+ (NSString *)saveToExcel:(NSArray *)firstArg, ... NS_REQUIRES_NIL_TERMINATION{
    // 定义初始列
    int colFirst = 0;
    
    // 创建excel文件,表格的格式是xls,如果要创建xlsx表格,需要用xlCreateXMLBook()创建
    BookHandle book = xlCreateBook();
    
    // 创建sheet表格
    SheetHandle sheet = xlBookAddSheet(book, "Sheet1", NULL);
    
    // 创建
    xlSheetWriteStr(sheet, 1, 0, "姓名", 0);
    xlSheetWriteStr(sheet, 1, 1, "性别", 0);
    xlSheetWriteStr(sheet, 1, 2, "年龄", 0);
    xlSheetWriteStr(sheet, 1, 3, "城市", 0);
    xlSheetWriteStr(sheet, 1, 4, "电话", 0);
    
    if (firstArg) {
        // 取出第一个参数
        NSLog(@"%@", firstArg);
        // 定义一个指向个数可变的参数列表指针；
        va_list args;
        // 用于存放取出的参数
        NSArray *arg;
        // 初始化变量刚定义的va_list变量，这个宏的第二个参数是第一个可变参数的前一个参数，是一个固定的参数
        va_start(args, firstArg);
        // 从第二行开始写入数据,先把OC字符串转成C字符串
        for (int i = 0; i < firstArg.count; i++) {
            const char *data = [firstArg[i] cStringUsingEncoding:NSUTF8StringEncoding];
            xlSheetWriteStr(sheet, i + 2, colFirst, data, 0);
        }
        // 遍历全部参数 va_arg返回可变的参数(a_arg的第二个参数是你要返回的参数的类型)
        while ((arg = va_arg(args, NSArray *))) {
            colFirst++;
            for (int i = 0; i < arg.count; i++) {
                const char *data = [arg[i] cStringUsingEncoding:NSUTF8StringEncoding];
                xlSheetWriteStr(sheet, i + 2, colFirst, data, 0);
            }
        }
        // 清空参数列表，并置参数指针args无效
        va_end(args);
    }
    
    // 先写入沙盒
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)firstObject];
    
    NSString *fileName = [@"student" stringByAppendingString:@".xls"];
    NSString *filePath = [documentPath stringByAppendingPathComponent:fileName];
    
    // 保存表格
    xlBookSave(book, [filePath UTF8String]);
    
    // 最后要release表格
    xlBookRelease(book);
    
    return filePath;
}

+ (NSString *)saveToTxt:(NSArray *)firstArg, ... NS_REQUIRES_NIL_TERMINATION{
    
    // 1.得到Documents的路径
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    // 2.创建一个文件路径
    NSString *filePath = [docPath stringByAppendingPathComponent:@"qiuxiang.txt"];
    // 3.创建文件首先需要一个文件管理对象
    NSFileManager *fileManager = [NSFileManager defaultManager];
    // 4.创建文件
    [fileManager createFileAtPath:filePath contents:nil attributes:nil];

    if (firstArg) {
        va_list args;
        NSArray *arg;
        va_start(args, firstArg);

        NSString *data = [firstArg componentsJoinedByString:@" "];
        [data writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
        
        while ((arg = va_arg(args, NSArray *))) {
            // 打开文件准备更新
            NSFileHandle *fileHandle = [NSFileHandle fileHandleForUpdatingAtPath:filePath];
            // 移到文件末尾
            [fileHandle seekToEndOfFile];
            // 获取NSArray中的数据
            NSString *string = [arg componentsJoinedByString:@" "];
            // 为不同的数据添加换行符
            NSString *data = [NSString stringWithFormat:@"%@\n", string];
            // 转为data类型
            NSData* stringData  = [data dataUsingEncoding:NSUTF8StringEncoding];
            // 写入数据
            [fileHandle writeData:stringData];
            // 关闭文件
            [fileHandle closeFile];
        }
        va_end(args);
    }
    return filePath;
}

@end
