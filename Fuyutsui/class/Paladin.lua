local _, fu = ...
if fu.classId ~= 2 then return end

fu.HelpfulSpellId = 62124
fu.HarmfulSpellId = 275773

function fu.updateSpecInfo()
    local specIndex = C_SpecializationInfo.GetSpecialization()
    fu.powerType = nil
    fu.blocks = nil
    fu.group_blocks = nil
    fu.assistant_spells = nil
    if specIndex == 1 then
        fu.powerType = "MANA"
        fu.blocks = {
            holyPower = 21,
            ["施法技能"] = 22,
            ["施法目标"] = 23,
            auras = {
                ["神圣意志"] = {
                    index = 25,
                    auraRef = fu.auras["神圣意志"],
                    showKey = "remaining",
                },
                ["圣光灌注"] = {
                    index = 26,
                    auraRef = fu.auras["圣光灌注"],
                    showKey = "remaining",
                },
                ["神性层数"] = {
                    index = 27,
                    auraRef = fu.auras["神性之手"],
                    showKey = "count",
                },
            },
            spell_cd = {
                [20473] = { index = 28, name = "神圣震击", charge = 29},
                [4987] = { index = 30, name = "清洁术" },
                [115750] = { index = 31, name = "盲目之光" },
                [275773] = { index = 32, name = "审判" },
                [375576] = { index = 33, name = "圣洁鸣钟" },
                [114165] = { index = 34, name = "神圣棱镜" },
                [31821] = { index = 35, name = "光环掌握" },
                [6940] = { index = 36, name = "牺牲祝福" },
                [1044] = { index = 37, name = "自由祝福" },
                [853] = { index = 38, name = "制裁之锤" },
                [1022] = { index = 39, name = "保护祝福" },
                [633] = { index = 40, name = "圣疗术" },
            },
        }
        fu.group_blocks = {
            unit_start = 70,
            block_num = 6,
            healthPercent = 1,
            role = 2,
            dispel = 3,
            aura = {
                [4] = { 156322 },        -- 永恒之火
                [5] = { 1244893 },       -- 救世道标
                [6] = { 53563, 156910 }, -- 圣光道标, 信仰道标
            },
        }
    elseif specIndex == 2 then
        fu.HarmfulSpellId = 275779
        fu.powerType = "MANA"
        fu.blocks = {
            holyPower = 21,
            auras = {
                ["神圣意志"] = {
                    index = 22,
                    auraRef = fu.auras["神圣意志"],
                    showKey = "remaining",
                },
                ["神圣壁垒"] = {
                    index = 23,
                    auraRef = fu.auras["神圣壁垒"],
                    showKey = "remaining",
                },
                ["圣洁武器"] = {
                    index = 24,
                    auraRef = fu.auras["圣洁武器"],
                    showKey = "remaining",
                },
                ["闪耀之光"] = {
                    index = 25,
                    auraRef = fu.auras["闪耀之光"],
                    showKey = "remaining",
                },
                ["神圣军备"] = {
                    index = 26,
                    auraRef = fu.updateAuras.byIcon[432459],
                    showKey = "isIcon",
                },
            },
            spell_cd = {
                [432459] = { index = 31, spellId = 432459, name = "神圣壁垒", charge = 32 },
                [213644] = { index = 33, spellId = 213644, name = "清毒术" },
                [115750] = { index = 34, spellId = 115750, name = "盲目之光" },
                [275779] = { index = 35, spellId = 275779, name = "审判" },
                [375576] = { index = 36, spellId = 375576, name = "圣洁鸣钟" },
                [6940] = { index = 37, spellId = 6940, name = "牺牲祝福" },
                [1044] = { index = 38, spellId = 1044, name = "自由祝福" },
                [853] = { index = 39, spellId = 853, name = "制裁之锤" },
                [1022] = { index = 40, spellId = 1022, name = "保护祝福" },
                [31935] = { index = 41, spellId = 31935, name = "复仇者之盾" },
                [26573] = { index = 42, spellId = 26573, name = "奉献" },
                [53600] = { index = 43, spellId = 53600, name = "正义盾击" },
                [204019] = { index = 44, spellId = 204019, name = "祝福之锤" },
                [642] = { index = 45, spellId = 642, name = "圣盾术" },
            },
        }
    elseif specIndex == 3 then
        fu.HarmfulSpellId = 20271
        fu.powerType = "MANA"
        fu.blocks = {
            holyPower = 21,
            auras = {
                ["神圣意志"] = {
                    index = 22,
                    auraRef = fu.auras["神圣意志"],
                    showKey = "remaining",
                },
            },
            spell_cd = {
                [213644] = { index = 31, spellId = 213644, name = "清毒术" },
                [115750] = { index = 32, spellId = 115750, name = "盲目之光" },
                [20271] = { index = 33, spellId = 20271, name = "审判" ,charge = 42},
                [375576] = { index = 34, spellId = 375576, name = "圣洁鸣钟" },
                [6940] = { index = 35, spellId = 6940, name = "牺牲祝福" },
                [1044] = { index = 36, spellId = 1044, name = "自由祝福" },
                [853] = { index = 37, spellId = 853, name = "制裁之锤" },
                [1022] = { index = 38, spellId = 1022, name = "保护祝福" },
                [184575] = { index = 39, spellId = 184575, name = "公正之剑" },
                [343527] = { index = 40, spellId = 343527, name = "处决宣判" },
                [255937] = { index = 41, spellId = 255937, name = "灰烬觉醒" },
            },
        }
    end
end

-- 创建圣骑士宏
function fu.CreateClassMacro()
    local dynamicSpells = { "神圣震击", "圣光闪现", "圣光术", "荣耀圣令", "清洁术", "圣疗术" }
    local specialSpells = {}
    local staticSpells = {
        [1] = "牺牲祝福",
        [2] = "代祷",
        [3] = "圣盾术",
        [4] = "盲目之光",
        [5] = "[@mouseover]保护祝福",
        [6] = "审判",
        [7] = "制裁之锤",
        [8] = "光环掌握",
        [9] = "圣洁鸣钟",
        [10] = "正义盾击",
        [11] = "黎明之光",
        [12] = "[@mouseover]自由祝福",
        [13] = "神圣棱镜",
        [14] = "神圣震击",
        [15] = "公正之剑",
        [16] = "圣洁鸣钟",
        [17] = "处决宣判",
        [18] = "最终审判",
        [19] = "复仇之怒",
        [20] = "灰烬觉醒",
        [21] = "复仇者之盾",
        [22] = "责难",
        [23] = "远古列王守卫",
        [24] = "祝福之锤",
        [25] = "炽热防御者",
        [26] = "[@mouseover]破咒祝福",
        [27] = "神圣风暴",
        [28] = "奉献",
        [29] = "神圣壁垒",
        [30] = "[@player]荣耀圣令",
    }
    fu.CreateMacro(dynamicSpells, staticSpells, specialSpells)
end
