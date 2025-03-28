SMODS.Atlas({
   key = "j_poke_unown",
   path = "j_poke_unown.png",
   px = 290,
   py = 285
}):register()

SMODS.Atlas({
   key = "j_poke_unown_shiny",
   path = "j_poke_unown_shiny.png",
   px = 290,
   py = 285
}):register()

SMODS.Atlas({
   key = "j_poke_unown_soul",
   path = "j_poke_unown_soul.png",
   px = 290,
   py = 285
}):register()

SMODS.Atlas({
   key = "j_poke_unown_shiny_soul",
   path = "j_poke_unown_shiny_soul.png",
   px = 290,
   py = 285
}):register()

SMODS.Atlas({
   key = "fake_stickers",
   path = "fake_stickers.png",
   px = 290,
   py = 285
}):register()

SMODS.Atlas({
   key = "fake_poke_pinkseal",
   path = "fake_types.png",
   px = 290,
   py = 285
}):register()

SMODS.Atlas({
   key = "logo",
   path = "Pokermon.png",
   px = 389,
   py = 216
})

SMODS.Atlas({
   key = "symboldeck",
   path = "symboldeck.png",
   px = 71,
   py = 95
}):register()

SMODS.Atlas({
   key = "Unown",
   path = "UnownDeck.png",
   px = 71,
   py = 95
}):register()

SMODS.Atlas({
   key = "Unown_hc",
   path = "UnownDeck.png",
   px = 71,
   py = 95
}):register()

SMODS.Atlas({
   key = "pokeui_assets",
   path = "pokeui_assets.png",
   px = 18,
   py = 18
}):register()

SMODS.Atlas({
   key = "pokeui_assets_hc",
   path = "pokeui_assets.png",
   px = 18,
   py = 18
}):register()

function swap_sprites_sizes(undo)
   for k, v in pairs(SMODS.Stickers) do
      local atlas = G.shared_stickers[v.key].atlas.name
      if undo then
         if atlas == 'poke_fake_stickers' then
            G.shared_stickers[v.key].atlas = G.ASSET_ATLAS['stickers']
         elseif atlas == 'poke_fake_poke_pinkseal' then
            G.shared_stickers[v.key].atlas = G.ASSET_ATLAS['poke_pinkseal']
         end
      else
         if atlas == 'stickers' then
            G.shared_stickers[v.key].atlas = G.ASSET_ATLAS['poke_fake_stickers']
         elseif atlas == 'poke_pinkseal' then
            G.shared_stickers[v.key].atlas = G.ASSET_ATLAS['poke_fake_poke_pinkseal']
         end
      end
   end
end