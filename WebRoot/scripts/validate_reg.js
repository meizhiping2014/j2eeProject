/**
 * 共用正则表达式校验工具库
 * 这里整理了比较常见的正则校验库，以备方便使用！
 * @Date:2016-02-20
 * @version:v0.1
 */
Reg={
        /**
         * 校验通用
         * @param exp
         * @param str
         * @returns
         */
        regEnter:function(exp,str){
            if(Reg.isNull(exp)){
                alert("校验表达式不能为空！");
                return false;
            }else if(Reg.isNull(str)){
                alert("被校验字符串不能为空！");
                return false;
            }
            var reg=eval(exp);
            return reg.test(str);
        },
        /**
         * 空的校验
         * @param param
         * @returns {Boolean}
         */
        isNull:function(param){
            if(typeof(param)=="undefined"||param==null||param=="null"||param==""){
                return true;
            }else{
                return false;
            }
        },
        /**
         * 整数或者小数
         * @param str
         * @returns
         */
        intOrFloat:function(str){
            var exp="/^[0-9]+\.{0,1}[0-9]{0,2}$/";
            return Reg.regEnter(exp,str);
        },
        /**
         * 只能是数字
         * @param str
         * @returns
         */
        onlyInt:function(str){
            var exp="/^[0-9]*$/";
            return Reg.regEnter(exp,str);
        },
        /**
         * 只能输入n位的数字
         * @param str
         * @param n
         * @returns
         */
        onlyNNumInt:function(str,n){
            if(Reg.isNull(n)){
                alert("需要校验的数字位数不能为空！");
                return false;
            }
            var exp="/^\d{"+n+"}$/";
            return Reg.regEnter(exp,str);
        },
        /**
         * 至少n位数字
         * @param str
         * @param n
         * @returns
         */
        nNumInt:function(str,n){
            if(Reg.isNull(n)){
                alert("需要校验的数字位数不能为空！");
                return false;
            }
            var exp="/^\d{"+n+",}$/";
            return Reg.regEnter(exp,str);
        },
        /**
         * n到m位数字
         * @param str
         * @param n
         * @param m
         * @returns
         */
        n_mNumInt:function(str,n,m){
            if(Reg.isNull(n)||Reg.isNull(m)){
                alert("需要校验的数字位数不能为空！");
                return false;
            }
            var exp="/^\d{"+n+","+m+"}$/";
            return Reg.regEnter(exp,str);
        },
        /**
         * 只能输入非零开头的数字
         * @param str
         * @returns
         */
        zeroOrNoZeroStart:function(str){
            var exp="/^([1-9][0-9]*)$/";
            return Reg.regEnter(exp,str);
        },
        /**
         * 只能输入有n位小数的正实数
         * @param str
         * @param n
         * @returns
         */
        nDecimals:function(str,n){
            var exp="/^[0-9]+(.[0-9]{"+n+"})?$/";
            return Reg.regEnter(exp,str);
        },
        /**
         * 只能输入有n~m位小数的正实数
         * @param str
         * @param n
         * @param m
         * @returns
         */
        n_mDecimals:function(str,n,m){
            var exp="/^[0-9]+(.[0-9]{"+n+","+m+"})?$/";
            return Reg.regEnter(exp,str);
        },
        /**
         * 非零正整数
         * @param str
         * @returns
         */
        noZeroInt:function(str){
            var exp="/^\\+?[1-9][0-9]*$/";
            return Reg.regEnter(exp,str);
        },
        /**
         * 菲零负整数
         * @param str
         * @returns
         */
        noZeroNegaInt:function(str){
            var exp="/^\-[1-9][0-9]*$/";
            return Reg.regEnter(exp,str);
        },
        /**
         * 长度为n的字符串
         * @param str
         * @returns
         */
        length_n_str:function(str,n){
            var exp="/^.{"+n+"}$/";
            return Reg.regEnter(exp,str);
        },
        /**
         * 由26个英文字母组成的字符串
         * @param str
         * @param aorA,大写或小写类型，A表示大写，a表示小写，不指定或其他置顶表示不限制大小写
         * @returns
         */
        letter_str:function(str,aorA){
            var exp;
            if(Reg.isNull(aorA)){
                exp="/^[A-Za-z]+$/";
            }else if(aorA=="A"){
                exp="/^[A-Z]+$/";
            }else if(aorA=="a"){
                exp="/^[a-z]+$/";
            }else{
                exp="/^[A-Za-z]+$/";
            }
            return Reg.regEnter(exp,str);
        },
        /**
         * 由数字、26个英文字母或者下划线组成的字符串
         * @param str
         * @returns
         */
        letter_int_str:function(str){
            var exp="/^\w+$/";
            return Reg.regEnter(exp, str);
        },
        /**
         * 以字母开头，长度在n~m之间，只能包含字符、数字和下划线
         * @param str
         * @param n 最短长度
         * @param m 最长长度
         * @returns
         */
        nm_letter_int_str:function(str,n,m){
            var exp="/^[a-zA-Z]\\w{"+n+","+m+"}$/";
            return Reg.regEnter(exp, str);
        },
        /**
         * 验证是否含有^%&',;=?$\"等特殊字符
         * @param str
         * @returns
         */
        isSpecialStr:function(str){
            var exp="/[^%&',;=?$\x22]+/";
            return Reg.regEnter(exp, str);
        },
        /**
         * 只能输入汉字
         * @param str
         * @returns
         */
        chinese:function(str){
            var exp="/^[\u4e00-\u9fa5]{0,}$/";
            return Reg.regEnter(exp, str);
        },
        /**
         * 验证Email地址
         * @param str
         * @returns
         */
        email:function(str){
            var exp="/^\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*$/";
            return Reg.regEnter(exp, str);
        },
        /**
         * 验证InternetURL地址
         * @param str
         * @returns
         */
        internetUrl:function(str){
            var exp="/^http://([\w-]+\.)+[\w-]+(/[\w-./?%&=]*)?$/";
            return Reg.regEnter(exp, str);
        },
        /**
         * 验证电话号码,正确格式为："XXX-XXXXXXX"、"XXXX-XXXXXXXX"、"XXX-XXXXXXX"、"XXX-XXXXXXXX"、"XXXXXXX"和"XXXXXXXX"
         * @param str
         * @returns
         */
        tel:function(str){
            var exp="/^(\(\d{3,4}-)|\d{3.4}-)?\d{7,8}$/";
            return Reg.regEnter(exp, str);
        },
        /**
         * 匹配手机号
         * @param str
         * @returns
         */
        Mobile:function(str){
            var exp="/(^(13\\d|15[^4,\\D]|17[13678]|18\\d)\\d{8}|170[^346,\\D]\\d{7})$/";
            return Reg.regEnter(exp, str);
        },
        /**
         * 验证身份证号（15位或18位数字）
         * @param str
         * @returns
         */
        IdCard:function(str){
            var exp="/^\d{15}|\d{18}$/";
            return Reg.regEnter(exp, str);
        },
        /**
         * 货币输入校验
         * @param str
         * @returns
         */
        money:function(str){
            var exp="/^\d+\.\d{2}$/";
            return Reg.regEnter(exp, str);
        },
        /**
         * 验证一年的12月，正确格式为："01"～"09"和"1"～"12"。
         * @param str
         * @returns
         */
        month:function(str){
            var exp="/^(0?[1-9]|1[0-2])$/";
            return Reg.regEnter(exp, str);
        },
        /**
         * 验证一个月的31天,正确格式为；"01"～"09"和"1"～"31"。
         * @param str
         * @returns
         */
        day:function(str){
            var exp="/^((0?[1-9])|((1|2)[0-9])|30|31)$/";
            return Reg.regEnter(exp, str);
        },
        /**
         * 匹配html标签的正则表达式
         * @param str
         * @returns
         */
        html:function(str){
            var exp="/<(.*)>(.*)<\/(.*)>|<(.*)\/>/";
            return Reg.regEnter(exp, str);
        },
        /**
         * 匹配空行的正则表达式
         * @param str
         * @returns
         */
        space:function(str){
            var exp="/\n[\s| ]*\r/";
            return Reg.regEnter(exp, str);
        },
        /**
         * 匹配首尾空格的正则表达式
         * @param str
         * @returns
         */
        start_end_space:function(str){
            var exp="/^(^\s*)|(\s*$)$/";
            return Reg.regEnter(exp, str);
        },
        /**
         * 匹配QQ号
         * @param str
         * @returns
         */
        QQ:function(str){
            var exp="/^[1-9][0-9]{4,}$/";
            return Reg.regEnter(exp, str);
        },
        /**
         * 匹配邮编
         * @param str
         * @returns
         */
        ZipCode:function(str){
            var exp="/^[\d]{6}/";
            return Reg.regEnter(exp, str);
        },
        /**
         * 匹配双字节字符(包括汉字在内)
         * @param str
         */
        other:function(str){
            var exp="/[^\x00-\xff]/";
            return Reg.regEnter(exp, str);
        },
        /**
         * 类似java中的trim函数
         */
        trim:function(str){
            return str.replace(/(^\s*)|(\s*$)/g, "");
        },
        pass:function(str){
        	var exp = /^([0-9a-zA-Z\_`!~@#$%^*+=,.?;'":)(}{/\\\|<>&\[\-]|\])+$/;
        	return Reg.regEnter(exp, str);
        }
}


function IdentityCodeValid(code) {
    var city={11:"北京",12:"天津",13:"河北",14:"山西",15:"内蒙古",21:"辽宁",22:"吉林",23:"黑龙江 ",31:"上海",32:"江苏",33:"浙江",34:"安徽",35:"福建",36:"江西",37:"山东",41:"河南",42:"湖北 ",43:"湖南",44:"广东",45:"广西",46:"海南",50:"重庆",51:"四川",52:"贵州",53:"云南",54:"西藏 ",61:"陕西",62:"甘肃",63:"青海",64:"宁夏",65:"新疆",71:"台湾",81:"香港",82:"澳门",91:"国外 "};
    var tip = "";
    var pass= true;
    
    if(!code || !/^\d{6}(18|19|20)?\d{2}(0[1-9]|1[12])(0[1-9]|[12]\d|3[01])\d{3}(\d|X)$/i.test(code)){
        tip = "身份证号格式错误";
        pass = false;
    }else if(!city[code.substr(0,2)]){
        tip = "地址编码错误";
        pass = false;
    }else{
        //18位身份证需要验证最后一位校验位
        if(code.length == 18){
            code = code.split('');
            //∑(ai×Wi)(mod 11)
            //加权因子
            var factor = [ 7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2 ];
            //校验位
            var parity = [ 1, 0, 'X', 9, 8, 7, 6, 5, 4, 3, 2 ];
            var sum = 0;
            var ai = 0;
            var wi = 0;
            for (var i = 0; i < 17; i++)
            {
                ai = code[i];
                wi = factor[i];
                sum += ai * wi;
            }
            var last = parity[sum % 11];
            if(parity[sum % 11] != code[17]){
                tip = "校验位错误";
                pass =false;
            }
        }
    }
    //if(!pass) alert(tip);
    return pass;
}

// 
var idNoCheck = function (idcard) {
var Errors = new Array("\u9a8c\u8bc1\u901a\u8fc7!", "\u8eab\u4efd\u8bc1\u53f7\u7801\u4f4d\u6570\u4e0d\u5bf9!", "\u8eab\u4efd\u8bc1\u53f7\u7801\u51fa\u751f\u65e5\u671f\u8d85\u51fa\u8303\u56f4\u6216\u542b\u6709\u975e\u6cd5\u5b57\u7b26!", "\u8eab\u4efd\u8bc1\u53f7\u7801\u6821\u9a8c\u9519\u8bef!", "\u8eab\u4efd\u8bc1\u5730\u533a\u975e\u6cd5!");
var area = {11:"\u5317\u4eac", 12:"\u5929\u6d25", 13:"\u6cb3\u5317", 14:"\u5c71\u897f", 15:"\u5185\u8499\u53e4", 21:"\u8fbd\u5b81", 22:"\u5409\u6797", 23:"\u9ed1\u9f99\u6c5f", 31:"\u4e0a\u6d77", 32:"\u6c5f\u82cf", 33:"\u6d59\u6c5f", 34:"\u5b89\u5fbd", 35:"\u798f\u5efa", 36:"\u6c5f\u897f", 37:"\u5c71\u4e1c", 41:"\u6cb3\u5357", 42:"\u6e56\u5317", 43:"\u6e56\u5357", 44:"\u5e7f\u4e1c", 45:"\u5e7f\u897f", 46:"\u6d77\u5357", 50:"\u91cd\u5e86", 51:"\u56db\u5ddd", 52:"\u8d35\u5dde", 53:"\u4e91\u5357", 54:"\u897f\u85cf", 61:"\u9655\u897f", 62:"\u7518\u8083", 63:"\u9752\u6d77", 64:"\u5b81\u590f", 65:"xinjiang", 71:"\u53f0\u6e7e", 81:"\u9999\u6e2f", 82:"\u6fb3\u95e8", 91:"\u56fd\u5916"};
var idcard, Y, JYM;
var S, M;
var idcard_array = new Array();
idcard_array = idcard.split("");
if (area[parseInt(idcard.substr(0, 2))] == null) {
return Errors[4];
}
switch (idcard.length) {
case 15:
if ((parseInt(idcard.substr(6, 2)) + 1900) % 4 == 0 || ((parseInt(idcard.substr(6, 2)) + 1900) % 100 == 0 && (parseInt(idcard.substr(6, 2)) + 1900) % 4 == 0)) {
	ereg = /^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}$/;//测试出生日期的合法性 
} else {
	ereg = /^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}$/;//测试出生日期的合法性 
}
if (ereg.test(idcard)) {
	return Errors[0];
} else {
	return Errors[2];
}
break;
case 18:
if (parseInt(idcard.substr(6, 4)) % 4 == 0 || (parseInt(idcard.substr(6, 4)) % 100 == 0 && parseInt(idcard.substr(6, 4)) % 4 == 0)) {
	ereg = /^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}[0-9Xx]$/;//闰年出生日期的合法性正则表达式 
} else {
	ereg = /^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}[0-9Xx]$/;//平年出生日期的合法性正则表达式 
}
if (ereg.test(idcard)) {
	S = (parseInt(idcard_array[0]) + parseInt(idcard_array[10])) * 7 + (parseInt(idcard_array[1]) + parseInt(idcard_array[11])) * 9 + (parseInt(idcard_array[2]) + parseInt(idcard_array[12])) * 10 + (parseInt(idcard_array[3]) + parseInt(idcard_array[13])) * 5 + (parseInt(idcard_array[4]) + parseInt(idcard_array[14])) * 8 + (parseInt(idcard_array[5]) + parseInt(idcard_array[15])) * 4 + (parseInt(idcard_array[6]) + parseInt(idcard_array[16])) * 2 + parseInt(idcard_array[7]) * 1 + parseInt(idcard_array[8]) * 6 + parseInt(idcard_array[9]) * 3;
	Y = S % 11;
	M = "F";
	JYM = "10X98765432";
	M = JYM.substr(Y, 1);
	if (M == idcard_array[17]) {
		return Errors[0];
	} else {
		return Errors[3];
	}
} else {
	return Errors[2];
}
break;
default:
return Errors[1];
break;
}
} 