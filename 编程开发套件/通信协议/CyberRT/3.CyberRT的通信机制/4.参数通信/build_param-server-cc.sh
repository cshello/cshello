#!/usr/bin/env bash 


SRCDIR="cyber/demo_params/param_01"
mkdir -p ${SRCDIR}


cat << EOF > "${SRCDIR}/param_server.cc"

#include "cyber/cyber.h"
#include "cyber/parameter/parameter_server.h"


using apollo::cyber::ParameterServer;
using apollo::cyber::Parameter;


int main(int argc, char const *argv[]) {
    apollo::cyber::Init(argv[0]);
    AINFO << "Param Init...";
    
    std::shared_ptr<apollo::cyber::Node> node = apollo::cyber::CreateNode("param-server");
    
    auto server = std::make_shared<ParameterServer>(node);
    
    server->SetParameter(Parameter("type", "Person"));
    server->SetParameter(Parameter("height", 175));
    
    
    Parameter temp;
    server->GetParameter("type", &temp);
    AINFO << temp.Name() << ": " << temp.AsString();
    server->GetParameter("height", &temp);
    AINFO << temp.Name() << ": " << temp.AsInt64();
    
    
    apollo::cyber::WaitForShutdown();
    return 0;
}

EOF


cat << EOF > "${SRCDIR}/param_client.cc"

#include "cyber/cyber.h"
#include "cyber/parameter/parameter_client.h"

using apollo::cyber::ParameterClient;
using apollo::cyber::Parameter;


int main(int argc, char const *argv[]) {
    apollo::cyber::Init(argv[0]);
    AINFO << "Client Init...";
    
    std::shared_ptr<apollo::cyber::Node> node = apollo::cyber::CreateNode("param-client");
    
    auto client = std::make_shared<ParameterClient>(node, "param-server");
    
    
    Parameter temp;
    client->GetParameter("type", &temp);
    AINFO << temp.Name() << ": " << temp.AsString();
    client->GetParameter("height", &temp);
    AINFO << temp.Name() << ": " << temp.AsInt64();
    
    // Reset param 
    AINFO << "Reset height param...";
    client->SetParameter(Parameter("height", 180));
    client->GetParameter("height", &temp);
    AINFO << temp.Name() << ": " << temp.AsInt64();
    
    
    apollo::cyber::WaitForShutdown();
    return 0;
}


EOF



cat << EOF > "${SRCDIR}/BUILD"

cc_binary(
    name = "param_server",
    srcs = ["param_server.cc"],
    deps = [
        "//cyber",
        "//cyber/parameter"
    ]
)

cc_binary(
    name = "param_client",
    srcs = ["param_client.cc"],
    deps = [
        "//cyber",
        "//cyber/parameter"
    ]
)

EOF


