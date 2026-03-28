local _, fu = ...
local creat = fu.updateOrCreatTextureByIndex

-- 更新法术成功效果
function fu.updateSpellSuccess(spellID)
    if not fu.blocks or not fu.blocks.auras then return end
end

-- 更新法术冷却更新
function fu.updateSpellCooldownByEvent(spellId)
    if not fu.blocks or not fu.blocks.auras then return end
    if fu.blocks.auras[spellId] and fu.blocks.auras[spellId].duration then

    end
end

function fu.updateSpellIcon(spellId)
    if not fu.blocks then return end
    if fu.blocks.auras[spellId] then
        local overrideSpellID = C_Spell.GetOverrideSpell(spellId)

        if overrideSpellID == 0000 then

        else

        end
    end
end

-- 更新法术发光效果
function fu.updateSpellOverlay(spellId)
    if not fu.blocks or not fu.blocks.auras then return end
    local isSpellOverlayed = C_SpellActivationOverlay.IsSpellOverlayed(spellId)
    if fu.blocks.auras[spellId] then
        if isSpellOverlayed then

        else

        end
    end
end

-- 更新法术警报, SPELL_ACTIVATION_OVERLAY_SHOW
function fu.spellActivationOverlayShow(spellID)
    if not fu.blocks or not fu.blocks.auras then return end

end

-- 更新法术警报, SPELL_ACTIVATION_OVERLAY_HIDE
function fu.spellActivationOverlayHide(spellID)
    if not fu.blocks or not fu.blocks.auras then return end

end
