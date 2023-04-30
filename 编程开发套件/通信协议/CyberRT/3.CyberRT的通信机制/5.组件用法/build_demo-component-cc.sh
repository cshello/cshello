#!/usr/bin/env bash 


SRCDIR="cyber/demo_component/component_01"
mkdir -p $SRCDIR


cat << EOF > "${SRCDIR}/component.h"

#include "cyber/component/component.h"
#include "cyber/demo_protos/person_proto/person.pb.h"

using apollo::cyber::demo_protos::person_proto::Person;

namespace apollo {
namespace cyber {

class CommonPerson: public Component<Person> {
public:
    bool Init() override;
    bool Proc(const std::shared_ptr<Person> &person) override;    
}

CYBER_REGISTER_COMPONENT(CommonPerson);
} // cyber
} // apollo  


EOF


cat << EOF > "${SRCDIR}/component.cc"

#include "component.h"

namespace apollo {
namespace cyber {

bool CommonPerson::Init() {
    AINFO << "CommonPerson::Init()... ";
    return true;
}

bool CommonPerson::Proc(const std::shared_ptr<Person> &person) {
    AINFO << "CommonPerson::Proc()... ";

    return true;
}


} // cyber  
} // apollo  


EOF


cat << EOF > "${SRCDIR}/BUILD"

cc_library(
    name = "common-person-lib",
    srcs = ["component.cc"],
    hdrs = ["component.h"],
    deps = [
	"//cyber",
	"//cyber/demo_protos/person_proto:person_cc"
    ]
)

cc_binary(
    name = "lib_common_person.so",
    linkshared = True,
    linkstatic = False,
    deps = [":common-person-lib"]
)






EOF





