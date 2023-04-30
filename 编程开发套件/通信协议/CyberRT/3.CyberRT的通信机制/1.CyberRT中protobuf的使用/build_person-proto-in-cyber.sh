#!/usr/bin/env bash 


SRCDIR="cyber/demo_protos/person_proto"
mkdir -p ${SRCDIR}


# CODE

cat << EOF > "${SRCDIR}/person.proto"

syntax = "proto2";

package apollo.cyber.demo_protos.person_proto;

message Person {
    required int32 id = 1;
    required string name = 2;
    required string email = 3;
    repeated Person partners = 4;
}

EOF


cat << EOF > "${SRCDIR}/person_cc_test.cc"
#include "cyber/demo_protos/person_proto/person.pb.h"

int main(int argc, char const *argv[]){
    // Instantiate
    apollo::cyber::demo_protos::person_proto::Person person;
    
    // Set
    person.set_id(21);
    person.set_name("Jack");
    person.set_email("mail@jack.com");

    // Read
    int id = person.id();
    std::string name = person.name();
    std::string email = person.email();
    std::cout << "id: " << id << ", name: " << name << ", email: " << email << std::endl;
}

EOF


cat << EOF > ${SRCDIR}/person_py_test.py

from cyber.demo_protos.person_proto.person_pb2 import Person

if __name__ == "__main__":
    person = Person()
    
    person.id = 22
    person.name = "Jack"
    person.email = "mail@jack.com"

    print(f"person: {person}")

EOF


# CONFIG

cat << EOF > $SRCDIR/BUILD
load("//tools:python_rules.bzl", "py_proto_library")
package(default_visibility = ["//visibility:public"])


proto_library(
    name = "person_proto",
    srcs = ["person.proto"]
)


cc_proto_library(
    name = "person_cc",
    deps = [":person_proto"]
)


cc_binary(
    name = "person_cc_test",
    srcs = ["person_cc_test.cc"],
    deps = [":person_cc"]    
)

py_proto_library(
    name = "person_py",
    deps = [":person_proto"]
)

py_binary(
    name = "person_py_test",
    srcs = ["person_py_test.py"],
    deps = [":person_py"]
)

EOF


# BUILD and RUN for C++
# bazel build cyber/demo_protos/person_proto:person_cc_test 
# bazel run cyber/demo_protos/person_proto:person_cc_test 

# BUILD and RUN for py
bazel build cyber/demo_protos/person_proto:person_py_test 
bazel run cyber/demo_protos/person_proto:person_py_test 

