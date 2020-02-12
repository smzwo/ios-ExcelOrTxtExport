//
//  dataToSave.h
//  ios-ExcelOrTxtExport
//
//  Created by 孙明喆 on 2020/2/12.
//  Copyright © 2020 孙明喆. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface dataToSave : NSObject


+ (NSString *)saveToExcel:(NSArray *)firstArg, ... NS_REQUIRES_NIL_TERMINATION;

+ (NSString *)saveToTxt:(NSArray *)firstArg, ... NS_REQUIRES_NIL_TERMINATION;


@end

// 函数解释
/**
 *  第一行的标题数据
 *  参数1:数据要写入的表格
 *  参数2:写入到哪一行（免费版SDK会有官方数据填充第一行，因此不能写到第一行数据）
 *  参数3:写入到哪一列
 *  参数4:要写入的具体内容,注意是C字符串
 *  参数5:数据要转换的格式,类型是FormatHandle,不清楚怎么定义的话可以直接写0,使用默认的
*/
//    xlSheetWriteStr(sheet, 1, 0, "姓名", 0);
//    xlSheetWriteStr(sheet, 1, 1, "性别", 0);
//    xlSheetWriteStr(sheet, 1, 2, "年龄", 0);
//    xlSheetWriteStr(sheet, 1, 3, "城市", 0);
//    xlSheetWriteStr(sheet, 1, 4, "电话", 0);
