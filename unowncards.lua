-- Begin Unown

mod_dir = '' .. SMODS.current_mod.path
unown_config = SMODS.current_mod.config
pokermon_config = SMODS.Mods["Pokermon"].config

AnimatedPokemon.j_poke_unown = { frames_per_row = 12, frames = 36, fps = 12, soul = true, size = { x = 290, y = 285 } }

--Load functions
local functions = NFS.getDirectoryItems(mod_dir .. "functions")

for _, file in ipairs(functions) do
  sendDebugMessage("The file is: " .. file)
  local func_code, load_error = SMODS.load_file("functions/" .. file)
  if load_error then
    sendDebugMessage("The error is: " .. load_error)
  else
    func_code()
  end
end

--Load deck
local backs = NFS.getDirectoryItems(mod_dir .. "backs")

for _, file in ipairs(backs) do
  sendDebugMessage("The file is: " .. file)
  local back, load_error = SMODS.load_file("backs/" .. file)
  if load_error then
    sendDebugMessage("The error is: " .. load_error)
  else
    local curr_back = back()
    if curr_back.init then curr_back:init() end

    for i, item in ipairs(curr_back.list) do
      SMODS.Back(item)
    end
  end
end


--Load Sleeves
if (SMODS.Mods["CardSleeves"] or {}).can_load then
  local sleeves = NFS.getDirectoryItems(mod_dir .. "sleeves")

  for _, file in ipairs(sleeves) do
    sendDebugMessage("the file is: " .. file)
    local sleeve, load_error = SMODS.load_file("sleeves/" .. file)
    if load_error then
      sendDebugMessage("The error is: " .. load_error)
    else
      local curr_sleeve = sleeve()
      if curr_sleeve.init then curr_sleeve.init() end

      for i, item in ipairs(curr_sleeve.list) do
        CardSleeves.Sleeve(item)
      end
    end
  end
end


--Load joker file
local jfiles = NFS.getDirectoryItems(mod_dir .. "jokers")

for _, file in ipairs(jfiles) do
  sendDebugMessage("The file is: " .. file)
  local joker, load_error = SMODS.load_file("jokers/" .. file)
  if load_error then
    sendDebugMessage("The error is: " .. load_error)
  else
    local curr_joker = joker()
    if curr_joker.init then curr_joker:init() end

    if curr_joker.list and #curr_joker.list > 0 then
      for i, item in ipairs(curr_joker.list) do
        item.discovered = true
        if not item.key then
          item.key = item.name
        end
        if not item.custom_pool_func then
          item.in_pool = function(self)
            return pokemon_in_pool(self)
          end
        end
        if not item.config then
          item.config = {}
        end
        if item.ptype then
          if item.config and item.config.extra then
            item.config.extra.ptype = item.ptype
          elseif item.config then
            item.config.extra = { ptype = item.ptype }
          end
        end
        if item.item_req then
          if item.config and item.config.extra then
            item.config.extra.item_req = item.item_req
          elseif item.config then
            item.config.extra = { item_req = item.item_req }
          end
        end
        if item.evo_list then
          if item.config and item.config.extra then
            item.config.extra.evo_list = item.evo_list
          elseif item.config then
            item.config.extra = { item_req = item.evo_list }
          end
        end
        item.discovered = not pokermon_config.pokemon_discovery
        local prev_load = item.load
        item.load = function(self, card, card_table, other_card)
          card_table.ability.extra.juiced = nil
          if type(self.calculate) == "function" then
            G.E_MANAGER:add_event(Event({
              func = function()
                self.calculate(self, card, { poke_load = true })
                return true
              end
            }))
          end
          if prev_load then
            prev_load(self, card, card_table, other_card)
          end
        end
        SMODS.Joker(item)
      end
    end
  end
end
