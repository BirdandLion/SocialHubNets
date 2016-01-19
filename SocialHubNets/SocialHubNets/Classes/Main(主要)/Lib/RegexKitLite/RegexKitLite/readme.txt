RegexKitLite使用方法

1. 导入库RegexKitLite使用方法
2. 导入依赖库:libicucore.lib
3. 添加-fno-objc-arc标识
4.开始使用:
		[str enumerateStringsMatchedByRegex:@"\\[[a-zA-Z0-9\\u4b10-\\u9903]+\\]" usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
            NSLog(@"%@ - %@", *capturedStrings, NSStringFromRange(*capturedRanges));
        }];
        
        NSArray *array = [str componentsSeparatedByRegex:@"\\[[a-zA-Z0-9\\u4b10-\\u9903]+\\]"];
        NSLog(@"%@", array);
