declare author "Andrey Ozornin";

import("stdfaust.lib");

kick_group(el) = hgroup("[0]kick", el);
kick_trigger = button("[0]gate");
kick_freq = vslider("[1]pitch[scale:log]", 55, 20, 200, 1);
kick_click = vslider("[2]click[scale:log]", 0.1, 0.005, 1, 0.005);
kick_attack = vslider("[3]attack[scale:log]", 0.1, 0.005, 0.4, 0.005);
kick_decay = vslider("[4]decay[scale:log]", 0.5, 0.01, 4, 0.01);
kick_drive = vslider("[5]drive", 3, 1, 10, 0.1);

kick_drum = kick_group(
    kick_trigger 
    : sy.kick(
        kick_freq,
        kick_click,
        kick_attack,
        kick_decay,
        kick_drive
    ) * kick_trigger
);

clap_group(el) = hgroup("[1]clap", el);
clap_trigger = button("[0]gate");
clap_freq = vslider("[1]pitch[scale:log]", 1760, 400, 3500, 1);
clap_attack = vslider("[2]attack[scale:log]", 0.01, 0.001, 0.2, 0.001);
clap_decay = vslider("[3]decay[scale:log]", 0.03, 0.001, 4, 0.001);
clap = clap_group(
    clap_trigger 
    : sy.clap(
        clap_freq,
        clap_attack,
        clap_decay
    ) * clap_trigger
);

hh_group(el) = hgroup("[2]hat", el);
hh_trigger = button("[0]gate");
hh_freq = vslider("[1]pitch[scale:log]", 1000, 317, 3170, 1);
hh_tone = vslider("[2]tone[scale:log]", 3000, 800, 18000, 1);
hh_attack = vslider("[3]attack[scale:log]", 0.01, 0.005, 0.2, 0.005);
hh_decay = vslider("[4]decay[scale:log]", 0.1, 0.005, 4, 0.005);
hh = hh_group(
    hh_trigger 
    : sy.hat(
        hh_freq,
        hh_tone,
        hh_attack,
        hh_decay
    ) * hh_trigger
);

process = kick_drum, clap, hh :> _ <: _,_;
