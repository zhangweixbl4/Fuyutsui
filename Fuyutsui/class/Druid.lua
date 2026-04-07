local _, fu = ...
if fu.classId ~= 11 then return end

local creat = fu.updateOrCreatTextureByIndex

fu.HelpfulSpellId = 774
fu.HarmfulSpellId = 5176

fu.heroSpell = {
    [424058] = 1, -- 艾露恩钦选者
    [433901] = 2, -- 丛林守护者
    [441583] = 3, -- 利爪德鲁伊
    [439528] = 4, -- 荒野追猎者
}

function fu.updateSpecInfo()
    local specIndex = C_SpecializationInfo.GetSpecialization()
    fu.powerType = nil
    fu.blocks = nil
    fu.group_blocks = nil
    fu.assistant_spells = nil
    if specIndex == 3 then
        fu.powerType = "RAGE"
        fu.blocks = {
            ["目标生命值"] = 21,
            ["敌人人数"] = 22,
            stance = 23,
            auras = {
                ["塞纳留斯的梦境"] = {
                    index = 24,
                    auraRef = fu.auras["塞纳留斯的梦境"],
                    showKey = "remaining",
                },
                ["塞纳留斯的梦境层数"] = {
                    index = 25,
                    auraRef = fu.auras["塞纳留斯的梦境"],
                    showKey = "count",
                },
                ["铁鬃"] = {
                    index = 26,
                    auraRef = fu.auras["铁鬃"],
                    showKey = "remaining",
                },
                ["狂暴回复"] = {
                    index = 27,
                    auraRef = fu.auras["狂暴回复"],
                    showKey = "remaining",
                },
            },
            spell_cd = {
                [22812] = { index = 31, spellId = 22812, name = "树皮术" },
                [61336] = { index = 32, spellId = 61336, name = "生存本能" },
                [22842] = { index = 33, spellId = 22842, name = "狂暴回复" ,charge = 41},
                [132469] = { index = 34, spellId = 132469, name = "台风" },
                [99] = { index = 35, spellId = 99, name = "夺魂咆哮" },
                [102558] = { index = 36, spellId = 102558, name = "化身：乌索克的守护者" },
                [132158] = { index = 37, spellId = 132158, name = "自然迅捷" },
                [29166] = { index = 38, spellId = 29166, name = "激活" },
                [1261867] = { index = 39, spellId = 1261867, name = "野性之心" },
                [102793] = { index = 40, spellId = 102793, name = "乌索克旋风" },
            },
        }
    elseif specIndex == 4 then
        fu.powerType = "MANA"
        fu.blocks = {
            stance = 21,
            target_maxRange = 22,
            comboPoints = 23,
            auras = {
                ["节能施法"] = {
                    index = 24,
                    auraRef = fu.auras["节能施法"],
                    showKey = "remaining",
                },
                ["丛林之魂"] = {
                    index = 25,
                    auraRef = fu.auras["丛林之魂"],
                    showKey = "remaining",
                },
            },
            spell_cd = {
                [22812] = { index = 31, name = "树皮术" },
                [48438] = { index = 32, name = "野性成长" },
                [391528] = { index = 33, name = "万灵之召" },
                [18562] = { index = 34, name = "迅捷治愈", charge = 43 },
                [88423] = { index = 35, name = "自然之愈" },
                [102342] = { index = 36, name = "铁木树皮" },
                [132158] = { index = 37, name = "自然迅捷" },
                [29166] = { index = 38, name = "激活" },
                [1261867] = { index = 39, name = "野性之心" },
                [132469] = { index = 40, name = "台风" },
                [99] = { index = 41, name = "夺魂咆哮" },
                [102793] = { index = 42, name = "乌索克旋风" },
            },
        }
        fu.group_blocks = {
            unit_start = 45,
            block_num = 7,
            healthPercent = 1,
            role = 2,
            dispel = 3,
            aura = {
                [4] = { 33763 },                    -- 生命绽放
                [5] = { 48438, 8936, 774, 155777 }, -- 迅捷治愈(回春术, 萌芽, 愈合, 野性生长)
                [6] = { 8936 },                     -- 愈合
            },
            rejuv = 7,                              -- 回春术数量
        }
    end
end

-- 创建德鲁伊宏
function fu.CreateClassMacro()
    local dynamicSpells = { "回春术", "愈合", "生命绽放", "迅捷治愈", "自然之愈" }
    local specialSpells = { [17] = "/cancelaura [spec:4]猎豹形态\n/cast 万灵之召", }
    local staticSpells = {
        [1] = "[nostance:2]猎豹形态(变形)",
        [2] = "[nostance:1]熊形态(变形)",
        [3] = "[nostance:4]枭兽形态",
        [4] = "月火术",
        [5] = "树皮术",
        [6] = "横扫",
        [7] = "潜行",
        [8] = "凶猛撕咬",
        [9] = "愤怒",
        [10] = "割裂",
        [11] = "撕碎",
        [12] = "斜掠",
        [13] = "痛击",
        [14] = "野性印记",
        [15] = "裂伤",
        [16] = "野性成长",
        [18] = "自然迅捷",
        [19] = "[@player]激活",
        [20] = "野性之心",
        [21] = "野性冲锋",
        [22] = "铁鬃",
        [23] = "摧折",
        [24] = "明月普照",
        [25] = "狂暴回复",
    }
    fu.CreateMacro(dynamicSpells, staticSpells, specialSpells)
end
