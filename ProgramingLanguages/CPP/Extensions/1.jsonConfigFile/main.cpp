/*
需求：
    序列化变量，当机器停止或重启是能重新加载到这个变量

解决方案：
    已json为中间层，data.txt文件为序列化后的永久保存文件，
class Config 为与程序交互的类


*/
#include <iostream>


#include "Config.h"

using namespace std;



int main(int argc, char *argv[]) {
    cout << "Hello File: " << __FILE__ << endl;    
    Config cfg("a.json");
    cfg.loadJson();
    cfg.setValueFloat("a:b", 1);
    cfg.print();
    cfg.saveJson();
    system("cat a.json");
    return 0;
}
