-- local constellations = {}

local base_modern_constellations_list = {
    -- ========================================================================
    -- FIRE + EARTH (15 constellations)
    -- ========================================================================
    {
        name = "Aries",
        abbr = 'Ari',
        elements = {'fire', 'earth'},
        symbolism = 'the ram',
        quadrant = 'NQ',
        main_stars = 4,
        bayer_stars = 66,
        bordering = {'Per', 'Tri', 'Psc', 'Cet', 'Tau'},
        ascii_art = "22*\\21*20---*21/\\22*"
    },
    {
        name = "Taurus",
        abbr = 'Tau',
        elements = {'fire', 'earth'},
        symbolism = 'the bull',
        quadrant = 'NQ',
        main_stars = 11,
        bayer_stars = 125,
        bordering = {'Per', 'Aur', 'Gem', 'Ori', 'Eri', 'Cet', 'Ari'},
        ascii_art = "16*\\17*18---*19*20*18/|18---*19*20*18|22*"
    },
    {
        name = "Leo",
        abbr = 'Leo',
        elements = {'fire', 'earth'},
        symbolism = 'the lion',
        quadrant = 'NQ',
        main_stars = 12,
        bayer_stars = 102,
        bordering = {'UMa', 'Lyn', 'Cnc', 'Hya', 'Sex', 'Crt', 'Crv', 'Vir', 'Com'},
        ascii_art = "20*21\\22*23---*24*23/22|22*21\\20*---*21/22|24*"
    },
    {
        name = "Sagittarius",
        abbr = 'Sgr',
        elements = {'fire', 'earth'},
        symbolism = 'the archer',
        quadrant = 'SQ',
        main_stars = 15,
        bayer_stars = 115,
        bordering = {'Oph', 'Sct', 'Aql', 'Mic', 'Tel', 'Cap', 'Sco', 'Lib'},
        ascii_art = "24*20---*24*20/24\\20*24/20\\24*"
    },
    {
        name = "Ara",
        abbr = 'Ara',
        elements = {'fire', 'earth'},
        symbolism = 'the altar',
        quadrant = 'SQ',
        main_stars = 7,
        bayer_stars = 42,
        bordering = {'Tel', 'Aps', 'Pav', 'Ind', 'Mic'},
        ascii_art = "18*---*19|18*19|20*21*"
    },
    {
        name = "Boötes",
        abbr = 'Boo',
        elements = {'fire', 'earth'},
        symbolism = 'the herdsman',
        quadrant = 'SQ',
        main_stars = 15,
        bayer_stars = 129,
        bordering = {'UMa', 'Com', 'Vir', 'Crv', 'Lib', 'Ser', 'Her', 'Dra', 'CVn'},
        ascii_art = "20*21\\22*23/|\\22*21|22*23/\\22*"
    },
    {
        name = "Centaurus",
        abbr = 'Cen',
        elements = {'fire', 'earth'},
        symbolism = 'the centaur',
        quadrant = 'SQ',
        main_stars = 28,
        bayer_stars = 168,
        bordering = {'Hya', 'Ant', 'Vel', 'Car', 'Mus', 'Cir', 'Lup', 'Lib'},
        ascii_art = "20*21\\22*---*23/\\22*23|24*25\\26*25/\\24*23|22*"
    },
    {
        name = "Lupus",
        abbr = 'Lup',
        elements = {'fire', 'earth'},
        symbolism = 'the wolf',
        quadrant = 'SQ',
        main_stars = 13,
        bayer_stars = 124,
        bordering = {'Lib', 'Hya', 'Cen', 'Nor', 'Cir', 'Sco'},
        ascii_art = "18*19/\\18*---*20\\21*20/\\19*20\\21*"
    },
    {
        name = "Serpens",
        abbr = 'Ser',
        elements = {'fire', 'earth'},
        symbolism = 'the serpent',
        quadrant = 'SQ',
        main_stars = 18,
        bayer_stars = 106,
        bordering = {'Her', 'CrB', 'Boo', 'Vir', 'Lib', 'Oph', 'Sct', 'Aql'},
        ascii_art = "18*19\\20*19/\\20*21\\22*21/\\22*23\\24*23/\\24*"
    },
    {
        name = "Fornax",
        abbr = 'For',
        elements = {'fire', 'earth'},
        symbolism = 'the furnace',
        quadrant = 'NQ',
        main_stars = 4,
        bayer_stars = 35,
        bordering = {'Scl', 'Eri', 'Cel', 'Phe'},
        ascii_art = "20*21*22*21|22*"
    },
    {
        name = "Scutum",
        abbr = 'Sct',
        elements = {'fire', 'earth'},
        symbolism = 'the shield',
        quadrant = 'NQ',
        main_stars = 4,
        bayer_stars = 32,
        bordering = {'Ser', 'Oph', 'Aql', 'Sgr'},
        ascii_art = "18*---*19|20*19|18*---*"
    },
    {
        name = "Ursa Minor",
        abbr = 'UMi',
        elements = {'fire', 'earth'},
        symbolism = 'the little bear',
        quadrant = 'NQ',
        main_stars = 7,
        bayer_stars = 56,
        bordering = {'Cep', 'Cam', 'Dra'},
        ascii_art = "24*20---*24*20/24\\20*24/20\\24*"
    },
    {
        name = "Lepus",
        abbr = 'Lep',
        elements = {'fire', 'earth'},
        symbolism = 'the hare',
        quadrant = 'SQ',
        main_stars = 8,
        bayer_stars = 51,
        bordering = {'Ori', 'Eri', 'Cel', 'Col', 'Cma', 'Mon'},
        ascii_art = "18*19*20*19/\\20*21\\22*"
    },
    {
        name = "Microscopium",
        abbr = 'Mic',
        elements = {'fire', 'earth'},
        symbolism = 'the microscope',
        quadrant = 'SQ',
        main_stars = 3,
        bayer_stars = 30,
        bordering = {'Sgr', 'Tel', 'Ara', 'Ind', 'Cap', 'Psc A'},
        ascii_art = "20*21|22*23*24*"
    },
    {
        name = "Telescopium",
        abbr = 'Tel',
        elements = {'fire', 'earth'},
        symbolism = 'the telescope',
        quadrant = 'SQ',
        main_stars = 4,
        bayer_stars = 37,
        bordering = {'Sgr', 'Mic', 'Ara', 'Pav', 'Ind'},
        ascii_art = "20*21|22*23/\\22*"
    },

    -- ========================================================================
    -- FIRE + AIR (15 constellations)
    -- ========================================================================
    {
        name = "Auriga",
        abbr = 'Aur',
        elements = {'fire', 'air'},
        symbolism = 'the charioteer',
        quadrant = 'NQ',
        main_stars = 9,
        bayer_stars = 109,
        bordering = {'Per', 'Tau', 'Gem', 'Lyn', 'Cam'},
        ascii_art = "20*21*22*21|20*21/\\22*"
    },
    {
        name = "Cassiopeia",
        abbr = 'Cas',
        elements = {'fire', 'air'},
        symbolism = 'the queen',
        quadrant = 'NQ',
        main_stars = 9,
        bayer_stars = 103,
        bordering = {'Per', 'And', 'Lac', 'Cep'},
        ascii_art = "18*20*22*20|18*20*"
    },
    {
        name = "Cepheus",
        abbr = 'Cep',
        elements = {'fire', 'air'},
        symbolism = 'the king',
        quadrant = 'NQ',
        main_stars = 7,
        bayer_stars = 84,
        bordering = {'Cam', 'UMi', 'Dra', 'Cyg', 'Lac', 'Cas'},
        ascii_art = "20*19/\\20*21|20*21\\22*"
    },
    {
        name = "Perseus",
        abbr = 'Per',
        elements = {'fire', 'air'},
        symbolism = 'the hero',
        quadrant = 'NQ',
        main_stars = 19,
        bayer_stars = 96,
        bordering = {'And', 'Cas', 'Cam', 'Aur', 'Tau', 'Ari', 'Tri'},
        ascii_art = "20*21\\18*---*19/\\20*21|22*21/\\20*"
    },
    {
        name = "Sagitta",
        abbr = 'Sge',
        elements = {'fire', 'air'},
        symbolism = 'the arrow',
        quadrant = 'NQ',
        main_stars = 4,
        bayer_stars = 29,
        bordering = {'Vul', 'Del', 'Equ', 'Aql'},
        ascii_art = "18*19*20*21*20*"
    },
    {
        name = "Triangulum",
        abbr = 'Tri',
        elements = {'fire', 'air'},
        symbolism = 'the triangle',
        quadrant = 'NQ',
        main_stars = 4,
        bayer_stars = 32,
        bordering = {'And', 'Per', 'Ari', 'Psc'},
        ascii_art = "20*19/\\18*---*"
    },
    {
        name = "Corona Borealis",
        abbr = 'CrB',
        elements = {'fire', 'air'},
        symbolism = 'the northern crown',
        quadrant = 'NQ',
        main_stars = 8,
        bayer_stars = 39,
        bordering = {'Boo', 'Ser', 'Her'},
        ascii_art = "18*19*20*21*20/\\19*"
    },
    {
        name = "Equuleus",
        abbr = 'Equ',
        elements = {'fire', 'air'},
        symbolism = 'the little horse',
        quadrant = 'NQ',
        main_stars = 4,
        bayer_stars = 27,
        bordering = {'Peg', 'Del', 'Aql'},
        ascii_art = "20*21*22*21|22*"
    },
    {
        name = "Lyra",
        abbr = 'Lyr',
        elements = {'fire', 'air'},
        symbolism = 'the lyre',
        quadrant = 'NQ',
        main_stars = 9,
        bayer_stars = 73,
        bordering = {'Her', 'Dra', 'Cyg', 'Vul'},
        ascii_art = "20*19/\\18*---*19|20*19|18*"
    },
    {
        name = "Pegasus",
        abbr = 'Peg',
        elements = {'fire', 'air'},
        symbolism = 'the winged horse',
        quadrant = 'NQ',
        main_stars = 16,
        bayer_stars = 103,
        bordering = {'And', 'Lac', 'Cyg', 'Del', 'Equ', 'Aqr', 'Psc', 'Tri'},
        ascii_art = "20*19/\\18*---*20*21\\22*21/\\20*---*"
    },
    {
        name = "Corona Australis",
        abbr = 'CrA',
        elements = {'fire', 'air'},
        symbolism = 'the southern crown',
        quadrant = 'SQ',
        main_stars = 6,
        bayer_stars = 25,
        bordering = {'Sgr', 'Cap', 'Tel', 'Ara'},
        ascii_art = "18*19*20*21*20/\\19*"
    },
    {
        name = "Crux",
        abbr = 'Cru',
        elements = {'fire', 'air'},
        symbolism = 'the southern cross',
        quadrant = 'SQ',
        main_stars = 5,
        bayer_stars = 31,
        bordering = {'Cen', 'Mus', 'Car'},
        ascii_art = "20*20|18*---*---*20|22*"
    },
    {
        name = "Phoenix",
        abbr = 'Phe',
        elements = {'fire', 'air'},
        symbolism = 'the phoenix',
        quadrant = 'SQ',
        main_stars = 7,
        bayer_stars = 64,
        bordering = {'Scl', 'For', 'Cel', 'Hyr', 'Eri', 'Aqr'},
        ascii_art = "20*21/\\22*23\\24*23/\\22*"
    },
    {
        name = "Horologium",
        abbr = 'Hor',
        elements = {'fire', 'air'},
        symbolism = 'the pendulum clock',
        quadrant = 'SQ',
        main_stars = 4,
        bayer_stars = 40,
        bordering = {'Eri', 'Cel', 'Ret', 'Dor'},
        ascii_art = "20*20|22*21/\\20*"
    },
    {
        name = "Monoceros",
        abbr = 'Mon',
        elements = {'fire', 'air'},
        symbolism = 'the unicorn',
        quadrant = 'SQ',
        main_stars = 8,
        bayer_stars = 85,
        bordering = {'Gem', 'Cmi', 'Ori', 'Lep', 'Cma', 'Pup', 'Cnc'},
        ascii_art = "20*19/\\18*---*20*21\\22*"
    },

    -- ========================================================================
    -- FIRE + WATER (14 constellations)
    -- ========================================================================
    {
        name = "Andromeda",
        abbr = 'And',
        elements = {'fire', 'water'},
        symbolism = 'the chained princess',
        quadrant = 'NQ',
        main_stars = 6,
        bayer_stars = 102,
        bordering = {'Per', 'Cas', 'Lac', 'Peg', 'Tri'},
        ascii_art = "20*21\\22*23|24*23/\\22*"
    },
    {
        name = "Orion",
        abbr = 'Ori',
        elements = {'fire', 'water'},
        symbolism = 'the hunter',
        quadrant = 'NQ',
        main_stars = 7,
        bayer_stars = 81,
        bordering = {'Gem', 'Tau', 'Eri', 'Lep', 'Mon'},
        ascii_art = "16*18*17|18*---*---*17|16*18*"
    },
    {
        name = "Draco",
        abbr = 'Dra',
        elements = {'fire', 'water'},
        symbolism = 'the dragon',
        quadrant = 'NQ',
        main_stars = 14,
        bayer_stars = 108,
        bordering = {'UMi', 'Cep', 'Cam', 'UMa', 'Boo', 'Her', 'Lyr', 'Cyg'},
        ascii_art = "20*21\\22*---*23/\\22*25\\26*25/\\20*---*"
    },
    {
        name = "Hercules",
        abbr = 'Her',
        elements = {'fire', 'water'},
        symbolism = 'the hero',
        quadrant = 'NQ',
        main_stars = 19,
        bayer_stars = 164,
        bordering = {'Dra', 'Boo', 'CrB', 'Ser', 'Oph', 'Aql', 'Lyr'},
        ascii_art = "20*21*18*---*---*19|18*19|20*21*20/\\19*"
    },
    {
        name = "Indus",
        abbr = 'Ind',
        elements = {'fire', 'water'},
        symbolism = 'the indian',
        quadrant = 'SQ',
        main_stars = 4,
        bayer_stars = 40,
        bordering = {'Tel', 'Pav', 'Aps', 'Oct', 'Hyr', 'Tuc', 'Phe', 'Scl', 'Aqr', 'Cap', 'Mic'},
        ascii_art = "20*19/\\18*21*"
    },
    {
        name = "Ophiuchus",
        abbr = 'Oph',
        elements = {'fire', 'water'},
        symbolism = 'the serpent bearer',
        quadrant = 'SQ',
        main_stars = 20,
        bayer_stars = 147,
        bordering = {'Her', 'Aql', 'Sct', 'Ser', 'Lib', 'Sco'},
        ascii_art = "20*19/|\\18*21|18*---*---*21|22*"
    },
    {
        name = "Scorpius",
        abbr = 'Sco',
        elements = {'fire', 'water'},
        symbolism = 'the scorpion',
        quadrant = 'SQ',
        main_stars = 18,
        bayer_stars = 109,
        bordering = {'Lib', 'Lup', 'Nor', 'Ara', 'Oph', 'Ser', 'Sgr'},
        ascii_art = "20*21\\18*---*---*23\\24*23/\\20*---*"
    },
    {
        name = "Pictor",
        abbr = 'Pic',
        elements = {'fire', 'water'},
        symbolism = 'the easel',
        quadrant = 'SQ',
        main_stars = 6,
        bayer_stars = 55,
        bordering = {'Lep', 'Col', 'Pup', 'Car', 'Dor'},
        ascii_art = "20*19/\\18*---*20*"
    },
    {
        name = "Reticulum",
        abbr = 'Ret',
        elements = {'fire', 'water'},
        symbolism = 'the reticle',
        quadrant = 'SQ',
        main_stars = 4,
        bayer_stars = 32,
        bordering = {'Hyr', 'Dor', 'Hor', 'Eri'},
        ascii_art = "18*---*19|18*---*"
    },
    {
        name = "Vulpecula",
        abbr = 'Vul',
        elements = {'fire', 'water'},
        symbolism = 'the fox',
        quadrant = 'NQ',
        main_stars = 5,
        bayer_stars = 55,
        bordering = {'Cyg', 'Lyr', 'Her', 'Aql', 'Sge', 'Del'},
        ascii_art = "20*21*22*21|20*"
    },
    {
        name = "Columba",
        abbr = 'Col',
        elements = {'fire', 'water'},
        symbolism = 'the dove',
        quadrant = 'NQ',
        main_stars = 6,
        bayer_stars = 52,
        bordering = {'Lep', 'Cma', 'Pup', 'Pic'},
        ascii_art = "20*19/\\18*---*20*"
    },
    {
        name = "Hydra",
        abbr = 'Hya',
        elements = {'fire', 'water'},
        symbolism = 'the water snake',
        quadrant = 'NQ',
        main_stars = 17,
        bayer_stars = 243,
        bordering = {'Cnc', 'Leo', 'LMi', 'Sex', 'Crt', 'Crv', 'Vir', 'Lib', 'Cen', 'Ant', 'Pyx', 'Pup', 'Cma', 'Cmi', 'Mon'},
        ascii_art = "20*21\\22*---*25\\26*25/\\20*---*---*"
    },
    {
        name = "Pisces",
        abbr = 'Psc',
        elements = {'fire', 'water'},
        symbolism = 'the fish',
        quadrant = 'NQ',
        main_stars = 15,
        bayer_stars = 133,
        bordering = {'Peg', 'Tri', 'Ari', 'Cet', 'Aqr', 'Psc A'},
        ascii_art = "18*20*19/\\20*---*21/\\20*22*20*"
    },
    {
        name = "Sextans",
        abbr = 'Sex',
        elements = {'fire', 'water'},
        symbolism = 'the sextant',
        quadrant = 'NQ',
        main_stars = 3,
        bayer_stars = 47,
        bordering = {'Leo', 'Hya', 'Crt'},
        ascii_art = "20*19/\\22*"
    },

    -- ========================================================================
    -- EARTH + AIR (14 constellations)
    -- ========================================================================
    {
        name = "Gemini",
        abbr = 'Gem',
        elements = {'earth', 'air'},
        symbolism = 'the twins',
        quadrant = 'NQ',
        main_stars = 17,
        bayer_stars = 85,
        bordering = {'Aur', 'Tau', 'Mon', 'Cmi', 'Cnc', 'Leo'},
        ascii_art = "18*20*18|20*18|20*19\\21/"
    },
    {
        name = "Libra",
        abbr = 'Lib',
        elements = {'earth', 'air'},
        symbolism = 'the scales',
        quadrant = 'SQ',
        main_stars = 9,
        bayer_stars = 83,
        bordering = {'Vir', 'Crv', 'Crt', 'Hya', 'Lup', 'Sco', 'Oph', 'Ser'},
        ascii_art = "20*19/\\18*---*---*21*"
    },
    {
        name = "Camelopardalis",
        abbr = 'Cam',
        elements = {'earth', 'air'},
        symbolism = 'the giraffe',
        quadrant = 'NQ',
        main_stars = 4,
        bayer_stars = 50,
        bordering = {'Per', 'Aur', 'Gem', 'UMa', 'Cep', 'Dra'},
        ascii_art = "20*20|22*21/\\24*"
    },
    {
        name = "Caelum",
        abbr = 'Cel',
        elements = {'earth', 'air'},
        symbolism = 'the chisel',
        quadrant = 'NQ',
        main_stars = 2,
        bayer_stars = 18,
        bordering = {'For', 'Scl', 'Phe', 'Hyr', 'Lep'},
        ascii_art = "20*21\\22*"
    },
    {
        name = "Lacerta",
        abbr = 'Lac',
        elements = {'earth', 'air'},
        symbolism = 'the lizard',
        quadrant = 'NQ',
        main_stars = 4,
        bayer_stars = 35,
        bordering = {'And', 'Cas', 'Cep', 'Cyg', 'Peg'},
        ascii_art = "20*---*23\\24*23/20*"
    },
    {
        name = "Leo Minor",
        abbr = 'LMi',
        elements = {'earth', 'air'},
        symbolism = 'the lesser lion',
        quadrant = 'NQ',
        main_stars = 3,
        bayer_stars = 37,
        bordering = {'UMa', 'Lyn', 'Leo', 'Hya'},
        ascii_art = "20*21*22*"
    },
    {
        name = "Lynx",
        abbr = 'Lyn',
        elements = {'earth', 'air'},
        symbolism = 'the lynx',
        quadrant = 'NQ',
        main_stars = 6,
        bayer_stars = 66,
        bordering = {'Cam', 'Gem', 'Aur', 'UMa'},
        ascii_art = "20*19/\\18*---*21\\22*"
    },
    {
        name = "Sculptor",
        abbr = 'Scl',
        elements = {'earth', 'air'},
        symbolism = 'the sculptor',
        quadrant = 'NQ',
        main_stars = 4,
        bayer_stars = 41,
        bordering = {'Cet', 'Eri', 'For', 'Cel', 'Phe', 'Aqr'},
        ascii_art = "20*21*22*21|20*"
    },
    {
        name = "Antlia",
        abbr = 'Ant',
        elements = {'earth', 'air'},
        symbolism = 'the air pump',
        quadrant = 'SQ',
        main_stars = 4,
        bayer_stars = 42,
        bordering = {'Hya', 'Vel', 'Pyx', 'Cen'},
        ascii_art = "20*21|22*21/\\20*"
    },
    {
        name = "Circinus",
        abbr = 'Cir',
        elements = {'earth', 'air'},
        symbolism = 'the compass',
        quadrant = 'SQ',
        main_stars = 4,
        bayer_stars = 32,
        bordering = {'Cen', 'Mus', 'Aps', 'Tri A', 'Lup'},
        ascii_art = "20*19/\\22*21|20*"
    },
    {
        name = "Norma",
        abbr = 'Nor',
        elements = {'earth', 'air'},
        symbolism = 'the level',
        quadrant = 'SQ',
        main_stars = 6,
        bayer_stars = 46,
        bordering = {'Lup', 'Cir', 'Ara', 'Sco'},
        ascii_art = "18*---*---*19|18*19|"
    },
    {
        name = "Ursa Major",
        abbr = 'UMa',
        elements = {'earth', 'air'},
        symbolism = 'the great bear',
        quadrant = 'SQ',
        main_stars = 14,
        bayer_stars = 149,
        bordering = {'Cam', 'Dra', 'Boo', 'CVn', 'Com', 'Leo', 'Lyn'},
        ascii_art = "16*---*---*21\\22*---*---*25\\26*25/"
    },
    {
        name = "Triangulum Australe",
        abbr = 'Tri A',
        elements = {'earth', 'air'},
        symbolism = 'the southern triangle',
        quadrant = 'SQ',
        main_stars = 4,
        bayer_stars = 32,
        bordering = {'Cir', 'Ara', 'Pav', 'Aps'},
        ascii_art = "20*19/\\18*---*"
    },
    {
        name = "Capricornus",
        abbr = 'Cap',
        elements = {'earth', 'air'},
        symbolism = 'the sea goat',
        quadrant = 'NQ',
        main_stars = 11,
        bayer_stars = 81,
        bordering = {'Aqr', 'Mic', 'Ind', 'Tel', 'Sgr'},
        ascii_art = "20*19/\\18*---*21\\22*21/\\20*"
    },

    -- ========================================================================
    -- EARTH + WATER (15 constellations)
    -- ========================================================================
    {
        name = "Cancer",
        abbr = 'Cnc',
        elements = {'earth', 'water'},
        symbolism = 'the crab',
        quadrant = 'SQ',
        main_stars = 5,
        bayer_stars = 60,
        bordering = {'Gem', 'Cmi', 'Hya', 'Leo'},
        ascii_art = "18*20*19/\\20*---*"
    },
    {
        name = "Virgo",
        abbr = 'Vir',
        elements = {'earth', 'water'},
        symbolism = 'the virgin',
        quadrant = 'SQ',
        main_stars = 16,
        bayer_stars = 169,
        bordering = {'Boo', 'Com', 'Leo', 'Crv', 'Crt', 'Hya', 'Lib'},
        ascii_art = "20*21\\22*21/\\20*23\\24*23/\\20*---*"
    },
    {
        name = "Canes Venatici",
        abbr = 'CVn',
        elements = {'earth', 'water'},
        symbolism = 'the hunting dogs',
        quadrant = 'NQ',
        main_stars = 4,
        bayer_stars = 48,
        bordering = {'UMa', 'Com', 'Boo', 'Leo'},
        ascii_art = "20*21*22*21|20*"
    },
    {
        name = "Canis Major",
        abbr = 'Cma',
        elements = {'earth', 'water'},
        symbolism = 'the great dog',
        quadrant = 'NQ',
        main_stars = 14,
        bayer_stars = 86,
        bordering = {'Mon', 'Cmi', 'Hya', 'Pup'},
        ascii_art = "20*19/|\\18*21|18*---*---*21*"
    },
    {
        name = "Canis Minor",
        abbr = 'Cmi',
        elements = {'earth', 'water'},
        symbolism = 'the little dog',
        quadrant = 'NQ',
        main_stars = 5,
        bayer_stars = 42,
        bordering = {'Gem', 'Cnc', 'Hya', 'Cma', 'Mon', 'Ori'},
        ascii_art = "20*21*22*21|20*"
    },
    {
        name = "Cetus",
        abbr = 'Cet',
        elements = {'earth', 'water'},
        symbolism = 'the whale',
        quadrant = 'NQ',
        main_stars = 10,
        bayer_stars = 102,
        bordering = {'Ari', 'Tau', 'Ori', 'Eri', 'Scl', 'Psc', 'Aqr'},
        ascii_art = "16*---*---*---*18/\\16*---*---*---*"
    },
    {
        name = "Eridanus",
        abbr = 'Eri',
        elements = {'earth', 'water'},
        symbolism = 'the river',
        quadrant = 'NQ',
        main_stars = 10,
        bayer_stars = 108,
        bordering = {'Ori', 'Lep', 'For', 'Scl', 'Cet', 'Tau'},
        ascii_art = "20*21\\22*23\\24*25\\26*27\\28*29\\30*"
    },
    {
        name = "Chamaeleon",
        abbr = 'Cha',
        elements = {'earth', 'water'},
        symbolism = 'the chameleon',
        quadrant = 'SQ',
        main_stars = 4,
        bayer_stars = 34,
        bordering = {'Car', 'Vol', 'Aps', 'Oct', 'Men'},
        ascii_art = "20*---*23\\24*23/22*"
    },
    {
        name = "Grus",
        abbr = 'Gru',
        elements = {'earth', 'water'},
        symbolism = 'the crane',
        quadrant = 'SQ',
        main_stars = 10,
        bayer_stars = 58,
        bordering = {'Phe', 'Tuc', 'Ind', 'Aqr', 'Psc A', 'Mic', 'Scl'},
        ascii_art = "20*21\\22*---*25\\26*25/\\24*"
    },
    {
        name = "Mensa",
        abbr = 'Men',
        elements = {'earth', 'water'},
        symbolism = 'the table mountain',
        quadrant = 'SQ',
        main_stars = 3,
        bayer_stars = 30,
        bordering = {'Vol', 'Dor', 'Oct', 'Cha'},
        ascii_art = "18*---*---*"
    },
    {
        name = "Piscis Austrinus",
        abbr = 'Psc A',
        elements = {'earth', 'water'},
        symbolism = 'the southern fish',
        quadrant = 'SQ',
        main_stars = 5,
        bayer_stars = 37,
        bordering = {'Cap', 'Mic', 'Aqr', 'Psc', 'Sgr'},
        ascii_art = "20*21*22*21/\\20*"
    },
    {
        name = "Aquarius",
        abbr = 'Aqr',
        elements = {'earth', 'water'},
        symbolism = 'the water bearer',
        quadrant = 'NQ',
        main_stars = 16,
        bayer_stars = 131,
        bordering = {'Peg', 'Equ', 'Del', 'Aql', 'Sgr', 'Cap', 'Psc', 'Cet', 'Phe', 'Scl'},
        ascii_art = "20*21\\22*21/\\20*21/\\20*"
    },
    {
        name = "Aquila",
        abbr = 'Aql',
        elements = {'earth', 'water'},
        symbolism = 'the eagle',
        quadrant = 'NQ',
        main_stars = 12,
        bayer_stars = 103,
        bordering = {'Her', 'Lyr', 'Vul', 'Sge', 'Del', 'Equ', 'Ser', 'Oph', 'Sct', 'Sgr'},
        ascii_art = "20*19/|\\18*21|18*---*---*21*"
    },
    {
        name = "Coma Berenices",
        abbr = 'Com',
        elements = {'earth', 'water'},
        symbolism = "berenice's hair",
        quadrant = 'NQ',
        main_stars = 3,
        bayer_stars = 43,
        bordering = {'UMa', 'Boo', 'Vir', 'Leo', 'CVn'},
        ascii_art = "19*20*21*"
    },
    {
        name = "Corvus",
        abbr = 'Crv',
        elements = {'earth', 'water'},
        symbolism = 'the crow',
        quadrant = 'NQ',
        main_stars = 7,
        bayer_stars = 36,
        bordering = {'Vir', 'Crt', 'Hya', 'Lib'},
        ascii_art = "20*21*18*---*---*"
    },

    -- ========================================================================
    -- AIR + WATER (15 constellations)
    -- ========================================================================
    {
        name = "Cygnus",
        abbr = 'Cyg',
        elements = {'air', 'water'},
        symbolism = 'the swan',
        quadrant = 'NQ',
        main_stars = 19,
        bayer_stars = 150,
        bordering = {'Cep', 'Dra', 'Lyr', 'Vul', 'Del', 'Peg', 'Lac'},
        ascii_art = "20*21\\18*---*---*19|18*21|22*21/\\20*"
    },
    {
        name = "Delphinus",
        abbr = 'Del',
        elements = {'air', 'water'},
        symbolism = 'the dolphin',
        quadrant = 'NQ',
        main_stars = 5,
        bayer_stars = 34,
        bordering = {'Vul', 'Sge', 'Equ', 'Aql', 'Peg'},
        ascii_art = "19*---*18/\\19*---*"
    },
    {
        name = "Apus",
        abbr = 'Aps',
        elements = {'air', 'water'},
        symbolism = 'the bird of paradise',
        quadrant = 'SQ',
        main_stars = 4,
        bayer_stars = 32,
        bordering = {'Mus', 'Cir', 'Oct', 'Pav', 'Ind', 'Tuc', 'Cha'},
        ascii_art = "20*21*22*21/\\20*"
    },
    {
        name = "Dorado",
        abbr = 'Dor',
        elements = {'air', 'water'},
        symbolism = 'the dolphinfish',
        quadrant = 'SQ',
        main_stars = 6,
        bayer_stars = 47,
        bordering = {'Vol', 'Men', 'Hor', 'Ret', 'Hyr'},
        ascii_art = "18*---*---*19|18*---*"
    },
    {
        name = "Musca",
        abbr = 'Mus',
        elements = {'air', 'water'},
        symbolism = 'the fly',
        quadrant = 'SQ',
        main_stars = 5,
        bayer_stars = 38,
        bordering = {'Car', 'Vol', 'Cha', 'Aps', 'Cir', 'Cen'},
        ascii_art = "19*---*18*19*18*---*"
    },
    {
        name = "Octans",
        abbr = 'Oct',
        elements = {'air', 'water'},
        symbolism = 'the octant',
        quadrant = 'SQ',
        main_stars = 6,
        bayer_stars = 62,
        bordering = {'Hyr', 'Phe', 'Ind', 'Pav', 'Aps', 'Cha', 'Men', 'Vol'},
        ascii_art = "20*19/|\\18*21*"
    },
    {
        name = "Pavo",
        abbr = 'Pav',
        elements = {'air', 'water'},
        symbolism = 'the peacock',
        quadrant = 'SQ',
        main_stars = 10,
        bayer_stars = 62,
        bordering = {'Tel', 'Ara', 'Aps', 'Oct', 'Ind', 'Tuc'},
        ascii_art = "20*19/|\\18*21|18*---*---*17*19*"
    },
    {
        name = "Tucana",
        abbr = 'Tuc',
        elements = {'air', 'water'},
        symbolism = 'the toucan',
        quadrant = 'SQ',
        main_stars = 6,
        bayer_stars = 46,
        bordering = {'Phe', 'Ind', 'Oct', 'Hyr', 'Vol', 'Dor'},
        ascii_art = "20*19/\\18*---*21\\22*"
    },
    {
        name = "Volans",
        abbr = 'Vol',
        elements = {'air', 'water'},
        symbolism = 'the flying fish',
        quadrant = 'SQ',
        main_stars = 6,
        bayer_stars = 42,
        bordering = {'Car', 'Men', 'Cha', 'Aps', 'Mus', 'Dor', 'Hyr', 'Tuc'},
        ascii_art = "18*---*---*17/\\16*"
    },
    {
        name = "Pyxis",
        abbr = 'Pyx',
        elements = {'air', 'water'},
        symbolism = 'the compass',
        quadrant = 'SQ',
        main_stars = 5,
        bayer_stars = 42,
        bordering = {'Hya', 'Ant', 'Vel', 'Pup'},
        ascii_art = "20*19/|\\18*21*"
    },
    {
        name = "Carina",
        abbr = 'Car',
        elements = {'air', 'water'},
        symbolism = 'the keel',
        quadrant = 'SQ',
        main_stars = 20,
        bayer_stars = 118,
        bordering = {'Vol', 'Cha', 'Mus', 'Cen', 'Vel', 'Pup'},
        ascii_art = "20*19/|\\18*21|18*---*---*17*19*15*17*"
    },
    {
        name = "Crater",
        abbr = 'Crt',
        elements = {'air', 'water'},
        symbolism = 'the cup',
        quadrant = 'SQ',
        main_stars = 7,
        bayer_stars = 46,
        bordering = {'Hya', 'Crv', 'Vir', 'Leo', 'Sex'},
        ascii_art = "19*---*20\\21*20/\\19*"
    },
    {
        name = "Hydrus",
        abbr = 'Hyr',
        elements = {'air', 'water'},
        symbolism = 'the water snake',
        quadrant = 'SQ',
        main_stars = 6,
        bayer_stars = 46,
        bordering = {'Eri', 'Cel', 'Phe', 'Tuc', 'Oct', 'Hya', 'Dor', 'Ret'},
        ascii_art = "20*21\\22*---*25\\26*25/\\24*"
    },
    {
        name = "Puppis",
        abbr = 'Pup',
        elements = {'air', 'water'},
        symbolism = 'the poop deck',
        quadrant = 'SQ',
        main_stars = 14,
        bayer_stars = 135,
        bordering = {'Mon', 'Cma', 'Vel', 'Pyx', 'Hya', 'Ant'},
        ascii_art = "20*19/|\\18*21|18*---*---*17*19*"
    },
    {
        name = "Vela",
        abbr = 'Vel',
        elements = {'air', 'water'},
        symbolism = 'the sails',
        quadrant = 'SQ',
        main_stars = 14,
        bayer_stars = 110,
        bordering = {'Pup', 'Ant', 'Cen', 'Car', 'Cha', 'Vol'},
        ascii_art = "20*19/|\\18*21|18*---*---*17/\\16*"
    },

}

return base_modern_constellations_list
