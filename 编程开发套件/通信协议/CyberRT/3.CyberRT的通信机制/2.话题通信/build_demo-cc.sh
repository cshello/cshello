#!/usr/bin/env bash 


SRCDIR="cyber/demo_channel/channel_01"
mkdir -p $SRCDIR


cat << EOF > "${SRCDIR}/talker.cc"

#include "cyber/cyber.h"
#include "cyber/demo_protos/person_proto/person.pb.h"

using apollo::cyber::demo_protos::person_proto::Person;

int main(int argc, char const *argv[]){
    apollo::cyber::Init(argv[0]);
    
    auto node_talker = apollo::cyber::CreateNode("node-writer-channel");
    
    auto talker = node_talker->CreateWriter<Person>("chatter-channel-person");

    apollo::cyber::Rate rate(0.5);

    uint64_t times = 0;
    while (apollo::cyber::OK()) {
    
        AINFO << "第" << (times++) << "条消息";
        
        auto msg = std::make_shared<Person>();
        
        msg->set_id(23);
        msg->set_name("Jack");
        msg->set_email("mail@jack.com");

        talker->Write(msg);
        rate.Sleep();

    }


    apollo::cyber::WaitForShutdown();
    return 0;
}


EOF


cat << EOF > "${SRCDIR}/listener.cc"

#include "cyber/cyber.h"
#include "cyber/demo_protos/person_proto/person.pb.h"

using apollo::cyber::demo_protos::person_proto::Person;


void callback_person(const std::shared_ptr<Person> &person) {
    AINFO << "id: " << person->id() << ", name: " << person->name() << ", email: " << person->email();
}


int main(int argc, char const *argv[]){
    apollo::cyber::Init(argv[0]);
    AINFO << "Ok, create listener... ";
    
    auto node_listener = apollo::cyber::CreateNode("node-reader-channel");
    
    auto listener = node_listener->CreateReader<Person>("chatter-channel-person", callback_person);
    
    
    
    apollo::cyber::WaitForShutdown();
    return 0;
}


EOF



cat << EOF > "${SRCDIR}/BUILD"


cc_binary(
    name = "talker",
    srcs = ["talker.cc"],
    deps = [
        "//cyber",
        "//cyber/demo_protos/person_proto:person_cc"
    ]
)

cc_binary(
    name = "listener",
    srcs = ["listener.cc"],
    deps = [
        "//cyber",
        "//cyber/demo_protos/person_proto:person_cc"
    ]
)


EOF


