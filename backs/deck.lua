local symboldeck = {
  name = "symboldeck",
  key = "symboldeck",
  config = {},
  loc_vars = function(self, info_queue, center)
     return { vars = {} }
  end,
  pos = { x = 0, y = 0 },
  atlas = "symboldeck",
  apply = function(self)
     G.GAME.Unown = true
     G.GAME.starting_params.unown_cards = true

     G.E_MANAGER:add_event(Event({
        func = function()
           for k, v in pairs(G.playing_cards) do
              if v.base.suit == 'poke_Unown' and G.GAME.starting_params.erratic_suits_and_ranks then
                 local new_rank = pseudorandom_element(poke_unown_rank_names, pseudoseed('erratic'), {starting_deck = true})
                 SMODS.change_base(v, 'poke_Unown', new_rank)
              end
           end
           return true
        end
     }))
  end
}

return {name = "Back",
        list = {symboldeck},
}
