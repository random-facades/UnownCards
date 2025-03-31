local jd_def = JokerDisplay.Definitions


-- Pokedex
jd_def["j_poke_unown"] = {
    text = {
        { text = "+",                              colour = G.C.MULT },
        {ref_table = "card.joker_display_values", ref_value = "mult", colour = G.C.MULT},
    },
    reminder_text = {
        { text = "(" },
        { ref_table = "card.joker_display_values", ref_value = "localized_text", colour = G.C.DARK_EDITION, scale = 0.35 },
        { text = ")" }
    },

    extra_config = { colour = G.C.GREEN, scale = 0.3 },
    calc_function = function(card)
        local count = 0
        if G.play then
            local text, _, scoring_hand = JokerDisplay.evaluate_hand()
            if text ~= 'Unknown' then
                for _, scoring_card in pairs(scoring_hand) do
                    if scoring_card:is_suit("poke_Unown") then
                        count = count +
                            JokerDisplay.calculate_card_triggers(scoring_card, scoring_hand)
                    end
                end
            end
        else
            count = 3
        end
        card.joker_display_values.mult = count * card.ability.extra.mult
        card.joker_display_values.localized_text = "Unown"
    end
}
