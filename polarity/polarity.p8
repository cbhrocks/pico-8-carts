pico-8 cartridge // http://www.pico-8.com
version 42
__lua__
#include main.lua
#include entity.lua
#include entities/projectile.lua
#include entities/ship.lua
#include gun.lua
#include utils/array.lua
#include utils/collision.lua
#include utils/dump.lua
#include utils/queue.lua
#include utils/transforms.lua

__gfx__
00066000004440000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00555500044544440000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
05dddd50045445f40000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
65dccd56442442540000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
65dccd56045544540000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
05dddd50454442440000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00555500045554400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00066000004404000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00011c00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0511cc70000c70000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00011c00000c70000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__label__
88888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888
888888888888888888888888888888888888888888888888888888888888888888888888888888888882282288882288228882228228888888ff888888228888
888882888888888ff8ff8ff88888888888888888888888888888888888888888888888888888888888228882288822222288822282288888ff8f888888222888
88888288828888888888888888888888888888888888888888888888888888888888888888888888882288822888282282888222888888ff888f888888288888
888882888282888ff8ff8ff888888888888888888888888888888888888888888888888888888888882288822888222222888888222888ff888f888822288888
8888828282828888888888888888888888888888888888888888888888888888888888888888888888228882288882222888822822288888ff8f888222288888
888882828282888ff8ff8ff8888888888888888888888888888888888888888888888888888888888882282288888288288882282228888888ff888222888888
88888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888
55555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555
55555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555
55555555555555555555555555555555555555555555555550000000000005555555555555555555555555555550000000000005500000000000055555555555
555555e555566656665555e555555555555566566656655550660066600005555555555556555566556656665550666066600005506660666000055555555555
55555ee555565656565555ee5555555555565556565656555006006060000555555555555655565656565656555060606060000550606060600005555d555555
5555eee555565656565555eee55555555556665666565655500600666000055555555555565556565656566655506060606000055060606060000555d5d55555
55555ee555565656565555ee55555555555556565556565550060060600005555555555556555656565656555550606060600005506060606000055d555d5d55
555555e555566656665555e55555555555566556555666555066606660000555555555555666566556655655555066606660000550666066600005555555d555
55555555555555555555555555555555555555555555555550000000000005555555555555555555555555555550000000000005500000000000055555555555
55555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555
55555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555
55555555555555555577777566666566666566666555556666666659999999956666666656666666656666666656666666656666666656666666655555555555
55555665566566655575577565556565556565656555556667766659999979956666667756677777656666777656676666656676667656667766655555dd5555
5555656565555655557757756665656665656565655555667667665999779795666677675667666765666676765676766665767676765667777665555d55d555
5555656565555655557757756555656655656555655555676666765977999795667766675667666765666676765766676765777777775677667765555d55d555
55556565655556555577577565666566656566656555557666666757999999757766666757776667757777767757666776756767676757766667755555dd5555
55556655566556555575557565556565556566656555556666666659999999956666666656666666656666666656666666656766666756666666655555555555
55555555555555555577777566666566666566666555555555555555555555555555555555555555555555555555555555555555555555555555555555555555
55555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555
55555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555
555555555555555555005005005005005dd500566555555555555555555555555555555555555555555555555555555555555555555555555555555555555555
555565655665655555005005005005005dd56656655555777777775dddddddd5dddddddd5dddddddd5dddddddd5dddddddd5dddddddd5dddddddd55555555555
5555656565656555550050050050050057756656655555777777775d55ddddd5dd5dd5dd5ddd55ddd5ddddd5dd5dd5ddddd5dddddddd5dddddddd55555555555
5555656565656555550050050050056657756656655555777777775d555dddd5d55d55dd5dddddddd5dddd55dd5dd55dddd55d5d5d5d5d55dd55d55555555555
5555666565656555550050050056656657756656655555777557775dddd555d5dd55d55d5d5d55d5d5ddd555dd5dd555ddd55d5d5d5d5d55dd55d55555555555
5555565566556665550050056656656657756656655555777777775ddddd55d5dd5dd5dd5d5d55d5d5dd5555dd5dd5555dd5dddddddd5dddddddd55555555555
5555555555555555550056656656656657756656655555777777775dddddddd5dddddddd5dddddddd5dddddddd5dddddddd5dddddddd5dddddddd55555555555
55555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555
55555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555
55555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555
55555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555
55500000000000000000000000000000550000000000000000000000000000055000000000000000000000000000005500000000000000000000000000000555
55500000000000000000000000000000550000000000000000000000000000055000000000000000000000000000005500000000000000000000000000000555
55500770000066600eee00c0c00ddd005500770707066600eee00c0c00ddd005507770000066600eee00c0c00ddd005500770000066600eee00c0c00ddd00555
55507000000060600e0e00c0c00d00005507000777060600e0e00c0c00d00005507000000000600e0e00c0c00d00005507000000060000e0e00c0c00d0000555
55507000000060600e0e00ccc00ddd005507000707060600e0e00ccc00ddd005507700000006600e0e00ccc00ddd005507000000066600e0e00ccc00ddd00555
55507000000060600e0e0000c0000d005507070777060600e0e0000c0000d005507000000000600e0e0000c0000d005507000000000600e0e0000c0000d00555
55500770000066600eee0000c00ddd005507770707066600eee0000c00ddd005507000000066600eee0000c00ddd005500770000066600eee0000c00ddd00555
55500000000000000000000000000000550000000000000000000000000000055000000000000000000000000000005500000000000000000000000000000555
55500000000000000000000000000000550000000000000000000000000000055000000000000000000000000000005500000000000000000000000000000555
55500000000000000000000000000000550000000000000000000000000000055000000000000000000001000000005500000000000000000000000000000555
55500770707066600eee00c0c00ddd005507770000066600eee00c0c00ddd005500770000066600eee0017100ddd005507700707066600eee00c0c00ddd00555
55507000777060600e0e00c0c00d00005507070000060600e0e00c0c00d00005507000000000600e0e0017710d00005507070777060000e0e00c0c00d0000555
55507000707060600e0e00ccc00ddd005507770000060600e0e00ccc00ddd005507000000006600e0e0017771ddd005507070707066600e0e00ccc00ddd00555
55507000777060600e0e0000c0000d005507070000060600e0e0000c0000d005507070000000600e0e001777710d005507070777000600e0e0000c0000d00555
55500770707066600eee0000c00ddd005507070000066600eee0000c00ddd005507770000066600eee0017711ddd005507770707066600eee0000c00ddd00555
55500000000000000000000000000000550000000000000000000000000000055000000000000000000001171000005500000000000000000000000000000555
55500000000000000000000000000000550000000000000000000000000000055000000000000000000000000000005500000000000000000000000000000555
55500000000000000000000000000000550000000000000000000000000000055000000000000000000000000000005500000000000000000000000000000555
55507700000066600eee00c0c00ddd005507770707066600eee00c0c00ddd005507770707066600eee00c0c00ddd005507700707066600eee00c0c00ddd00555
55507070000060600e0e00c0c00d00005507070777060600e0e00c0c00d00005507070777000600e0e00c0c00d00005507070777060000e0e00c0c00d0000555
55507070000060600e0e00ccc00ddd005507770707060600e0e00ccc00ddd005507770707006600e0e00ccc00ddd005507070707066600e0e00ccc00ddd00555
55507070000060600e0e0000c0000d005507070777060600e0e0000c0000d005507070777000600e0e0000c0000d005507070777000600e0e0000c0000d00555
55507770000066600eee0000c00ddd005507070707066600eee0000c00ddd005507070707066600eee0000c00ddd005507770707066600eee0000c00ddd00555
55500000000000000000000000000000550000000000000000000000000000055000000000000000000000000000005500000000000000000000000000000555
55500000000000000000000000000000550000000000000000000000000000055000000000000000000000000000005500000000000000000000000000000555
55500000000000000000000000000000550000000000000000000000000000055000000000000000000000000000005500000000000000000000000000000555
55507700707066600eee00c0c00ddd005507770000066600eee00c0c00ddd005500770000060600eee00c0c00ddd005507700707066600eee00c0c00ddd00555
55507070777060600e0e00c0c00d00005507070000060600e0e00c0c00d00005507000000060600e0e00c0c00d00005507070777060000e0e00c0c00d0000555
55507070707060600e0e00ccc00ddd005507700000060600e0e00ccc00ddd005507000000066600e0e00ccc00ddd005507070707066600e0e00ccc00ddd00555
55507070777060600e0e0000c0000d005507070000060600e0e0000c0000d005507000000000600e0e0000c0000d005507070777000600e0e0000c0000d00555
55507770707066600eee0000c00ddd005507770000066600eee0000c00ddd005500770000000600eee0000c00ddd005507770707066600eee0000c00ddd00555
55500000000000000000000000000000550000000000000000000000000000055000000000000000000000000000005500000000000000000000000000000555
55500000000000000000000000000000550000000000000000000000000000055000000000000000000000000000005500000000000000000000000000000555
55500000000000000000000000000000550000000000000000000000000000055000000000000000000000000000005500000000000000000000000000000555
55507770000066600eee00c0c00ddd005500770000066000eee00c0c00ddd005507700707060600eee00c0c00ddd005507700707066600eee00c0c00ddd00555
55507000000060600e0e00c0c00d00005507000000006000e0e00c0c00d00005507070777060600e0e00c0c00d00005507070777060000e0e00c0c00d0000555
55507700000060600e0e00ccc00ddd005507000000006000e0e00ccc00ddd005507070707066600e0e00ccc00ddd005507070707066600e0e00ccc00ddd00555
55507000000060600e0e0000c0000d005507000000006000e0e0000c0000d005507070777000600e0e0000c0000d005507070777000600e0e0000c0000d00555
55507770000066600eee0000c00ddd005500770000066600eee0000c00ddd005507770707000600eee0000c00ddd005507770707066600eee0000c00ddd00555
55500000000000000000000000000000550000000000000000000000000000055000000000000000000000000000005500000000000000000000000000000555
55500000000000000000000000000000550000000000000000000000000000055000000000000000000000000000005500000000000000000000000000000555
55500000000000000000000000000000550000000000000000000000000000055000000000000000000000000000005500000000000000000000000000000555
55507770000066600eee00c0c00ddd005507700000066000eee00c0c00ddd005507770000060600eee00c0c00ddd005500770000066600eee00c0c00ddd00555
55507000000060600e0e00c0c00d00005507070000006000e0e00c0c00d00005507000000060600e0e00c0c00d00005507000000000600e0e00c0c00d0000555
55507700000060600e0e00ccc00ddd005507070000006000e0e00ccc00ddd005507700000066600e0e00ccc00ddd005507000000066600e0e00ccc00ddd00555
55507000000060600e0e0000c0000d005507070000006000e0e0000c0000d005507000000000600e0e0000c0000d005507000000060000e0e0000c0000d00555
55507000000066600eee0000c00ddd005507770000066600eee0000c00ddd005507000000000600eee0000c00ddd005500770000066600eee0000c00ddd00555
55500000000000000000000000000000550000000000000000000000000000055000000000000000000000000000005500000000000000000000000000000555
55500000000000000000000000000000550000000000000000000000000000055000000000000000000000000000005500000000000000000000000000000555
55500000000000000000000000000000550000000000000000000000000000055000000000000000000000000000005500000000000000000000000000000555
55507770707066600eee00c0c00ddd005500770707066000eee00c0c00ddd005500770000060600eee00c0c00ddd005500770000066600eee00c0c00ddd00555
55507000777060600e0e00c0c00d00005507000777006000e0e00c0c00d00005507000000060600e0e00c0c00d00005507000000000600e0e00c0c00d0000555
55507700707060600e0e00ccc00ddd005507000707006000e0e00ccc00ddd005507000000066600e0e00ccc00ddd005507000000066600e0e00ccc00ddd00555
55507000777060600e0e0000c0000d005507000777006000e0e0000c0000d005507070000000600e0e0000c0000d005507000000060000e0e0000c0000d00555
55507000707066600eee0000c00ddd005500770707066600eee0000c00ddd005507770000000600eee0000c00ddd005500770000066600eee0000c00ddd00555
55500000000000000000000000000000550000000000000000000000000000055000000000000000000000000000005500000000000000000000000000000555
55500000000000000000000000000000550000000000000000000000000000055000000000000000000000000000005500000000000000000000000000000555
55500000000000000000000000000000550aaaaaaa11111111111111111111055000000000000000000000000000005500000000000000000000000000000555
55500770000066600eee00c0c00ddd0055077aa7a7166611eee11c1c11ddd105507770707060600eee00c0c00ddd005500000000000000000000000000000555
55507000000060600e0e00c0c00d00005507a7a777111611e1e11c1c11d11105507070777060600e0e00c0c00d00005500000000000000000000000000000555
55507000000060600e0e00ccc00ddd005507a7a7a7116611e1e11ccc11ddd105507770707066600e0e00ccc00ddd005500000000000000000000000000000555
55507070000060600e0e0000c0000d005507a7a777111611e1e1111c1111d105507070777000600e0e0000c0000d005500000000000000000000000000000555
55507770000066600eee0000c00ddd00550777a7a7166611eee1111c11ddd105507070707000600eee0000c00ddd005500100010001000010000100001000555
55500000000000000000000000000000550aaaaaaa11111111111111111111055000000000000000000000000000005500000000000000000000000000000555
55500000000000000000000000000000550000000000000000000000000000055000000000000000000000000000005500000000000000000000000000000555
55555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555
55555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555
55555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555
5555dd555dd5ddd5ddd555555ddd5d5d5ddd5ddd555555dd55ddd5ddd5d5d5dd55ddd5555ddd5ddd5d5d5ddd5ddd5ddd5555dd55ddd5ddd5ddd5ddd5dd555555
5555d5d5d5d55d5555d555555d5d5d5d555d555d555555d5d5d5555d55d5d5d5d5d555555d5d5d555d5d5d555d5d5d5d5555d5d5d5d5ddd5d5d5d555d5d55555
5555d5d5d5d55d555d5555555dd55d5d55d555d5555555d5d5dd555d55d5d5d5d5dd55555dd55dd55d5d5dd55dd55dd55555d5d5ddd5d5d5ddd5dd55d5d55555
5555d5d5d5d55d55d55555555d5d5d5d5d555d55555555d5d5d5555d55d5d5d5d5d555555d5d5d555ddd5d555d5d5d5d5555d5d5d5d5d5d5d555d555d5d55555
5555d5d5dd55ddd5ddd555555ddd55dd5ddd5ddd555555ddd5ddd55d555dd5d5d5ddd5555d5d5ddd55d55ddd5d5d5ddd5555ddd5d5d5d5d5d555ddd5d5d55555
55555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555
55555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555
55551111111111111115555551111111111111115555551111111111111111111111155551111111111111111111111155551111111111111111111111155555
55551dddddd111111115555551dddddd111111115555551dddddd111111111111111155551dddddd111111111111111155551dddddd111111111111111155555
55551dddddd111111115555551dddddd111111115555551dddddd111111111111111155551dddddd111111111111111155551dddddd111111111111111155555
55551dddddd111111115555551dddddd111111115555551dddddd111111111111111155551dddddd111111111111111155551dddddd111111111111111155555
55551111111111111115555551111111111111115555551111111111111111111111155551111111111111111111111155551111111111111111111111155555
55555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555
55555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555
88888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888
88888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888
88888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888
88888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888
88888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888
88888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888
88888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888

__gff__
0102000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
310202031807318073180731807318073180731c0731c0731c0731c0731c0731c0731c0731c0731c0731c0731c0731c0731c0731c0731c0731c0731c0731c0731c0731c0731c0731c0731c0731c0731c0731c073
011200000400004000010000f6000c600040000c6000f6000c60004000276000f60013600040000c6000f6000c600040002b0000f6000c600040000c6000f6003a000040000c6000f6000c600040000f60000000
01120808101001010010100101000f1000f1000310003100101001010010100101000f1000f1000310003100101001010010100101000f1000f1000310003100101001010010100101000f1000f1000310003100
011200201010010100101001010010100101001010010100101001010010100101001010010100101001010011100111001110011100111001110011100111000f1000f1000f1000f1000f1000f1000f1000f100
011200201010010100101001010010100101001010010100101001010010100101001010010100101001010011100111001110011100111001110011100111000f1000f1000f1000f1000f1000f1000f1000f100
011200000210002100021000210002100041000410004100041000410002100021000210002100021000210002100021000410004100041000410003100031000310003100021000210002100021000210002100
0112000004000010000c6000c600040000c6000c6000c60004000276000c60013600040000c600240000c600040002b0000c6000c600040000c6000c6003a000040000c6001b0000c600040000c6000c6000c600
310200000000000000000000000000000000000400004000040000400004000040000400004000040000400004000040000400004000040000400004000040000400004000040000400004000040000400004000
0112000001400014001040000400124001340013400084001a400194000f400014000e400014000b400004000000000000004001740015400000001540000000000000c4000c40000000000000d4000d4000d400
01120000000001a4001a40010400004001a4001940019400084001a400194000f4000d4000e4000d4000b400004001c4001b4001a400154000c4000f4000e4000e4000d400000000d40000000014000140000000
01120000000450104502045030450404505045060450704508045090450a0450b0450c0450d0450e0450f045100451104512045130451404515045160451704518045190451a0451b0453f000180001800000000
011200000407304073040000407311675000000407304000000001167504073040001167504000040732450004073040730000004073116750400004073000000400011675040730400011675000000407304000
01120000021450214502145001450810002145021200214500145011220f1000a1450a125081400d1450d145061000a1450a1450810006145031450a1440a1450d1450a145061450000003155031400312003145
01120000021450212002145021200000007155021250214502122000000915507125021450212002142000000c15509125021450212002142091440c155071230914505123071350212502140021220214202000
011200201010010100101001010010100101001010010100101001010010100101001010010100101001010011100111001110011100111001110011100111000f1000f1000f100020450504507045090450c045
011200000215002145021450214502150041450414504150041450414502150021450214502145021500214502145021450415004155041550415503150031550314503140021450214502145021500215502155
0112000004053010000c6000c600040530c6000c6000c60004053276000c60013600040530c600240000c600040532b0030c6000c600040530c6000c6003a000040530c6001b0000c600040530c6000c6000c600
310200000007300073000730007300073000730407304073040730407304073040730407304073040730407304073040730407304073040730407304073040730407304073040730407304073040730407304073
0912002001420014201040000400124201342013400084001a420194200f400014200e400014200b400004001742015422000001542000000154200c422000000d4240d424000000000012400134001340000000
01120000000001a4101a42010400004001a4201942019400084001a420194200f4000d4200e4000d4200b400004001c4201b4201a420154000c4200f4200e4200e4000d420000000d42000000014200141000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0108000010134101431053410542000001d1001c1001a100101000010300103001030010300103001030010300103001030010300103001030010300103001030010300103001030010300103001030000000000
__music__
01 4b0c4344
03 0b0d4344
03 0b0c1248
01 0b0c0e48
01 0b0c0e12
02 04050409

