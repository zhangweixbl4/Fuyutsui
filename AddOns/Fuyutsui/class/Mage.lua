local _, fu = ...
if fu.classId ~= 8 then return end
local creat = fu.updateOrCreatTextureByIndex

fu.HarmfulSpellId = 116 -- 寒冰箭

local dynamicSpells = { "解除诅咒" }
local specialSpells = {}
local staticSpells = {
    [1] = "寒冰箭",
    [2] = "强化隐形术",
    [3] = "冰霜新星",
    [4] = "法术反制",
    [5] = "变形术",
    [6] = "奥术智慧",
    [7] = "法术吸取",
    [8] = "冰枪术",
    [9] = "寒冰宝珠",
    [10] = "冰霜射线",
    [11] = "冰风暴",
    [12] = "寒冰护体",
    [13] = "暴风雪",
    [14] = "龙息术",
}

function fu.CreateClassMacro()
    fu.CreateMacro(dynamicSpells, staticSpells, specialSpells)
end

-- 更新法术成功效果
function fu.updateSpellSuccess(spellID)
    if not fu.blocks or not fu.blocks.auras then return end
    if spellID == 30455 then -- 冰枪术, 消耗: 寒冰指1层, 消耗:热能真空
        fu.blocks.auras[44544].applications = math.max(0, fu.blocks.auras[44544].applications - 1)
        fu.blocks.auras[1247730].expirationTime = nil
        creat(fu.blocks.auras[44544].index2, fu.blocks.auras[44544].applications / 255)
    elseif spellID == 44614 then -- 冰风暴, 消耗: 冰冷智慧
        fu.blocks.auras[192446].applications = nil
    end
end

-- 更新法术冷却更新
function fu.updateSpellCooldownByEvent(spellId)
    if not fu.blocks or not fu.blocks.auras then return end
    if fu.blocks.auras[spellId] and fu.blocks.auras[spellId].duration then
        -- print(spellId, fu.blocks.auras[spellId].name, fu.blocks.auras[spellId].duration)
        fu.blocks.auras[spellId].expirationTime = GetTime() + fu.blocks.auras[spellId].duration
        if spellId == 44544 then
            fu.blocks.auras[44544].applications = math.min(2, fu.blocks.auras[44544].applications + 1)
            creat(fu.blocks.auras[44544].index2, fu.blocks.auras[44544].applications / 255)
        end
    end
end

function fu.updateSpellIcon(spellId)
    if not fu.blocks then return end
    if fu.blocks.auras[spellId] then
        local overrideSpellID = C_Spell.GetOverrideSpell(spellId)
        if overrideSpellID == 199786 then -- 冰川尖刺
            creat(fu.blocks.auras[116].index, 1 / 255)
        else
            creat(fu.blocks.auras[116].index, 0 / 255)
        end
    end
end

-- 更新法术发光效果
function fu.updateSpellOverlay(spellId)
    if not fu.blocks or not fu.blocks.auras then return end
    local isSpellOverlayed = C_SpellActivationOverlay.IsSpellOverlayed(spellId)
end

-- 更新法术警报, SPELL_ACTIVATION_OVERLAY_SHOW
function fu.spellActivationOverlayShow(spellID)
    if not fu.blocks or not fu.blocks.auras then return end
end

-- 更新法术警报, SPELL_ACTIVATION_OVERLAY_HIDE
function fu.spellActivationOverlayHide(spellID)
    if not fu.blocks or not fu.blocks.auras then return end
end

function fu.updateOnUpdate()
    if not fu.blocks or not fu.blocks.auras then return end
    for _, aura in pairs(fu.blocks.auras) do
        -- 更新法术层数
        if aura.applications and aura.applications <= 0 then
            aura.expirationTime = nil
            creat(aura.index, 0)
        end
        -- 如果有法术持续时间和到期时间, 则更新剩余时间
        if aura.duration then
            if aura.expirationTime then
                aura.remaining = math.floor(aura.expirationTime - GetTime() + 0.5)
                if aura.remaining > 0 then
                    creat(aura.index, aura.remaining / 255)
                else
                    aura.expirationTime = nil
                    creat(aura.index, 0)
                end
            else
                aura.remaining = 0
                if aura.applications then aura.applications = 0 end
                if aura.index2 then creat(aura.index2, 0) end
                creat(aura.index, 0)
            end
        end
    end
end

function fu.updateHeroTalent()
    if fu.blocks.hero_talent then
        local hero_talent = 0
        if C_SpellBook.IsSpellKnown(431044) then
            hero_talent = 1
        elseif C_SpellBook.IsSpellKnown(443739) then
            hero_talent = 2
        elseif C_SpellBook.IsSpellKnown(120517) then
            hero_talent = 3
        end
        creat(fu.blocks.hero_talent, hero_talent / 255)
    end
end

function fu.updateSpecInfo()
    local specIndex = C_SpecializationInfo.GetSpecialization()
    fu.powerType = nil
    fu.blocks = nil
    fu.group_blocks = nil
    fu.assistant_spells = nil
    if specIndex == 1 then
        fu.powerType = "MANA"
        fu.blocks = {
            holyPower = 11,
            target_valid = 12,
            group_type = 13,
            members_count = 14,
            encounterID = 15,
            difficultyID = 16,
            failedSpell = 17,
            auras = {
                [223819] = {
                    name = "神圣意志",
                    index = 18,
                    remaining = 0,
                    duration = 12,
                    expirationTime = nil,
                },
                [54149] = {
                    name = "圣光灌注",
                    index = 19,
                    remaining = 0,
                    duration = 15,
                    expirationTime = nil,
                },
                [414273] = {
                    name = "神性之手",
                    index = 20,
                    remaining = 0,
                    duration = 19.5,
                    applications = 0,
                    expirationTime = nil,
                },
            },
            spell_cd = {
                [20473] = { index = 21, spellId = 20473, name = "神圣震击" },
                [4987] = { index = 22, spellId = 4987, name = "清洁术" },
                [115750] = { index = 23, spellId = 115750, name = "盲目之光", failed = true },
                [275773] = { index = 24, spellId = 275773, name = "审判" },
                [375576] = { index = 25, spellId = 375576, name = "圣洁鸣钟" },
                [114165] = { index = 26, spellId = 114165, name = "神圣棱镜" },
                [31821] = { index = 27, spellId = 31821, name = "光环掌握", failed = true },
                [6940] = { index = 28, spellId = 6940, name = "牺牲祝福" },
                [1044] = { index = 29, spellId = 1044, name = "自由祝福", failed = true },
                [853] = { index = 30, spellId = 853, name = "制裁之锤", failed = true },
                [1022] = { index = 31, spellId = 1022, name = "保护祝福", failed = true },
                [633] = { index = 32, spellId = 633, name = "圣疗术" },
            },
            spell_charge = {
                [20473] = { index = 32, spellId = 20473, name = "神圣震击" },
            },
        }
        fu.group_blocks = {
            unit_start = 40,
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
        fu.assistant_spells = {
        }
    elseif specIndex == 2 then
        fu.HarmfulSpellId = 275779
        fu.powerType = "MANA"
        fu.blocks = {
            holyPower = 11,
            target_valid = 12,
            assistant = 13,
            failedSpell = 14,
            holyBulwark = 15,
            auras = {
                [223819] = {
                    name = "神圣意志",
                    index = 16,
                    remaining = 0,
                    duration = 12,
                    expirationTime = nil,
                },
                [432496] = {
                    name = "神圣壁垒",
                    index = 17,
                    remaining = 0,
                    duration = 20,
                    expirationTime = nil,
                },
                [432502] = {
                    name = "圣洁武器",
                    index = 18,
                    remaining = 0,
                    duration = 20,
                    expirationTime = nil,
                },
                [327510] = {
                    name = "闪耀之光",
                    index = 19,
                    remaining = 0,
                    duration = 30,
                    expirationTime = nil,
                },
            },
            spell_cd = {
                [213644] = { index = 21, spellId = 213644, name = "清毒术" },
                [115750] = { index = 22, spellId = 115750, name = "盲目之光", failed = true },
                [275779] = { index = 23, spellId = 275779, name = "审判" },
                [375576] = { index = 24, spellId = 375576, name = "圣洁鸣钟" },
                [6940] = { index = 25, spellId = 6940, name = "牺牲祝福" },
                [1044] = { index = 26, spellId = 1044, name = "自由祝福", failed = true },
                [853] = { index = 27, spellId = 853, name = "制裁之锤", failed = true },
                [1022] = { index = 28, spellId = 1022, name = "保护祝福", failed = true },
                [432459] = { index = 29, spellId = 432459, name = "神圣壁垒" },
                [31935] = { index = 31, spellId = 31935, name = "复仇者之盾" },
                [26573] = { index = 32, spellId = 26573, name = "奉献" },
                [53600] = { index = 33, spellId = 53600, name = "正义盾击" },
                [204019] = { index = 34, spellId = 204019, name = "祝福之锤" },
            },
            spell_charge = {
                [432459] = { index = 30, spellId = 432459, name = "神圣壁垒" },
            },
        }
        fu.assistant_spells = {
            [375576] = 1, -- 圣洁鸣钟
            [31935] = 2,  -- 复仇者之盾
            [26573] = 3,  -- 奉献
            [275779] = 4, -- 审判
            [53600] = 5,  -- 正义盾击
            [204019] = 6, -- 祝福之锤
        }
    elseif specIndex == 3 then
        fu.powerType = "MANA"
        fu.blocks = {
            assistant = 11,
            target_valid = 12,
            failedSpell = 13,
            hero_talent = 14,
            encounterID = 15,
            difficultyID = 16,
            castingSpell = 17,
            enemy_count = 24,
            auras = {
                [1247730] = { -- cooldown
                    name = "热能真空",
                    index = 18,
                    remaining = 0,
                    duration = 12,
                    expirationTime = nil,
                },
                [116] = { -- icon
                    name = "冰川尖刺！",
                    index = 19,
                    remaining = 0,
                    duration = nil,
                    expirationTime = nil,
                },
                [190446] = { -- cooldown
                    name = "冰冷智慧",
                    index = 20,
                    remaining = 0,
                    duration = 15,
                    expirationTime = nil,
                },
                [270232] = { -- cooldown
                    name = "冰冻之雨",
                    index = 21,
                    remaining = 0,
                    duration = 12,
                    expirationTime = nil,
                },
                [44544] = { -- cooldown
                    name = "寒冰指",
                    index = 22,
                    index2 = 23,
                    remaining = 0,
                    duration = 15,
                    applications = 0,
                    expirationTime = nil,
                },
            },
            spell_cd = {
                [475] = { index = 31, name = "解除诅咒" },
                [110959] = { index = 32, name = "强化隐形术", failed = true },
                [122] = { index = 33, name = "冰霜新星", failed = true },
                [2139] = { index = 34, name = "法术反制" },
                [31661] = { index = 35, name = "龙息术", failed = true },
                [1248829] = { index = 36, name = "暴风雪", failed = true },
                [190356] = { index = 37, name = "暴风雪", failed = true },
                [84714] = { index = 38, name = "寒冰宝珠" },
                [205021] = { index = 39, name = "冰霜射线" },
                [11426] = { index = 40, name = "寒冰护体" },
                [44614] = { index = 41, name = "冰风暴" },
            },
            spell_charge = {
                [44614] = { index = 42, name = "冰风暴" },
            },
        }
        fu.assistant_spells = {
            [116] = 1,    -- 寒冰箭
            [199786] = 2, -- 冰川尖刺
            [30455] = 3,  -- 冰枪术
            [205021] = 4, -- 冰霜射线
            [44614] = 5,  -- 冰风暴
            [1459] = 6,   -- 奥术智慧
            [84714] = 7,  -- 寒冰宝珠
        }
        fu.updateSpellIcon(116)
    end
end
