# -*- coding: utf-8 -*-

from utils import *

def run_hunter_logic(state_dict, spec_name):
    spells = state_dict.get("spells") or {}
    生命值 = state_dict.get("生命值")
    能量值 = state_dict.get("能量值")
    一键辅助 = state_dict.get("一键辅助")
    目标有效 = state_dict.get("目标有效")
    战斗 = state_dict.get("战斗")
    施法 = state_dict.get("施法")
    引导 = state_dict.get("引导")
    移动 = state_dict.get("移动")
  
    action_hotkey = None
    current_step = "无匹配技能"
    unit_info = {}

    if spec_name == "兽王":
        if 引导 > 0:
            current_step = "在引导,不执行任何操作"
            return None, current_step, unit_info

        if 战斗 and 目标有效:
            action_map = {
            1: ("杀戮命令", "杀戮命令"),
            2: ("倒刺射击", "倒刺射击"),
            3: ("眼镜蛇射击", "眼镜蛇射击"),
            4: ("狂野怒火", "狂野怒火"),
            5: ("荒野呼唤", "荒野呼唤"),
            6: ("夺命黑鸦", "夺命黑鸦"),
            7: ("弹幕射击", "弹幕射击"),
            8: ("血溅十方", "血溅十方"),
        }
            tup = action_map.get(一键辅助)
            if tup:
                current_step = f"施放 {tup[0]}"
                action_hotkey = get_hotkey(0, tup[1])
            else:
                current_step = "战斗中-无匹配技能"
        else:
            current_step = "非战斗状态,不执行任何操作"
    elif spec_name == "射击":
        return action_hotkey, current_step, unit_info
    elif spec_name == "生存":
        current_step = "无匹配技能"
        return None, current_step, unit_info
    return action_hotkey, current_step, unit_info