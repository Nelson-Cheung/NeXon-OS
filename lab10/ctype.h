#ifndef CTYPE_H
#define CTYPE_H

// 判断是否为空白字符
bool IsSpace(int c);
// 判断是否为数字
bool IsDigit(int c);

bool IsSpace(int c) 
{
    return c == ' ' || 
           c == '\t' || 
           c == '\r' || 
           c == '\n' || 
           c == '\v' || 
           c == '\f';
}

bool IsDigit(int c) {
    return c >= '0' && c <= '9';
}
#endif