#include <iostream>
#include <fstream>

#include "Config.h"



Config::Config(): file_({}), last_update_(0), data_({}) {};

Config::Config(const string &file): Config() {
    file_ = file;
}

Config::~Config() {

}


bool Config::isUpdate() {
    if (file_.empty()) {
        return false;
    }

    if (stat(file_.c_str(), &fstat_) == 0) {
        if (fstat_.st_mtime != last_update_) {
            return true;
        }
    } else {
        std::cerr << "配置文件不存在" << std::endl;
    }
    return false;
}


void Config::loadJson(const string &file) {
    try {
        if (file.empty()) {
            if (file_.empty()) {
                return;
            }
            loadJson(file_);
            return;
        }


        ifstream f(file);
        data_ = json::object();
        if (f.is_open()) {
            f >> data_;
            f.close();
        }

        // update last_update_
        if (stat(file.c_str(), &fstat_) == 0) {
            last_update_ = fstat_.st_mtime;
        }

        std::cout << data_ << std::endl;
    } catch (...) {
        std::cerr << "ReadJsonConfigError, file: " << file << std::endl;
    }
}

void Config::saveJson(const string &file) {
    try {
        if (file.empty()) {
            if (file_.empty()) {
                return;
            }
            saveJson(file_);
            return ;
        }


        if (file.empty()) {
            return;
        }
        ofstream f(file);
        if (f.is_open()) {
            f << setw(2) << data_;
        } else {
            // err save data
        }
        f.close();
    } catch (...) {
        std::cerr << "WriteJsonConfigError, file: " << file_ << std::endl;
    }
}


void Config::setFile(const string &file) {
    file_ = file;
}

const string &Config::getFile() const {
    return file_;
}


json &Config::getKey(json &data, const string &key, size_t idx ) {
    while (idx < key.size() && key.substr(idx, 1) == ":") {
        idx += 1;
    }

    size_t ssize = idx + 1;

    while (ssize < key.size() && key.substr(ssize, 1) != ":") {
        ssize += 1;
    }
    // cout << "(" << idx << ", " << ssize <<  "), key: " << key.substr(idx, ssize - idx) << endl;
    if (idx < key.size()) {
        return getKey(data[key.substr(idx, ssize - idx)], key, ssize);
    }
    return data;
};


void Config::setValueFloat(const string &key, float val) {
    getKey(data_, key) = val;
}



float Config::getValueFloat(const string &key) {
    json &data = getKey(data_, key);
    if (data.is_number()) {
        return float(data);
    }
    return INFINITY;
}



void Config::print() {
    cout << std::setw(2) << data_ << endl;
}



