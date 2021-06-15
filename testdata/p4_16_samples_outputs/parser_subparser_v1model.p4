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

parser PacketParser(packet_in packet, out headers hdr, inout headers2 inout_hdr) {
    headers2 local_hdr2;
    state start {
        packet.extract(hdr.h1);
        transition select(hdr.h1.f) {
            10: local_10;
            11: local_11;
            12: local_12;
            default: accept;
        }
    }
    state local_10 {
        local_hdr2.h1.f = 10;
        local_hdr2.h1.setValid();
        transition parse_h2;
    }
    state local_11 {
        local_hdr2.h1.f = 11;
        local_hdr2.h1.setValid();
        transition parse_h2;
    }
    state local_12 {
        local_hdr2.h1.f = 12;
        local_hdr2.h1.setValid();
        transition parse_h2;
    }
    state parse_h2 {
        inout_hdr.h1.f = local_hdr2.h1.f;
        inout_hdr.h1.setValid();
        packet.extract(hdr.h2);
        transition accept;
    }
}

parser ParserImpl(packet_in packet, out headers hdr, inout metadata meta, inout standard_metadata_t standard_metadata) {
    PacketParser() p;
    headers2 hdr2;
    state start {
        transition select(standard_metadata.ingress_port) {
            0: p_0;
            1: p_1;
            2: p_2;
            3: p_3;
            4: p_4;
            5: p_5;
            default: accept;
        }
    }
    state p_0 {
        hdr2.h1.f = 100;
        hdr2.h1.setValid();
        p.apply(packet, hdr, hdr2);
        transition accept;
    }
    state p_1 {
        hdr2.h1.f = 101;
        hdr2.h1.setValid();
        p.apply(packet, hdr, hdr2);
        transition select(hdr.h1.f) {
            10: parse_h3;
            default: reject;
        }
    }
    state p_2 {
        hdr2.h1.f = 102;
        hdr2.h1.setValid();
        p.apply(packet, hdr, hdr2);
        packet.extract(hdr.h4);
        transition accept;
    }
    state p_3 {
        hdr2.h1.f = 103;
        hdr2.h1.setValid();
        p.apply(packet, hdr, hdr2);
        transition select(hdr.h1.f) {
            10: parse_h3;
            default: reject;
        }
    }
    state p_4 {
        hdr2.h1.f = 104;
        hdr2.h1.setValid();
        p.apply(packet, hdr, hdr2);
        transition accept;
    }
    state p_5 {
        hdr2.h1.f = 105;
        hdr2.h1.setValid();
        p.apply(packet, hdr, hdr2);
        transition select(hdr.h1.f) {
            11: parse_h3;
            default: reject;
        }
    }
    state parse_h3 {
        packet.extract(hdr.h3);
        transition accept;
    }
}

control ingress(inout headers hdr, inout metadata meta, inout standard_metadata_t standard_metadata) {
    apply {
        if (hdr.h4.isValid()) {
            standard_metadata.egress_port = 4;
        } else if (hdr.h3.isValid()) {
            standard_metadata.egress_port = 3;
        } else if (hdr.h2.isValid()) {
            standard_metadata.egress_port = 2;
        } else {
            standard_metadata.egress_port = 10;
        }
    }
}

control egress(inout headers hdr, inout metadata meta, inout standard_metadata_t standard_metadata) {
    apply {
    }
}

control DeparserImpl(packet_out packet, in headers hdr) {
    apply {
        packet.emit(hdr);
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

V1Switch(ParserImpl(), verifyChecksum(), ingress(), egress(), computeChecksum(), DeparserImpl()) main;

