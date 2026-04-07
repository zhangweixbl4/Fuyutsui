local _, fu = ...
if fu.classId ~= 3 then return end

function fu.updateSpecInfo()
    local specIndex = C_SpecializationInfo.GetSpecialization()
    fu.powerType = nil
    fu.blocks = nil
    fu.group_blocks = nil

    -- 專精 1：野獸控制 (Beast Mastery)
    if specIndex == 1 then
        fu.HarmfulSpellId = 193455 -- 眼鏡蛇射擊
        fu.blocks = {
            spell_cd = {
                [34026]  = { index = 31, name = "杀戮命令", charge = 32 },
                [217200] = { index = 33, name = "倒刺射击", charge = 34 },
                [109304] = { index = 35, name = "意气风发" },
                [186265] = { index = 36, name = "灵龟守护" },
                [147362] = { index = 37, name = "反制射击" },
                [19574]  = { index = 26, name = "狂野怒火" },
            },
        }
    elseif specIndex == 2 then
        fu.HarmfulSpellId = 19434 -- 瞄準射擊
        fu.blocks = {

            spell_cd = {
                [109304] = { index = 21, name = "意气风发" },
                [186265] = { index = 22, name = "灵龟守护" },
                [147362] = { index = 23, name = "反制射击" },
                [19434]  = { index = 24, name = "瞄准射击" ,charge = 30},
                [257044] = { index = 25, name = "急速射击" },
                [288613] = { index = 26, name = "百发百中" },
            },
        }
    end
end

-- 創建獵人巨集
function fu.CreateClassMacro()
    local dynamicSpells = {}
    local specialSpells = {}
    local staticSpells = {
        [1] = "意气风发",
        [2] = "灵龟守护",
        [3] = "反制射击",
        [4] = "多重射击",
        [5] = "狂野怒火",
        [6] = "夺命射击",
        [7] = "百发百中",
        [8] = "爆炸射击",
        [9] = "荒野呼唤",
        [10] = "血溅十方",
        [11] = "治疗宠物",
        [12] = "倒刺射击",
        [13] = "杀戮命令",
        [14] = "眼镜蛇射击",
        [15] = "瞄准射击",
        [16] = "急速射击",
        [17] = "稳固射击",
        [18] = "哀恸箭",
        [19] = "猎人印记",
        [20] = "奥术射击",
        [21] = "奇美拉射击",
        [22] = "夺命黑鸦",
        [23] = "弹幕射击",
    }
    fu.CreateMacro(dynamicSpells, staticSpells, specialSpells)
end
