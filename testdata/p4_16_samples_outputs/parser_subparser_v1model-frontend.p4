#include <core.p4>
#define V1MODEL_VERSION 20180101
#include <v1model.p4>

struct metadata {
}

header data_t {
    bit<8> f;
}

header data_t16 {
    bit<16> f;
}

struct headers {
    data_t   h1;
    data_t16 h2;
    data_t   h3;
    data_t   h4;
}

struct headers2 {
    data_t h1;
}

parser ParserImpl(packet_in packet, out headers hdr, inout metadata meta, inout standard_metadata_t standard_metadata) {
    @name("ParserImpl.hdr2") headers2 hdr2_0;
    @name("ParserImpl.p.local_hdr2") headers2 p_local_hdr2;
    state start {
        hdr2_0.h1.setInvalid();
        transition select(standard_metadata.ingress_port) {
            9w0: p_0;
            9w1: p_1;
            9w2: p_2;
            9w3: p_3;
            9w4: p_4;
            9w5: p_5;
            default: accept;
        }
    }
    state p_0 {
        hdr2_0.h1.f = 8w100;
        hdr2_0.h1.setValid();
        hdr.h1.setInvalid();
        hdr.h2.setInvalid();
        hdr.h3.setInvalid();
        hdr.h4.setInvalid();
        transition PacketParser_start;
    }
    state PacketParser_start {
        p_local_hdr2.h1.setInvalid();
        packet.extract<data_t>(hdr.h1);
        transition select(hdr.h1.f) {
            8w10: PacketParser_local;
            8w11: PacketParser_local_0;
            8w12: PacketParser_local_1;
            default: p_7;
        }
    }
    state PacketParser_local {
        p_local_hdr2.h1.f = 8w10;
        p_local_hdr2.h1.setValid();
        transition PacketParser_parse_h2;
    }
    state PacketParser_local_0 {
        p_local_hdr2.h1.f = 8w11;
        p_local_hdr2.h1.setValid();
        transition PacketParser_parse_h2;
    }
    state PacketParser_local_1 {
        p_local_hdr2.h1.f = 8w12;
        p_local_hdr2.h1.setValid();
        transition PacketParser_parse_h2;
    }
    state PacketParser_parse_h2 {
        hdr2_0.h1.f = p_local_hdr2.h1.f;
        hdr2_0.h1.setValid();
        packet.extract<data_t16>(hdr.h2);
        transition p_7;
    }
    state p_7 {
        transition accept;
    }
    state p_1 {
        hdr2_0.h1.f = 8w101;
        hdr2_0.h1.setValid();
        hdr.h1.setInvalid();
        hdr.h2.setInvalid();
        hdr.h3.setInvalid();
        hdr.h4.setInvalid();
        transition PacketParser_start_0;
    }
    state PacketParser_start_0 {
        p_local_hdr2.h1.setInvalid();
        packet.extract<data_t>(hdr.h1);
        transition select(hdr.h1.f) {
            8w10: PacketParser_local_2;
            8w11: PacketParser_local_3;
            8w12: PacketParser_local_4;
            default: p_8;
        }
    }
    state PacketParser_local_2 {
        p_local_hdr2.h1.f = 8w10;
        p_local_hdr2.h1.setValid();
        transition PacketParser_parse_h2_0;
    }
    state PacketParser_local_3 {
        p_local_hdr2.h1.f = 8w11;
        p_local_hdr2.h1.setValid();
        transition PacketParser_parse_h2_0;
    }
    state PacketParser_local_4 {
        p_local_hdr2.h1.f = 8w12;
        p_local_hdr2.h1.setValid();
        transition PacketParser_parse_h2_0;
    }
    state PacketParser_parse_h2_0 {
        hdr2_0.h1.f = p_local_hdr2.h1.f;
        hdr2_0.h1.setValid();
        packet.extract<data_t16>(hdr.h2);
        transition p_8;
    }
    state p_8 {
        transition select(hdr.h1.f) {
            8w10: parse_h3;
            default: reject;
        }
    }
    state p_2 {
        hdr2_0.h1.f = 8w102;
        hdr2_0.h1.setValid();
        hdr.h1.setInvalid();
        hdr.h2.setInvalid();
        hdr.h3.setInvalid();
        hdr.h4.setInvalid();
        transition PacketParser_start_1;
    }
    state PacketParser_start_1 {
        p_local_hdr2.h1.setInvalid();
        packet.extract<data_t>(hdr.h1);
        transition select(hdr.h1.f) {
            8w10: PacketParser_local_5;
            8w11: PacketParser_local_6;
            8w12: PacketParser_local_7;
            default: p_9;
        }
    }
    state PacketParser_local_5 {
        p_local_hdr2.h1.f = 8w10;
        p_local_hdr2.h1.setValid();
        transition PacketParser_parse_h2_1;
    }
    state PacketParser_local_6 {
        p_local_hdr2.h1.f = 8w11;
        p_local_hdr2.h1.setValid();
        transition PacketParser_parse_h2_1;
    }
    state PacketParser_local_7 {
        p_local_hdr2.h1.f = 8w12;
        p_local_hdr2.h1.setValid();
        transition PacketParser_parse_h2_1;
    }
    state PacketParser_parse_h2_1 {
        hdr2_0.h1.f = p_local_hdr2.h1.f;
        hdr2_0.h1.setValid();
        packet.extract<data_t16>(hdr.h2);
        transition p_9;
    }
    state p_9 {
        packet.extract<data_t>(hdr.h4);
        transition accept;
    }
    state p_3 {
        hdr2_0.h1.f = 8w103;
        hdr2_0.h1.setValid();
        hdr.h1.setInvalid();
        hdr.h2.setInvalid();
        hdr.h3.setInvalid();
        hdr.h4.setInvalid();
        transition PacketParser_start_0;
    }
    state p_4 {
        hdr2_0.h1.f = 8w104;
        hdr2_0.h1.setValid();
        hdr.h1.setInvalid();
        hdr.h2.setInvalid();
        hdr.h3.setInvalid();
        hdr.h4.setInvalid();
        transition PacketParser_start;
    }
    state p_5 {
        hdr2_0.h1.f = 8w105;
        hdr2_0.h1.setValid();
        hdr.h1.setInvalid();
        hdr.h2.setInvalid();
        hdr.h3.setInvalid();
        hdr.h4.setInvalid();
        transition PacketParser_start_2;
    }
    state PacketParser_start_2 {
        p_local_hdr2.h1.setInvalid();
        packet.extract<data_t>(hdr.h1);
        transition select(hdr.h1.f) {
            8w10: PacketParser_local_8;
            8w11: PacketParser_local_9;
            8w12: PacketParser_local_10;
            default: p_10;
        }
    }
    state PacketParser_local_8 {
        p_local_hdr2.h1.f = 8w10;
        p_local_hdr2.h1.setValid();
        transition PacketParser_parse_h2_2;
    }
    state PacketParser_local_9 {
        p_local_hdr2.h1.f = 8w11;
        p_local_hdr2.h1.setValid();
        transition PacketParser_parse_h2_2;
    }
    state PacketParser_local_10 {
        p_local_hdr2.h1.f = 8w12;
        p_local_hdr2.h1.setValid();
        transition PacketParser_parse_h2_2;
    }
    state PacketParser_parse_h2_2 {
        hdr2_0.h1.f = p_local_hdr2.h1.f;
        hdr2_0.h1.setValid();
        packet.extract<data_t16>(hdr.h2);
        transition p_10;
    }
    state p_10 {
        transition select(hdr.h1.f) {
            8w11: parse_h3;
            default: reject;
        }
    }
    state parse_h3 {
        packet.extract<data_t>(hdr.h3);
        transition accept;
    }
}

control ingress(inout headers hdr, inout metadata meta, inout standard_metadata_t standard_metadata) {
    apply {
        if (hdr.h4.isValid()) {
            standard_metadata.egress_port = 9w4;
        } else if (hdr.h3.isValid()) {
            standard_metadata.egress_port = 9w3;
        } else if (hdr.h2.isValid()) {
            standard_metadata.egress_port = 9w2;
        } else {
            standard_metadata.egress_port = 9w10;
        }
    }
}

control egress(inout headers hdr, inout metadata meta, inout standard_metadata_t standard_metadata) {
    apply {
    }
}

control DeparserImpl(packet_out packet, in headers hdr) {
    apply {
        packet.emit<headers>(hdr);
    }
}

control verifyChecksum(inout headers hdr, inout metadata meta) {
    apply {
    }
}

control computeChecksum(inout headers hdr, inout metadata meta) {
    apply {
    }
}

V1Switch<headers, metadata>(ParserImpl(), verifyChecksum(), ingress(), egress(), computeChecksum(), DeparserImpl()) main;

