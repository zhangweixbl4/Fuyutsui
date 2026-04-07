# -*- coding: utf-8 -*-

from utils import *

def run_monk_logic(state_dict, spec_name):
    spells = state_dict.get("spells") or {}
    战斗 = state_dict.get("战斗")
    移动 = state_dict.get("移动")
    施法 = state_dict.get("施法")
    引导 = state_dict.get("引导")
    生命值 = state_dict.get("生命值")
    能量值 = state_dict.get("能量值")
    一键辅助 = state_dict.get("一键辅助")
    法术失败 = state_dict.get("法术失败", 0)
    目标有效 = state_dict.get("目标有效")
    队伍类型 = int(state_dict.get("队伍类型", 0) or 0)
    队伍人数 = int(state_dict.get("队伍人数", 0) or 0)
    首领战 = int(state_dict.get("首领战", 0) or 0)
    难度 = int(state_dict.get("难度", 0) or 0)
    英雄天赋 = int(state_dict.get("英雄天赋", 0) or 0)
    

    action_hotkey = None
    current_step = "无匹配技能"
    unit_info = {}

    if spec_name == "酒仙":
        酒池 = state_dict.get("酒池", 0)
        目标生命值 = state_dict.get("目标生命值", 0)
        敌人人数 = state_dict.get("敌人人数", 0)
        活力苏醒 = state_dict.get("活力苏醒", 0)
        疗伤珠 = state_dict.get("疗伤珠", 0)
        清空地窖 = state_dict.get("清空地窖", 0)

        醉酿投 = spells.get("醉酿投", 0)
        醉酿充能 = spells.get("醉酿充能", 0)
        活血酒 = spells.get("活血酒", 0)
        活血充能 = spells.get("活血充能", 0)
        天神酒 = spells.get("天神酒", 0)
        天神充能 = spells.get("天神充能", 0)
        天神灌注 = spells.get("天神灌注", 0)
        灌注充能 = spells.get("灌注充能", 0)
        轮回之触 = spells.get("轮回之触", 0)
        扫堂腿 = spells.get("扫堂腿", 0)
        移花接木 = spells.get("移花接木", 0)
        魂体双分 = spells.get("魂体双分", 0)
        转移 = spells.get("魂体双分：转移", 0)
        切喉手 = spells.get("切喉手", 0)
        火焰之息 = spells.get("火焰之息", 0)
        真气爆裂 = spells.get("真气爆裂", 0)
        爆炸酒桶 = spells.get("爆炸酒桶", 0)
        赤精之歌 = spells.get("赤精之歌", 0)

        if 引导 > 0:
            current_step = "在引导,不执行任何操作"
            return None, current_step, unit_info

        if 战斗 and 目标有效:
            if 酒池 > 10 and 天神酒 == 0 and 天神充能 == 0:
                current_step = "施放 天神酒"
                action_hotkey = get_hotkey(0, "天神酒")
            elif 酒池 > 10 and 天神灌注 == 0 and 灌注充能 == 0:
                current_step = "施放 天神灌注"
                action_hotkey = get_hotkey(0, "天神灌注")
            elif 酒池 > 20 and 活血酒 == 0 and 活血充能 == 0:
                current_step = "施放 活血酒"
                action_hotkey = get_hotkey(0, "活血酒")
            elif 酒池 > 40 and 活血酒 < 1:
                current_step = "施放 活血酒"
                action_hotkey = get_hotkey(0, "活血酒")
            elif 移花接木 == 0 and 疗伤珠 >= 3 and 生命值 < 80:
                current_step = "施放 移花接木"
                action_hotkey = get_hotkey(0, "移花接木")
            elif 活力苏醒 > 0 and 生命值 < 80:
                current_step = "施放 [@player]活血术"
                action_hotkey = get_hotkey(1, "活血术")
            elif 醉酿投 > 3 and 爆炸酒桶 == 0:
                current_step = "施放 爆炸酒桶"
                action_hotkey = get_hotkey(0, "爆炸酒桶")
            elif 清空地窖 > 0:
                current_step = "施放 爆炸酒桶"
                action_hotkey = get_hotkey(0, "爆炸酒桶")
            elif 醉酿投 < 1:
                current_step = "施放 醉酿投"
                action_hotkey = get_hotkey(0, "醉酿投")
            else:
                action_map = {
                1: ("轮回之触", "轮回之触"),
                2: ("猛虎掌", "猛虎掌"),
                3: ("神鹤引项踢", "神鹤引项踢"),
                4: ("幻灭踢", "幻灭踢"),
                5: ("爆炸酒桶", "爆炸酒桶"),
                6: ("真气爆裂", "真气爆裂"),
                7: ("醉酿投", "醉酿投"),
                8: ("火焰之息", "火焰之息"),
                9: ("碧玉疾风", "碧玉疾风"),
            }
                tup = action_map.get(一键辅助)
                if tup:
                    current_step = f"施放 {tup[0]}"
                    action_hotkey = get_hotkey(0, tup[1])
                else:
                    current_step = "战斗中-无匹配技能"
        else:
            current_step = "非战斗状态,不执行任何操作"

    elif spec_name == "织雾":
        敌人人数 = state_dict.get("敌人人数", 0)
        施法技能 = state_dict.get("施法技能", 0)
        施法目标 = state_dict.get("施法目标", 0)

        法力茶层数 = state_dict.get("法力茶层数", 0)
        生生不息1 = state_dict.get("生生不息1", 0)
        生生不息2 = state_dict.get("生生不息2", 0)
        神龙层数 = state_dict.get("神龙层数", 0)
        灵泉 = state_dict.get("灵泉", 0)

        雷光茶 = spells.get("雷光茶", 0)
        雷光充能 = spells.get("雷光充能", 0)
        复苏之雾 = spells.get("复苏之雾", 0)
        复苏充能 = spells.get("复苏充能", 0)
        还魂术 = spells.get("还魂术", 0)
        作茧缚命 = spells.get("作茧缚命", 0)
        清创生血 = spells.get("清创生血", 0)
        天神御身 = spells.get("天神御身", 0)
        轮回之触 = spells.get("轮回之触", 0)
        扫堂腿 = spells.get("扫堂腿", 0)
        宁神茶 = spells.get("宁神茶", 0)
        魂体双分 = spells.get("魂体双分", 0)
        转移 = spells.get("魂体双分：转移", 0)
        
        无复苏单位, 无复苏生命值 = get_lowest_health_unit_without_aura(state_dict, "复苏之雾", 101)
        无氤氲单位, 无氤氲生命值 = get_lowest_health_unit_without_aura(state_dict, "氤氲之雾", 101)
        count90 = get_count_units_below_health(state_dict, 90)
        count80 = get_count_units_below_health(state_dict, 80)



    elif spec_name == "踏风":
        current_step = "踏风专精,不执行任何操作"
        return None, current_step, unit_info

    return action_hotkey, current_step, unit_info