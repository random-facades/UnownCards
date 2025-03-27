local unown = {
   name = "awakened_unown",
   pos = { x = 0, y = 0 },
   soul_pos = {
      x = 0,
      y = 0,
      draw = function(card, scale_mod, rotate_mod)
         card.children.center.VT.w = card.T.w
         card.children.floating_sprite:draw_shader('dissolve', 0, nil, nil, card.children.center, scale_mod, rotate_mod,
            nil, 0.1 + 0.03 * math.sin(1.8 * G.TIMERS.REAL), nil, 0.6)
         card.children.floating_sprite:draw_shader('dissolve', nil, nil, nil, card.children.center, scale_mod, rotate_mod)
         card.children.center.VT.w = card.T.w * 1.174
      end
   },
   config = { extra = { mult = 4 } },
   loc_vars = function(self, info_queue, card)
      type_tooltip(self, info_queue, card)
      local count = 0
      if G.playing_cards and #G.playing_cards > 0 then
         for k, v in pairs(G.playing_cards) do
            if v.base and v.base.suit == 'poke_Unown' then
               count = count + 1
            end
         end
      end
      return { vars = { card.ability.extra.mult, card.ability.extra.mult * count } }
   end,
   rarity = 'poke_safari',
   cost = 10,
   stage = "Other",
   atlas = "j_poke_awakened_unown",
   blueprint_compat = true,
   calculate = function(self, card, context)
      if context.cardarea == G.jokers and context.scoring_hand then
         if context.joker_main then
            local count = 0
            for k, v in pairs(G.playing_cards) do
               if v.base and v.base.suit == 'poke_Unown' then
                  count = count + 1
               end
            end
            return {
               message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult * count } },
               colour = G.C.MULT,
               mult_mod = card.ability.extra.mult * count
            }
         end
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
   update = function(self, card, dt)
      card.children.center.VT.x = card.T.x - (G.CARD_H - G.CARD_W) / 2
      card.children.floating_sprite.VT.x = card.children.center.VT.x
      card.children.center.VT.w = card.T.w * 1.174
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
      if context.setting_blind then
         local to_change = {}
         for _, v in pairs(G.playing_cards) do
            if not v.base or v.base.suit ~= 'poke_Unown' then
               table.insert(to_change, v)
            end
         end
         if #to_change then
            local target = pseudorandom_element(to_change, pseudoseed('alph_ruins'))
            G.E_MANAGER:add_event(Event({
               func = function()
                  SMODS.change_base(target, 'poke_Unown')
                  return true
               end
            }))
         end
      end
   end,
   add_to_deck = function(self, card, from_debuff)
      G.GAME.Unown = true
      if not from_debuff then
         local cards = {}
         local to_create = { 'poke_Unown_poke_UU', 'poke_Unown_poke_UN', 'poke_Unown_poke_UO', 'poke_Unown_poke_UW', 'poke_Unown_poke_UN' }
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
