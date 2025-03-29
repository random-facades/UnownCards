local unown = {
   name = "unown",
   pos = { x = 0, y = 0 },
   soul_pos = { x = 0, y = 0, },
   config = { extra = { mult = 7 } },
   loc_vars = function(self, info_queue, card)
      type_tooltip(self, info_queue, card)
      return { vars = { card.ability.extra.mult } }
   end,
   rarity = 'poke_safari',
   cost = 10,
   stage = "Other",
   atlas = "j_poke_unown",
   blueprint_compat = true,
   calculate = function(self, card, context)
      if context.setting_blind then
         local to_change = {}
         for _, v in pairs(G.playing_cards) do
            if not v.base or v.base.suit ~= 'poke_Unown' then
               table.insert(to_change, v)
            end
         end
         if #to_change > 0 then
            local target = pseudorandom_element(to_change, pseudoseed('unown_joker'))
            G.E_MANAGER:add_event(Event({
               func = function()
                  SMODS.change_base(target, 'poke_Unown')
                  return true
               end
            }))
         end
      end
      if context.individual and context.cardarea == G.play and context.other_card.base.suit == 'poke_Unown' then
         return {
            mult = card.ability.extra.mult,
            card = card
         }
      end
   end,
   set_sprites = function(self, card, front)
      if self.discovered or card.bypass_discovery_center then
         card.children.center:reset()
         if card.children.floating_sprite then
            card.children.floating_sprite.atlas = G.ASSET_ATLAS[card.children.center.atlas.name .. "_soul"]
            card.children.floating_sprite:reset()
         end
      end
   end,
   pre_draw = function(self, card, drawStep)
      local center = card.children.center
      -- trigger on shadow or first draw
      if drawStep.order <= -999 then
         center.VT.x = card.T.x - (card.T.h - card.T.w) / 2
         card.children.floating_sprite.VT.x = center.VT.x
         center.VT.w = card.T.w * 1.17
      elseif drawStep.key == 'seal' then
         swap_sprites_sizes(false)
         center.prev_scale_mag = center.scale_mag
         center.scale_mag = center.scale_mag / 3
         center.VT.w = card.T.h * 290 / 285
         center.VT.x = card.T.x - (card.T.h - card.T.w) * 0.66
      elseif drawStep.key == 'soul' then
         swap_sprites_sizes(true)
         center.scale_mag = center.prev_scale_mag
         center.VT.w = card.T.w * 1.17
         center.VT.x = card.T.x - (card.T.h - card.T.w) / 2
      elseif drawStep.key == 'floating_sprite' then
         center.VT.w = card.T.w
      elseif drawStep.key == 'debuff' then
         center.VT.w = card.T.w * 1.17
      end
   end,
}

local alph_ruins = {
   name = "alph_ruins",
   pos = { x = 1, y = 2 },
   config = { extra = {} },
   loc_vars = function(self, info_queue, center)
      type_tooltip(self, info_queue, center)
      return { vars = {} }
   end,
   rarity = 2,
   cost = 7,
   stage = "Other",
   atlas = "others",
   blueprint_compat = true,
   calculate = function(self, card, context)
      if context.after and #context.full_hand > 0 then
         local to_change = {}
         for _, v in pairs(context.full_hand) do
            if not v.unown_target and (not v.base or v.base.suit ~= 'poke_Unown') then
               table.insert(to_change, v)
            end
         end
         if #to_change > 0 then
            local target = pseudorandom_element(to_change, pseudoseed('alph_ruins'))
            target.unown_target = true
            poke_conversion_event_helper(function() target:flip(); card:juice_up(0.3, 0.3) end)
            poke_conversion_event_helper(function() SMODS.change_base(target, 'poke_Unown'); target.unown_target = nil end)
            poke_conversion_event_helper(function() target:flip() end)
            delay(0.8)
         end
      end
   end,
   add_to_deck = function(self, card, from_debuff)
      G.GAME.Unown = true
      check_for_unlock({type = 'unown_cards'})
      if not from_debuff then
         local cards = {}
         local to_create = { 'poke_Unown_poke_UU', 'poke_Unown_poke_UN', 'poke_Unown_poke_UO', 'poke_Unown_poke_UW',
            'poke_Unown_poke_UN' }
         for i, v in pairs(to_create) do
            cards[i] = create_playing_card({ front = G.P_CARDS[v] }, G.deck, nil, nil, { G.C.PURPLE })
         end
         playing_card_joker_effects(cards)
      end
   end,
}

return {
   name = "Unown Jokers",
   list = { unown, alph_ruins },
}
