#ifndef CONFIG_H__
#define CONFIG_H__


#include <string>
#include <sys/stat.h>
#include "nlohmann/json.hpp"


#define CONFIG_FILE "config.json"

using namespace std;
using json = nlohmann::json;


class Config {
public:
    Config();
    Config(const string &file);
    ~Config();

    /**
     * 如果配置文件有改动，置为true
     * @return
     */
    bool isUpdate();

    void loadJson(const string &file="");
    void saveJson(const string &file="");

    void setFile(const string &file);
    const string &getFile() const;

    json &getKey(json &data, const string &key, size_t idx = 0);

    void setValueFloat(const string &key, float val);

    float getValueFloat(const string &key);

    void print();


protected:
    string file_;
    struct stat fstat_;
    time_t last_update_;
    json data_;
};




#endif 
