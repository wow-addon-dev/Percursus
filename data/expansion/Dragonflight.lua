local _, SRT = ...

if SRT.RACE_DATA == nil then
    SRT.RACE_DATA = {}
end

local raceDataTable = SRT.RACE_DATA

-- Dragonflight
-- The Waking Shores Z1 (Die Küste des Erwachens)
-- Ruby Lifeshrine Loop R1 (Rubinlebensschrein-Schleife) - R-11.0.5
raceDataTable[190123] = {
    100101, 2022, {
        NORMAL            = {66679, 2042, 373495, 53, 56},
        ADVANCED          = {66692, 2044, 373578, 52, 57},
        REVERSE           = {72052, 2154, 392228, 50, 55},
        CHALLENGE         = {75776, 2421, 409713, 54, 57},
        CHALLENGE_REVERSE = {75777, 2422, 409738, 57, 60},
        STORM_GRYPHON     = {77777, 2664, 420742, 65, 70} -- !!!
    }
}
-- Wild Preserve Slalom R2 (Wildreservat-Slalom) - R-11.0.5
raceDataTable[190473] = {
    100102, 2022, {
        NORMAL            = {66721, 2048, 374088, 42, 45},
        ADVANCED          = {66722, 2049, 374091, 40, 45},
        REVERSE           = {72705, 2176, 396710, 41, 46},
        CHALLENGE         = {75778, 2423, 409758, 48, 51},
        CHALLENGE_REVERSE = {75779, 2424, 409759, 49, 52}
    }
}
-- Emberflow Flight R3 (Glutstrom-Flug) - R-11.0.5
raceDataTable[190519] = {
    100103, 2022, {
        NORMAL            = {66727, 2052, 374182, 50, 53},
        ADVANCED          = {66728, 2053, 374183, 44, 49},
        REVERSE           = {72707, 2177, 396714, 45, 50},
        CHALLENGE         = {75780, 2425, 409760, 50, 53},
        CHALLENGE_REVERSE = {75781, 2426, 409761, 51, 54}
    }
}
-- Apex Canopy River Run R4 (Flusslauf des Hohen Blätterdachs) - R-11.0.7
raceDataTable[190551] = {
    100104, 2022, {
        NORMAL            = {66732, 2054, 374244, 52, 55},
        ADVANCED          = {66733, 2055, 374246, 45, 50},
        REVERSE           = {72734, 2178, 396934, 48, 53},
        CHALLENGE         = {75782, 2427, 409762, 53, 56},
        CHALLENGE_REVERSE = {75783, 2428, 409763, 53, 56}
    }
}
-- Uktulut Coaster R5 (Uktuluter Küstenachter) - R-11.0.7
raceDataTable[190667] = {
    100105, 2022, {
        NORMAL            = {66777, 2056, 374412, 45, 48},
        ADVANCED          = {66778, 2057, 374414, 40, 45},
        REVERSE           = {72739, 2179, 396943, 43, 48},
        CHALLENGE         = {75785, 2429, 409766, 46, 49},
        CHALLENGE_REVERSE = {75786, 2430, 409768, 48, 51}
    }
}
-- Wingrest Roundabout R6 (Schwingenrastkreisel) - R-11.0.5
raceDataTable[190753] = {
    100106, 2022, {
        NORMAL            = {66786, 2058, 374592, 53, 56},
        ADVANCED          = {66787, 2059, 374593, 53, 58},
        REVERSE           = {72740, 2180, 396960, 56, 61},
        CHALLENGE         = {75787, 2431, 409774, 60, 63},
        CHALLENGE_REVERSE = {75788, 2432, 409775, 60, 63}
    }
}
-- Flashfrost Flyover R7 (Blitzfrost-Überflug) - R-11.0.5
raceDataTable[190326] = {
    100107, 2022, {
        NORMAL            = {66710, 2046, 373851, 63, 66},
        ADVANCED          = {66712, 2047, 373857, 61, 66},
        REVERSE           = {72700, 2181, 396688, 60, 65},
        CHALLENGE         = {75789, 2433, 409778, 64, 67},
        CHALLENGE_REVERSE = {75790, 2434, 409780, 69, 74}
    }
}
-- Wild Preserve Circuit R8 (Wildreservat-Parcours) - R-11.0.7
raceDataTable[190503] = {
    100108, 2022, {
        NORMAL            = {66725, 2050, 374143, 40, 43},
        ADVANCED          = {66726, 2051, 374144, 38, 43},
        REVERSE           = {72706, 2182, 396712, 41, 46},
        CHALLENGE         = {75791, 2435, 409782, 43, 46},
        CHALLENGE_REVERSE = {75792, 2436, 409783, 44, 47}
    }
}

-- Ohn'ahran Plains Z2 (Ebenen von Ohn'ahra)
-- Sundapple Copse Circuit R1 (Sonnentüpfelhainstrecke)
raceDataTable[190928] = {
    100201, 2023, {
        NORMAL            = {66835, 2060, 374825, 49, 52},
        ADVANCED          = {66836, 2061, 375236, 41, 46},
        REVERSE           = {72801, 2183, 397175, 45, 50},
        CHALLENGE         = {75793, 2437, 409786, 51, 54},
        CHALLENGE_REVERSE = {75794, 2439, 409787, 50, 53}
    }
}
-- Fen Flythrough R2 (Moor-Durchflug) - R-11.0.5
raceDataTable[191121] = {
    100202, 2023, {
        NORMAL            = {66877, 2062, 375261, 48, 51},
        ADVANCED          = {66878, 2063, 375262, 41, 46},
        REVERSE           = {72802, 2184, 397179, 47, 52},
        CHALLENGE         = {75795, 2440, 409791, 50, 53},
        CHALLENGE_REVERSE = {75796, 2441, 409792, 50, 53},
        STORM_GRYPHON     = {77785, 2665, 420965, 82, 87} -- !!!
    }
}
-- Ravine River Run R3 (Schluchtflusslauf)
raceDataTable[191165] = {
    100203, 2023, {
        NORMAL            = {66880, 2064, 375356, 49, 52},
        ADVANCED          = {66681, 2065, 375358, 47, 52},
        REVERSE           = {72803, 2185, 397182, 46, 51},
        CHALLENGE         = {75797, 2442, 409793, 50, 53},
        CHALLENGE_REVERSE = {75798, 2443, 409794, 51, 54}
    }
}
-- Emerald Garden Ascent R4 (Smaragdgärtenaufstieg)
raceDataTable[191247] = {
    100204, 2023, {
        NORMAL            = {66885, 2066, 375477, 63, 66},
        ADVANCED          = {66886, 2067, 375479, 55, 60},
        REVERSE           = {72805, 2186, 397187, 57, 62},
        CHALLENGE         = {75799, 2444, 409796, 66, 69},
        CHALLENGE_REVERSE = {75800, 2445, 409797, 66, 69}
    }
}
-- Maruukai Dash R5 (Maruukaispurt) - R-11.0.5
raceDataTable[191422] = {
    100205, 2023, {
        NORMAL            = {66921, 2069, 375810, 25, 28},
        CHALLENGE         = {75801, 2446, 409799, 24, 27}
    }
}
-- Mirror of the Sky Dash R6 (Spurt zum Spiegel des Himmels) - R-11.0.5
raceDataTable[191511] = {
    100206, 2023, {
        NORMAL            = {66933, 2070, 376062, 26, 29},
        CHALLENGE         = {75802, 2447, 409800, 27, 30}
    }
}
-- River Rapids Route R7 (Stromschnellenstrecke)
raceDataTable[196092] = {
    100207, 2023, {
        NORMAL            = {70710, 2119, 387548, 48, 51},
        ADVANCED          = {70711, 2120, 387563, 43, 48},
        REVERSE           = {72807, 2187, 397189, 44, 49},
        CHALLENGE         = {75803, 2448, 409801, 52, 55},
        CHALLENGE_REVERSE = {75804, 2449, 409802, 52, 55}
    }
}

-- Azure Span Z3 (Das Azurblaue Gebirge)
-- Azure Span Sprint R1 (Sprint des Azurblauen Gebirges)
raceDataTable[191572] = {
    100301, 2024, {
        NORMAL            = {66946, 2074, 000000, 63, 66},
        ADVANCED          = {66947, 2075, 000000, 58, 63},
        REVERSE           = {72796, 2188, 000000, 60, 65},
        CHALLENGE         = {75805, 2450, 000000, 67, 70},
        CHALLENGE_REVERSE = {75806, 2451, 000000, 69, 72}
    }
}
-- Azure Span Slalom R2 (Slalom des Azurblauen Gebirges)
raceDataTable[191947] = {
    100302, 2024, {
        NORMAL            = {67002, 2076, 376805, 58, 61},
        ADVANCED          = {67003, 2077, 376817, 56, 61},
        REVERSE           = {72799, 2189, 397155, 53, 58},
        CHALLENGE         = {75807, 2452, 409807, 55, 58},
        CHALLENGE_REVERSE = {75808, 2453, 409808, 55, 58}
    }
}
-- Vakthros Ascent R3 (Vakthrosaufstieg) - R-11.0.5
raceDataTable[192115] = {
    100303, 2024, {
        NORMAL            = {67031, 2078, 000000, 58, 61},
        ADVANCED          = {67032, 2079, 000000, 56, 61},
        REVERSE           = {72794, 2190, 000000, 56, 61},
        CHALLENGE         = {75809, 2454, 000000, 63, 66},
        CHALLENGE_REVERSE = {75810, 2455, 000000, 64, 67},
        STORM_GRYPHON     = {77786, 2666, 000000, 120, 125} -- !!!
    }
}
-- Iskaara Tour R4 (Iskaara-Tour)
raceDataTable[192886] = {
    100304, 2024, {
        NORMAL            = {67296, 2083, 000000, 75, 78},
        ADVANCED          = {67297, 2084, 000000, 70, 75},
        REVERSE           = {72800, 2191, 000000, 67, 72},
        CHALLENGE         = {75811, 2456, 000000, 78, 81},
        CHALLENGE_REVERSE = {75812, 2457, 000000, 79, 82}
    }
}
-- Frostland Flyover R5 (Frostland-Überflug)
raceDataTable[192945] = {
    100305, 2024, {
        NORMAL            = {67565, 2085, 000000, 76, 79},
        ADVANCED          = {67566, 2086, 000000, 72, 77},
        REVERSE           = {72795, 2192, 000000, 69, 74},
        CHALLENGE         = {75813, 2458, 000000, 85, 88},
        CHALLENGE_REVERSE = {75815, 2459, 000000, 83, 86}
    }
}
-- Archive Ambit R6 (Archivring)
raceDataTable[193027] = {
    100306, 2024, {
        NORMAL            = {67741, 2089, 000000, 91, 94},
        ADVANCED          = {67742, 2090, 000000, 81, 86},
        REVERSE           = {72797, 2193, 000000, 76, 81},
        CHALLENGE         = {75816, 2460, 000000, 90, 93},
        CHALLENGE_REVERSE = {75817, 2461, 000000, 92, 95}
    }
}

-- Thaldraszus Z4 (Thaldraszus)
-- Flowing Forest Flight R1 (Flug des Wallenden Walds)
raceDataTable[192555] = {
    100401, 2025, {
        NORMAL            = {67095, 2080, 000000, 49, 52},
        ADVANCED          = {67096, 2081, 000000, 40, 45},
        REVERSE           = {72793, 2194, 000000, 41, 46},
        CHALLENGE         = {75820, 2462, 000000, 47, 50},
        CHALLENGE_REVERSE = {75821, 2463, 000000, 46, 49}
    }
}
-- Tyrhold Trial R2 (Tyrhold-Tournee) - R-11.0.5
raceDataTable[193651] = {
    100402, 2025, {
        NORMAL            = {69957, 2092, 000000, 81, 84},
        ADVANCED          = {69958, 2093, 000000, 75, 80},
        REVERSE           = {72792, 2195, 000000, 59, 64},
        CHALLENGE         = {75822, 2464, 000000, 58, 61},
        CHALLENGE_REVERSE = {75823, 2465, 000000, 63, 66},
        STORM_GRYPHON     = {77784, 2667, 000000, 80, 85} -- !!!
    }
}
-- Cliffside Circuit R3 (Klippenrundstrecke) - R-11.0.5
raceDataTable[193911] = {
    100403, 2025, {
        NORMAL            = {70051, 2096, 382632, 69, 72},
        ADVANCED          = {70052, 2097, 382652, 66, 71},
        REVERSE           = {72760, 2196, 396997, 69, 74},
        CHALLENGE         = {75824, 2466, 409861, 81, 84},
        CHALLENGE_REVERSE = {75825, 2467, 409862, 80, 83}
    }
}
-- Academy Ascent R4 (Akademieaufstieg)
raceDataTable[193951] = {
    100404, 2025, {
        NORMAL            = {70059, 2098, 000000, 54, 57},
        ADVANCED          = {70060, 2099, 000000, 52, 57},
        REVERSE           = {72754, 2197, 000000, 53, 58},
        CHALLENGE         = {75826, 2468, 000000, 65, 68},
        CHALLENGE_REVERSE = {75827, 2469, 000000, 65, 68}
    }
}
-- Garden Gallivant R5 (Gartenpromenade)
raceDataTable[194348] = {
    100405, 2025, {
        NORMAL            = {70157, 2101, 000000, 61, 64},
        ADVANCED          = {70158, 2102, 000000, 54, 59},
        REVERSE           = {72769, 2198, 000000, 57, 62},
        CHALLENGE         = {75784, 2470, 000000, 60, 63},
        CHALLENGE_REVERSE = {75828, 2471, 000000, 64, 67}
    }
}
-- Caverns Criss-Cross R6 (Kreuz und quer durch die Höhlen)
raceDataTable[194372] = {
    100406, 2025, {
        NORMAL            = {70161, 2103, 000000, 50, 53},
        ADVANCED          = {70163, 2104, 000000, 45, 50},
        REVERSE           = {72750, 2199, 000000, 47, 52},
        CHALLENGE         = {75829, 2472, 000000, 56, 59},
        CHALLENGE_REVERSE = {75830, 2473, 000000, 54, 57}
    }
}

-- Forbidden Reach Z5 (Die Verbotene Insel)
-- Stormsunder Crater Circuit R1 (Sturmrisskrater-Rundflug) - R-11.0.5
raceDataTable[200183] = {
    100501, 2151, {
        NORMAL            = {73017, 2201, 000000, 43, 46},
        ADVANCED          = {73018, 2207, 000000, 42, 47},
        REVERSE           = {73019, 2213, 000000, 42, 47},
        CHALLENGE         = {75954, 2474, 000000, 45, 48},
        CHALLENGE_REVERSE = {75955, 2475, 000000, 44, 47},
        STORM_GRYPHON     = {77787, 2668, 000000, 92, 97} -- !!!
    }
}
-- Morqut Ascent R2 (Morqutaufstieg)
raceDataTable[200212] = {
    100502, 2151, {
        NORMAL            = {73020, 2202, 000000, 52, 55},
        ADVANCED          = {73023, 2208, 000000, 49, 54},
        REVERSE           = {73024, 2214, 000000, 52, 57},
        CHALLENGE         = {75956, 2476, 000000, 50, 53},
        CHALLENGE_REVERSE = {75957, 2477, 000000, 50, 53}
    }
}
-- Aerie Chasm Cruise R3 (Nistklufttour)
raceDataTable[200236] = {
    100503, 2151, {
        NORMAL            = {73025, 2203, 000000, 53, 56},
        ADVANCED          = {73027, 2209, 000000, 50, 55},
        REVERSE           = {73028, 2215, 000000, 50, 55},
        CHALLENGE         = {75958, 2478, 000000, 53, 56},
        CHALLENGE_REVERSE = {75959, 2479, 000000, 52, 55}
    }
}
-- Southern Reach Route R4 (Südinselroute)
raceDataTable[200247] = {
    100504, 2151, {
        NORMAL            = {73029, 2204, 000000, 70, 73},
        ADVANCED          = {73030, 2210, 000000, 68, 73},
        REVERSE           = {73032, 2216, 000000, 63, 68},
        CHALLENGE         = {75960, 2480, 000000, 70, 63},
        CHALLENGE_REVERSE = {75961, 2481, 000000, 68, 71}
    }
}
-- Caldera Coaster R5 (Kalderakurven)
raceDataTable[200316] = {
    100505, 2151, {
        NORMAL            = {73033, 2205, 000000, 58, 61},
        ADVANCED          = {73034, 2211, 000000, 52, 57},
        REVERSE           = {73052, 2217, 000000, 49, 54},
        CHALLENGE         = {75962, 2482, 000000, 55, 58},
        CHALLENGE_REVERSE = {75963, 2483, 000000, 53, 56}
    }
}
-- Forbidden Reach Rush R6 (Verbotene-Insel-Eile)
raceDataTable[200417] = {
    100506, 2151, {
        NORMAL            = {73061, 2206, 000000, 59, 62},
        ADVANCED          = {73062, 2212, 000000, 56, 61},
        REVERSE           = {73065, 2218, 000000, 57, 62}, -- xxx
        CHALLENGE         = {75964, 2484, 000000, 60, 63},
        CHALLENGE_REVERSE = {75965, 2485, 000000, 60, 63}
    }
}

-- Zaralek Cavern Z6 (Zaralekhöhle)
-- Crystal Circuit R1 (Kristallkreisel) - R-11.1.0
raceDataTable[202524] = {
    100601, 2133, {
        NORMAL            = {74839, 2246, 403192, 63, 68},
        ADVANCED          = {74842, 2252, 403205, 55, 60},
        REVERSE           = {74882, 2258, 403502, 53, 58},
        CHALLENGE         = {75972, 2486, 410853, 57, 60},
        CHALLENGE_REVERSE = {75973, 2487, 410854, 58, 61},
        STORM_GRYPHON     = {77793, 2669, 421060, 95, 100} -- !!!
    }
}
-- Caldera Cruise R2 (Kalderarundflug) - R-11.1.0
raceDataTable[202676] = {
    100602, 2133, {
        NORMAL            = {74889, 2247, 403533, 75, 80},
        ADVANCED          = {74899, 2253, 403679, 68, 73},
        REVERSE           = {74925, 2259, 403729, 68, 73},
        CHALLENGE         = {75974, 2488, 410855, 72, 75},
        CHALLENGE_REVERSE = {75975, 2489, 410856, 72, 75}
    }
}
-- Brimstone Scramble R3 (Schwefelhast) - R-11.1.0
raceDataTable[202749] = {
    100603, 2133, {
        NORMAL            = {74939, 2248, 403746, 69, 72},
        ADVANCED          = {74943, 2254, 403784, 64, 69},
        REVERSE           = {74944, 2260, 403795, 64, 69},
        CHALLENGE         = {75976, 2490, 410857, 69, 72},
        CHALLENGE_REVERSE = {75977, 2491, 410858, 71, 74}
    }
}
-- Shimmering Slalom R4 (Schimmerslalom) - R-11.1.0
raceDataTable[202772] = {
    100604, 2133, {
        NORMAL            = {74951, 2249, 403830, 75, 80},
        ADVANCED          = {74954, 2255, 403884, 70, 75},
        REVERSE           = {74956, 2261, 403898, 70, 75},
        CHALLENGE         = {75978, 2492, 410859, 79, 82},
        CHALLENGE_REVERSE = {75979, 2493, 410860, 75, 78}
    }
}
-- Loamm Roamm R5 (Loamm-Jagd) - R-11.1.0
raceDataTable[202795] = {
    100605, 2133, {
        NORMAL            = {74972, 2250, 403934, 55, 60},
        ADVANCED          = {74975, 2256, 403992, 50, 55},
        REVERSE           = {74977, 2262, 404002, 48, 53},
        CHALLENGE         = {75980, 2494, 410861, 53, 56},
        CHALLENGE_REVERSE = {75981, 2495, 410862, 52, 55}
    }
}
-- Sulfur Sprint R6 (Schwefelsprint) - R-11.1.0
raceDataTable[202973] = {
    100606, 2133, {
        NORMAL            = {75035, 2251, 404558, 64, 67},
        ADVANCED          = {75042, 2257, 404640, 58, 63},
        REVERSE           = {75043, 2263, 404644, 57, 62},
        CHALLENGE         = {75982, 2496, 410863, 67, 70},
        CHALLENGE_REVERSE = {75983, 2497, 410864, 65, 68}
    }
}

-- Emerald Dream Z7 (Der Smaragdgrüne Traum)
-- Ysera Invitational R1 (Ysera-Einladungsturnier)
raceDataTable[210023] = {
    100701, 2200, {
        NORMAL            = {77841, 2676, 421437, 98, 103},
        ADVANCED          = {77842, 2682, 421438, 87, 90},
        REVERSE           = {77843, 2688, 421439, 87, 90},
        CHALLENGE         = {77844, 2694, 421451, 95, 98}, -- xxx
        CHALLENGE_REVERSE = {77845, 2695, 421452, 97, 100} -- xxx
    }
}
-- Smoldering Sprint R2 (Qualmende Querele) - R-11.1.0
raceDataTable[210310] = {
    100702, 2200, {
        NORMAL            = {77983, 2677, 422015, 80, 85},
        ADVANCED          = {77984, 2683, 422017, 73, 76},
        REVERSE           = {77985, 2689, 422018, 73, 76},
        CHALLENGE         = {77986, 2696, 422020, 79, 82},
        CHALLENGE_REVERSE = {77987, 2697, 422021, 80, 83}
    }
}
-- Viridescent Venture R3 (Grünliche Gaudi)
raceDataTable[210412] = {
    100703, 2200, {
        NORMAL            = {77996, 2678, 422174, 78, 83},
        ADVANCED          = {77997, 2684, 422175, 64, 67},
        REVERSE           = {77998, 2690, 422176, 64, 67},
        CHALLENGE         = {77999, 2698, 422178, 73, 76},
        CHALLENGE_REVERSE = {78000, 2699, 422179, 73, 76}
    }
}
-- Shoreline Switchback R4 (Uferumkehr) - R-11.1.0
raceDataTable[210497] = {
    100704, 2200, {
        NORMAL            = {78016, 2679, 422400, 73, 78},
        ADVANCED          = {78017, 2685, 422401, 63, 66},
        REVERSE           = {78018, 2691, 422402, 62, 65},
        CHALLENGE         = {78019, 2700, 422403, 70, 73},
        CHALLENGE_REVERSE = {78020, 2701, 422404, 70, 73}
    }
}
-- Canopy Concours R5 (Baumkronenbagatelle)
raceDataTable[210784] = {
    100705, 2200, {
        NORMAL            = {78102, 2680, 423378, 105, 110}, -- xxx
        ADVANCED          = {78103, 2686, 423380, 93, 96}, -- xxx
        REVERSE           = {78104, 2692, 423381, 96, 99},
        CHALLENGE         = {78105, 2702, 423382, 105, 108},
        CHALLENGE_REVERSE = {78106, 2703, 423383, 105, 108}
    }
}
-- Emerald Amble R6 (Smaragdspaziergang)
raceDataTable[210861] = {
    100706, 2200, {
        NORMAL            = {78115, 2681, 423562, 84, 89},
        ADVANCED          = {78116, 2687, 423568, 70, 73},
        REVERSE           = {78117, 2693, 423577, 70, 73},
        CHALLENGE         = {78118, 2704, 423579, 73, 76},
        CHALLENGE_REVERSE = {78119, 2705, 423580, 73, 76}
    }
}