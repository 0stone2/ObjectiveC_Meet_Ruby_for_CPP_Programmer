//
//  ViewController.m
//  ObjCppWithScript
//
//  Created by 박 창진 on 2017. 1. 14..
//  Copyright © 2017년 박 창진. All rights reserved.
//

#import "ViewController.h"

#import <ruby/ruby.h>

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    NSString *Script = @"Ruby";

    [_Box_1 setTitle: [NSString stringWithFormat:@"1장 - Objective C에서 %@ 호출하기", Script]];
    [_Button_1 setTitle: [NSString stringWithFormat:@"예제 1 - %@ 스크립트\n 파일 실행하기", Script]];
    [_Button_2 setTitle: [NSString stringWithFormat:@"예제 2 - %@ 전역변수\n 조작하기", Script]];
    [_Button_3 setTitle: [NSString stringWithFormat:@"예제 3 - %@ 함수\n 호출하기", Script]];
    
    [_Box_2 setTitle: [NSString stringWithFormat:@"2장 - %@에서 Objective C 호출하기", Script]];
    [_Button_4 setTitle: [NSString stringWithFormat:@"예제 4 - %@에서 호출\n 가능한 Objective C 함수\n 만들기", Script]];
    [_Button_5 setTitle: [NSString stringWithFormat:@"예제 5 - %@에서 호출\n 가능한 Objective C 함수\n 만들기", Script]];
    [_Button_6 setTitle: [NSString stringWithFormat:@"예제 6 - %@에서 호출\n 가능한 Objective C 함수\n 만들기", Script]];
    
    [_Box_3 setTitle: [NSString stringWithFormat:@"3장 - %@ 확장 모듈 만들기", Script]];
    [_Button_7 setTitle: [NSString stringWithFormat:@"예제 7 - MyDbgString 함수를\n 동적 라이브러리로 구현하기"]];
    [_Button_8 setTitle: [NSString stringWithFormat:@"예제 8 - 동적 라이브러리를 %@에서\n 직접 호출할수 있도록 만들기", Script]];
    
}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

- (IBAction)Button_Exit_Click:(id)sender {
    [NSApp terminate:self];
}

BOOL InitRuby()
{
    static BOOL	bSuccess = FALSE;
    
    int		argc = 0;
    char *	argv[] =  {NULL, };
    VALUE	variable_in_this_stack_frame;
    
    @try {
        if (TRUE == bSuccess) return bSuccess;
        
        ruby_sysinit(&argc, (char ***)&argv);
        ruby_init_stack(&variable_in_this_stack_frame);
        ruby_init();
        ruby_init_loadpath();
        
        bSuccess = TRUE;
    }
    @catch (NSException *exception)  {
        NSLog( @"NSException caught" );
        NSLog( @"Name: %@", exception.name);
        NSLog( @"Reason: %@", exception.reason );
    }
    @finally {
        if (FALSE == bSuccess)
        {
            ruby_cleanup(0);
        }
    }
    
    return bSuccess;
}

- (IBAction)Button_1_Click:(id)sender {
    BOOL    bSuccess = FALSE;
    VALUE   VScriptFile = (VALUE)NULL;
    NSString *ScriptFile = [SCRIPT_PATH stringByAppendingPathComponent:@"Sample01.rb"];
    const char *szScriptFile = [ScriptFile UTF8String];
    
    NSLog(@"Enter %@", NSStringFromSelector(_cmd));
    
    @try {
        bSuccess = InitRuby();
        if (FALSE == bSuccess)
            [NSException raise:@"InitRuby" format:@"InitRuby = FALSE"];
        
        VScriptFile = rb_str_new_cstr(szScriptFile);
        if((VALUE)NULL == VScriptFile)
            [NSException raise:@"rb_str_new_cstr" format:@"rb_str_new_cstr = NULL"];
        
        rb_load(VScriptFile, 0);
    }
    @catch (NSException *exception)  {
        NSLog( @"NSException caught" );
        NSLog( @"Name: %@", exception.name);
        NSLog( @"Reason: %@", exception.reason );
    }
    @finally {
        if (FALSE == bSuccess)
        {
            ruby_cleanup(0);
        }
    }
    
    NSLog(@"Leave %@", NSStringFromSelector(_cmd));
}
- (IBAction)Button_2_Click:(id)sender {
    BOOL    bSuccess = FALSE;
    VALUE   VScriptFile = (VALUE)NULL;
    NSString *ScriptFile = [SCRIPT_PATH stringByAppendingPathComponent:@"Sample02.rb"];
    const char *szScriptFile = [ScriptFile UTF8String];
    
    VALUE	WelcomMessage = (VALUE)NULL;
    char *	szWelcomMessage = NULL;
    
    VALUE	WhoamI = (VALUE)NULL;
    char *	szWhoamI = NULL;
    
    VALUE	Version = (VALUE)NULL;
    int		nVersion = NULL;
    
    NSLog(@"Enter %@", NSStringFromSelector(_cmd));
    
    @try {
        bSuccess = InitRuby();
        if (FALSE == bSuccess)
            [NSException raise:@"InitRuby" format:@"InitRuby = FALSE"];
        
        VScriptFile = rb_str_new_cstr(szScriptFile);
        if((VALUE)NULL == VScriptFile)
            [NSException raise:@"rb_str_new_cstr" format:@"rb_str_new_cstr = NULL"];
    
        rb_load(VScriptFile, 0);
    
        WelcomMessage = rb_gv_get("szWelcomMessage");
        szWelcomMessage = rb_string_value_ptr(&WelcomMessage);
    
        WhoamI = rb_gv_get("szWhoamI");
        szWhoamI = rb_string_value_ptr(&WhoamI);
    
        Version = rb_gv_get("nVersion");
        nVersion = rb_num2int(Version);
    
        NSLog(@"szWelcomMessage = %s\n", szWelcomMessage);
        NSLog(@"szWhoamI = %s\n", szWhoamI);
        NSLog(@"nVersion = %d\n", (int)nVersion);
    
    
        rb_gv_set("szWhoamI", rb_str_new_cstr("Objective C"));
        WhoamI = rb_gv_get("szWhoamI");
        szWhoamI = rb_string_value_ptr(&WhoamI);
    
        NSLog(@"szWhoamI = %s\n", szWhoamI);
    }
    @catch (NSException *exception)  {
        NSLog( @"NSException caught" );
        NSLog( @"Name: %@", exception.name);
        NSLog( @"Reason: %@", exception.reason );
    }
    @finally {
        if (FALSE == bSuccess)
        {
            ruby_cleanup(0);
        }
    }
    
    NSLog(@"Leave %@", NSStringFromSelector(_cmd));
}
- (IBAction)Button_3_Click:(id)sender {
    BOOL    bSuccess = FALSE;
    VALUE   VScriptFile = (VALUE)NULL;
    NSString *ScriptFile = [SCRIPT_PATH stringByAppendingPathComponent:@"Sample03.rb"];
    const char *szScriptFile = [ScriptFile UTF8String];
    
    ID		myfunc_0 = 0;
    ID		myfunc_1 = 0;
    ID		myfunc_2 = 0;
    ID		myfunc_3 = 0;
    ID		myfunc_4 = 0;
    ID		myfunc_5 = 0;
    
    VALUE	WelcomMessage = (VALUE)NULL;
    char *	szWelcomMessage = NULL;
    
    VALUE	WhoamI = (VALUE)NULL;
    char *	szWhoamI = NULL;
    
    VALUE	Version = (VALUE)NULL;
    int		nVersion = NULL;

    VALUE	ReturnValue = NULL;
    VALUE	RetString = NULL;
    
    NSLog(@"Enter %@", NSStringFromSelector(_cmd));
    
    @try {
        bSuccess = InitRuby();
        if (FALSE == bSuccess)
            [NSException raise:@"InitRuby" format:@"InitRuby = FALSE"];
        
        VScriptFile = rb_str_new_cstr(szScriptFile);
        if((VALUE)NULL == VScriptFile)
            [NSException raise:@"rb_str_new_cstr" format:@"rb_str_new_cstr = NULL"];
        rb_load(VScriptFile, 0);
    
        WelcomMessage = rb_gv_get("szWelcomMessage");
        szWelcomMessage = rb_string_value_ptr(&WelcomMessage);
    
        WhoamI = rb_gv_get("szWhoamI");
        szWhoamI = rb_string_value_ptr(&WhoamI);
    
    
        NSLog(@"szWelcomMessage = %s\n", szWelcomMessage);
        NSLog(@"szWhoamI = %s\n", szWhoamI);


        //////////////////////////////////////////////////////////////
        //
        // Call myfunc_0
        //
        
        NSLog(@"[myfunc_0]========================================");
        myfunc_0 = rb_intern("myfunc_0");
        ReturnValue = rb_funcall(0, myfunc_0, 0);
    
        WhoamI = rb_gv_get("szWhoamI");
        szWhoamI = rb_string_value_ptr(&WhoamI);
    
    
        NSLog(@"[myfunc_0]szWhoamI = %s\n", szWhoamI);

    
        //////////////////////////////////////////////////////////////
        //
        // Call myfunc_1
        //
        
        NSLog(@"[myfunc_1]========================================");

        myfunc_1 = rb_intern("myfunc_1");
        ReturnValue = rb_funcall(0, myfunc_1, 0);
    
        WhoamI = rb_gv_get("szWhoamI");
        szWhoamI = rb_string_value_ptr(&WhoamI);
    
    
        if (RUBY_Qnil == ReturnValue)
        {
            NSLog(@"[myfunc_1]ReturnValue = NIL");
        }
    
        NSLog(@"[myfunc_1]szWhoamI = %s", szWhoamI);
    
    
    
        //////////////////////////////////////////////////////////////
        //
        // Call myfunc_2
        //
        
        NSLog(@"[myfunc_2]========================================");
        myfunc_2 = rb_intern("myfunc_2");
        ReturnValue = rb_funcall(0, myfunc_2, 0);
    
        WhoamI = rb_gv_get("szWhoamI");
        szWhoamI = rb_string_value_ptr(&WhoamI);
    
        NSLog(@"[myfunc_2]ReturnValue = %s\n", rb_string_value_ptr(&ReturnValue));
        NSLog(@"[myfunc_2]szWhoamI = %s\n", szWhoamI);
    
    
        //////////////////////////////////////////////////////////////
        //
        // Call myfunc_3
        //
        
        NSLog(@"[myfunc_3]========================================");
        myfunc_3 = rb_intern("myfunc_3");
        ReturnValue = rb_funcall(0, myfunc_3, 0);
    
        WhoamI = rb_gv_get("szWhoamI");
        szWhoamI = rb_string_value_ptr(&WhoamI);
        
        RetString = rb_ary_entry(ReturnValue, 0);
    
        NSLog(@"[myfunc_3]sReturnValue = [%s, %s]\n", rb_string_value_ptr(&RetString), (rb_ary_entry(ReturnValue, 1) == Qtrue)? "true" : "false");
        NSLog(@"[myfunc_3]szWhoamI = %s\n", szWhoamI);
    
    
        //////////////////////////////////////////////////////////////
        //
        // Call myfunc_4
        //
        
        NSLog(@"[myfunc_4]========================================");
        myfunc_4 = rb_intern("myfunc_4");
        ReturnValue = rb_funcall(0, myfunc_4, 1, rb_str_new_cstr("myfunc_4"));
    
        WhoamI = rb_gv_get("szWhoamI");
        szWhoamI = rb_string_value_ptr(&WhoamI);
    
        RetString = rb_ary_entry(ReturnValue, 0);
    
        NSLog(@"[myfunc_4]sReturnValue = [%s, %s]\n", rb_string_value_ptr(&RetString), (rb_ary_entry(ReturnValue, 1) == Qtrue)? "true" : "false");
        NSLog(@"[myfunc_4]szWhoamI = %s\n", szWhoamI);

    
        //////////////////////////////////////////////////////////////
        //
        // Call myfunc_5
        //
        
        NSLog(@"[myfunc_5]========================================");
        myfunc_4 = rb_intern("myfunc_5");
        ReturnValue = rb_funcall(0, myfunc_4, 2, rb_str_new_cstr("myfunc_5"), Qfalse);
    
        WhoamI = rb_gv_get("szWhoamI");
        szWhoamI = rb_string_value_ptr(&WhoamI);
    
        RetString = rb_ary_entry(ReturnValue, 0);
    
    
        NSLog(@"[myfunc_5]sReturnValue = [%s, %s]\n", rb_string_value_ptr(&RetString), (rb_ary_entry(ReturnValue, 1) == Qtrue)? "true" : "false");
        NSLog(@"[myfunc_5]szWhoamI = %s\n", szWhoamI);

    
    }
    @catch (NSException *exception)  {
        NSLog( @"NSException caught" );
        NSLog( @"Name: %@", exception.name);
        NSLog( @"Reason: %@", exception.reason );
    }
    @finally {
        if (FALSE == bSuccess)
        {
            ruby_cleanup(0);
        }
    }
    
    
    NSLog(@"Leave %@", NSStringFromSelector(_cmd));
}


VALUE MyDbgString1()
{
    NSLog(@"MyDbgString 호출됨\n");
    
    return Qnil;
}



- (IBAction)Button_4_Click:(id)sender {
    BOOL    bSuccess = FALSE;
    VALUE   VScriptFile = (VALUE)NULL;
    NSString *ScriptFile = [SCRIPT_PATH stringByAppendingPathComponent:@"Sample04.rb"];
    const char *szScriptFile = [ScriptFile UTF8String];
    
    NSLog(@"Enter %@", NSStringFromSelector(_cmd));
    
    @try {
        bSuccess = InitRuby();
        if (FALSE == bSuccess)
            [NSException raise:@"InitRuby" format:@"InitRuby = FALSE"];
        
        VScriptFile = rb_str_new_cstr(szScriptFile);
        if((VALUE)NULL == VScriptFile)
            [NSException raise:@"rb_str_new_cstr" format:@"rb_str_new_cstr = NULL"];
    
        rb_define_global_function("DbgString", (VALUE(*)(ANYARGS))MyDbgString1, 0);
    
        rb_load(VScriptFile, 0);
    }
    @catch (NSException *exception)  {
        NSLog( @"NSException caught" );
        NSLog( @"Name: %@", exception.name);
        NSLog( @"Reason: %@", exception.reason );
    }
    @finally {
        if (FALSE == bSuccess)
        {
            ruby_cleanup(0);
        }
    }

    NSLog(@"Leave %@", NSStringFromSelector(_cmd));
}

VALUE MyDbgString2(VALUE self, VALUE DbgString)
{
    int nType = 0;
    char *szDbgString = NULL;
    
    nType = BUILTIN_TYPE(DbgString);
    
    szDbgString = rb_string_value_cstr(&DbgString);
    
    NSLog(@"%s", szDbgString);
    
    return Qnil;
}

VALUE MySum2(int argc, VALUE * NumArray, VALUE self)
{
    int nType = 0;
    int nStart = 0;
    int nEnd = 0;
    int nSum = 0;
    
    nStart = rb_num2int(NumArray[0]);
    nEnd = rb_num2int(NumArray[1]);
    
    if (nStart <= nEnd)
    {
        for (int nIndex = nStart; nIndex <= nEnd; nIndex++) nSum += nIndex;
    }
    else
    {
        for (int nIndex = nEnd; nIndex <= nStart; nIndex++) nSum += nIndex;
    }
    
    return rb_int2inum(nSum);
}


- (IBAction)Button_5_Click:(id)sender {
    BOOL    bSuccess = FALSE;
    VALUE   VScriptFile = (VALUE)NULL;
    NSString *ScriptFile = [SCRIPT_PATH stringByAppendingPathComponent:@"Sample05.rb"];
    const char *szScriptFile = [ScriptFile UTF8String];
    
    NSLog(@"Enter %@", NSStringFromSelector(_cmd));
    
    @try {
        bSuccess = InitRuby();
        if (FALSE == bSuccess)
            [NSException raise:@"InitRuby" format:@"InitRuby = FALSE"];
        
        VScriptFile = rb_str_new_cstr(szScriptFile);
        if((VALUE)NULL == VScriptFile)
            [NSException raise:@"rb_str_new_cstr" format:@"rb_str_new_cstr = NULL"];
    
        rb_define_global_function("DbgString", (VALUE(*)(ANYARGS))MyDbgString2, 1);
        rb_define_global_function("Sum", (VALUE(*)(ANYARGS))MySum2, -1);
    
        rb_load(VScriptFile, 0);
    }
    @catch (NSException *exception)  {
        NSLog( @"NSException caught" );
        NSLog( @"Name: %@", exception.name);
        NSLog( @"Reason: %@", exception.reason );
    }
    @finally {
        
    }

    NSLog(@"Leave %@", NSStringFromSelector(_cmd));
}

VALUE MyDbgString3(VALUE self, VALUE DbgString)
{
    int nType = 0;
    char *szDbgString = NULL;
    
    nType = BUILTIN_TYPE(DbgString);
    
    szDbgString = rb_string_value_cstr(&DbgString);
    
    NSLog(@"%s", szDbgString);
    
    return Qnil;
}

VALUE MySum3(VALUE self, VALUE NumArray)
{
    int nType = 0;
    int nSize = 0;
    int nStart = 0;
    int nEnd = 0;
    int nSum = 0;
    int nAverage = 0;
    
    nType = BUILTIN_TYPE(NumArray);
    nSize = RARRAY_LEN(NumArray);
    
    nStart = rb_num2int(rb_ary_entry(NumArray, 0));
    nEnd = rb_num2int(rb_ary_entry(NumArray, 1));
    
    if (nStart <= nEnd)
    {
        for (int nIndex = nStart; nIndex <= nEnd; nIndex++) nSum += nIndex;
        
        nAverage = nSum / (nEnd - nStart + 1);
    }
    else
    {
        for (int nIndex = nEnd; nIndex <= nStart; nIndex++) nSum += nIndex;
        
        nAverage = nSum / (nStart - nEnd + 1);
    }
    
    VALUE ary;
    ary = rb_ary_new();
    
    rb_ary_push(ary, rb_int2inum(nSum));
    rb_ary_push(ary, rb_int2inum(nAverage));
    
    return ary;
}

- (IBAction)Button_6_Click:(id)sender {
    BOOL    bSuccess = FALSE;
    VALUE   VScriptFile = (VALUE)NULL;
    NSString *ScriptFile = [SCRIPT_PATH stringByAppendingPathComponent:@"Sample06.rb"];
    const char *szScriptFile = [ScriptFile UTF8String];
    
    NSLog(@"Enter %@", NSStringFromSelector(_cmd));
    
    @try {
        bSuccess = InitRuby();
        if (FALSE == bSuccess)
            [NSException raise:@"InitRuby" format:@"InitRuby = FALSE"];
        
        VScriptFile = rb_str_new_cstr(szScriptFile);
        if((VALUE)NULL == VScriptFile)
            [NSException raise:@"rb_str_new_cstr" format:@"rb_str_new_cstr = NULL"];
        
        rb_define_global_function("DbgString", (VALUE(*)(ANYARGS))MyDbgString3, 1);
        rb_define_global_function("SumAndAverage", (VALUE(*)(ANYARGS))MySum3, -2);
    
        rb_load(VScriptFile, 0);
    }
    @catch (NSException *exception)  {
        NSLog( @"NSException caught" );
        NSLog( @"Name: %@", exception.name);
        NSLog( @"Reason: %@", exception.reason );
    }
    @finally {
    
    }
    NSLog(@"Leave %@", NSStringFromSelector(_cmd));

}
- (IBAction)Button_7_Click:(id)sender {
    NSLog(@"Enter %@", NSStringFromSelector(_cmd));
    
    NSLog(@"Leave %@", NSStringFromSelector(_cmd));
}
- (IBAction)Button_8_Click:(id)sender {
    NSLog(@"Enter %@", NSStringFromSelector(_cmd));
    
    NSLog(@"Leave %@", NSStringFromSelector(_cmd));
}



@end
