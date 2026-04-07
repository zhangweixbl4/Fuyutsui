local _, fu = ...
if fu.classId ~= 5 then return end
local creat = fu.updateOrCreatTextureByIndex

fu.HarmfulSpellId, fu.HelpfulSpellId = 585, 2061

fu.heroSpell = {
    [1248423] = 1, -- 神谕者
    [263165] = 2,  -- 虚空编织者
    [447444] = 2,  -- 虚空编织者
    [120517] = 3,  -- 执政官
    [102644] = 3,  -- 执政官
}

function fu.updateSpecInfo()
    local specIndex = C_SpecializationInfo.GetSpecialization()
    fu.powerType = nil
    fu.blocks = nil
    fu.group_blocks = nil
    fu.assistant_spells = nil
    if specIndex == 1 then
        fu.powerType = "MANA"
        fu.blocks = {
            auras = {
                ["虚空之盾"] = {
                    index = 25,
                    auraRef = fu.auras["虚空之盾"],
                    showKey = "remaining",
                },
                ["圣光涌动"] = {
                    index = 26,
                    auraRef = fu.auras["圣光涌动"],
                    showKey = "remaining",
                },
                ["熵能裂隙"] = {
                    index = 27,
                    auraRef = fu.auras["熵能裂隙"],
                    showKey = "remaining",
                },
                ["暗影愈合"] = {
                    index = 28,
                    auraRef = fu.auras["暗影愈合"],
                    showKey = "remaining",
                },
                ["福音层数"] = {
                    index = 29,
                    auraRef = fu.auras["福音层数"],
                    showKey = "count",
                },
            },
            spell_cd = {
                [17] = { index = 31, spellId = 17, name = "真言术：盾" },
                [47540] = { index = 32, spellId = 47540, name = "苦修", charge = 33 },
                [194509] = { index = 34, spellId = 194509, name = "真言术：耀" },
                [527] = { index = 35, spellId = 527, name = "纯净术" },
                [19236] = { index = 36, spellId = 19236, name = "绝望祷言" },
                [8092] = { index = 37, spellId = 8092, name = "心灵震爆" },
                [472433] = { index = 38, spellId = 472433, name = "福音" },
                [32379] = { index = 39, spellId = 32379, name = "暗言术：灭" },
                [232633] = { index = 40, spellId = 232633, name = "奥术洪流" },
                [8122] = { index = 41, spellId = 8122, name = "心灵尖啸" },
                [32375] = { index = 42, spellId = 32375, name = "群体驱散" },
                [62618] = { index = 43, spellId = 62618, name = "真言术：障" },
                [421453] = { index = 44, spellId = 421453, name = "终极苦修" },
            },
        }
        fu.group_blocks = {
            unit_start = 70,
            block_num = 5,
            healthPercent = 1,
            role = 2,
            dispel = 3,
            aura = { [4] = { 194384 }, [5] = { 17, 1253593 }, },
        }
    elseif specIndex == 2 then
        fu.powerType = "MANA"
        fu.blocks = {
            ["施法技能"] = 22,
            ["施法目标"] = 23,
            auras = {
                ["织光者"] = {
                    index = 25,
                    auraRef = fu.auras["织光者"],
                    showKey = "remaining",
                },
                ["织光者层数"] = {
                    index = 26,
                    auraRef = fu.auras["织光者"],
                    showKey = "count",
                },
                ["圣光涌动"] = {
                    index = 27,
                    auraRef = fu.auras["圣光涌动"],
                    showKey = "remaining",
                },
                ["祈福"] = {
                    index = 28,
                    auraRef = fu.auras["祈福"],
                    showKey = "remaining",
                },
            },
            spell_cd = {
                [33076] = { index = 31, name = "愈合祷言" },
                [2050] = { index = 32, name = "圣言术：静", charge = 33 },
                [88625] = { index = 34, name = "圣言术：罚" },
                [527] = { index = 35, name = "纯净术" },
                [19236] = { index = 36, name = "绝望祷言" },
                [200183] = { index = 37, name = "神圣化身" },
                [120517] = { index = 38, name = "光晕" },
                [64843] = { index = 39, name = "神圣赞美诗" },
                [14914] = { index = 40, name = "神圣之火" },
                [8122] = { index = 41, name = "心灵尖啸" },
                [32375] = { index = 42, name = "群体驱散" },
                [232633] = { index = 43, name = "奥术洪流" },
            },
        }
        fu.group_blocks = {
            unit_start = 70,
            block_num = 5,
            healthPercent = 1,
            role = 2,
            dispel = 3,
            aura = { [4] = { 41635 }, [5] = { 139 }, },
        }
    elseif specIndex == 3 then
        fu.powerType = "INSANITY"
        fu.blocks = {

            spell_cd = {
                [8092] = { index = 31, name = "心灵震爆" },
                [32379] = { index = 32, name = "暗言术：灭" },
                [263165] = { index = 33, name = "虚空洪流" },
                [228260] = { index = 34, name = "虚空形态" },
                [1227280] = { index = 35, name = "触须猛击" },
                [19236] = { index = 36, name = "绝望祷言" },
                [8122] = { index = 37, name = "心灵尖啸" },
                [32375] = { index = 38, name = "群体驱散" },
                [15286] = { index = 39, name = "吸血鬼的拥抱" },
                [120644] = { index = 40, name = "光晕" },
            },
        }
    end
end

function fu.CreateClassMacro()
    local dynamicSpells = { "苦修", "快速治疗", "真言术：盾", "愈合祷言", "纯净术", "圣言术：静" }
    local staticSpells = {
        [1] = "心灵震爆",
        [2] = "惩击",
        [3] = "暗言术：痛",
        [4] = "真言术：韧",
        [5] = "神圣新星",
        [6] = "苦修",
        [7] = "真言术：耀",
        [8] = "福音",
        [9] = "终极苦修",
        [10] = "绝望祷言",
        [11] = "暗言术：灭",
        [12] = "吸血鬼之触",
        [13] = "[nostance:1]暗影形态",
        [14] = "暗言术：癫",
        [15] = "精神鞭笞",
        [16] = "虚空形态",
        [17] = "虚空洪流",
        [18] = "触须猛击",
        [19] = "虚空冲击",
        [20] = "虚空齐射",
        [21] = "圣言术：罚",
        [22] = "神圣之火",
        [23] = "治疗祷言",
        [24] = "神圣化身",
        [25] = "奥术洪流",
        [26] = "心灵尖啸",
        [27] = "[@cursor]群体驱散",
        [28] = "[@cursor]真言术：障",
        [29] = "神圣赞美诗",
        [30] = "光晕",
    }

    fu.CreateMacro(dynamicSpells, staticSpells)
end
