#!/usr/bin/env bash 



SRCDIR="cyber/demo_server/server_01"

mkdir -p ${SRCDIR}



cat << EOF > "${SRCDIR}/server.cc"

#include <iostream>
#include "cyber/cyber.h"
#include "cyber/demo_protos/person_proto/person.pb.h"


using apollo::cyber::demo_protos::person_proto::Person;


void _callback(const std::shared_ptr<Person> &request, const std::shared_ptr<Person> &response) {
    int32_t id_ = request->id();
    std::string name = request->name();
    std::string email = request->email();
    
    response->set_id(id_ + 1);
    response->set_name(name);
    response->set_email(email);

    return;
}


int main(int argc, char const *argv[]) {
    
    apollo::cyber::Init(argv[0]);
    AINFO << "Server Init... ";

    auto node = apollo::cyber::CreateNode("node-server");

    auto server = node->CreateService<Person, Person>("chatter-server", _callback);

    apollo::cyber::WaitForShutdown();
    return 0;

}


EOF


cat << EOF > "${SRCDIR}/client.cc"

#include <string>
#include "cyber/cyber.h"
#include "cyber/demo_protos/person_proto/person.pb.h"

using apollo::cyber::demo_protos::person_proto::Person;


int main(int argc, char const *argv[]){
    apollo::cyber::Init(argv[0]);
    AINFO << "Client Init...";

    auto node = apollo::cyber::CreateNode("node-client");

    auto client = node->CreateClient<Person, Person>("chatter-server");

    // Create Request data 
    auto request = std::make_shared<Person>();
    std::shared_ptr<Person> response;

    request->set_id(22);
    request->set_name("Jack");
    request->set_email("mail@jack.com");

    AINFO << "Request data: [id: " << request->id() << " ]";
    response = client->SendRequest(request);
    AINFO << "Response data: [id: " << response->id() << " ]";

    
    request->set_id(32);
    AINFO << "Request data: [id: " << request->id() << " ]";
    response = client->SendRequest(request);
    AINFO << "Response data: [id: " << response->id() << " ]";

    
    apollo::cyber::WaitForShutdown();
    return 0;
}

EOF


cat << EOF > "${SRCDIR}/BUILD"

cc_binary(
    name = "server",
    srcs = ["server.cc"],
    deps = [
	"//cyber",
	"//cyber/demo_protos/person_proto:person_cc"
    ]
)

cc_binary(
    name = "client",
    srcs = ["client.cc"],
    deps = [
	"//cyber",
	"//cyber/demo_protos/person_proto:person_cc"
    ]
)


EOF





