-- Welcome to en-us.lua!
-- friendly reminder that in the us we say things like "color" and not "colour"
-- This is also the default file, if there are things here that are "missing" from other files it will use this one instead


return {
   descriptions = {
      Back = {
         b_poke_symboldeck = {
            name = "Symbolic Deck",
            text = {
               "Let the {C:dark_edition}UNOWN{} guide you"
            }
         },
      },
      Joker = {
         j_poke_alph_ruins = {
            name = "Alph Ruins",
            text = {
               "Holding {C:dark_edition}U N O W N{}",
               "When Blind is selected,",
               "a card in your deck becomes {C:dark_edition}Unown{}",
            }
         },
         j_poke_awakened_unown = {
            name = "Unown",
            text = {
               "{C:mult}+#1#{} Mult for each Unown in deck",
               "{C:inactive}(Currently {C:mult}+#2#{C:inactive} Mult)",
            }
         },
      },
      Sleeve = {},
      Other = {
         poke_unown_exclaim = {
            name = "Unown Symbol - !",
            text = {
               "Gives {C:mult}+20{} Mult",
               "if last played card",
               "{C:inactive,s:0.8}(Multiple {C:dark_edition,s:0.8}!{C:inactive,s:0.8} or {C:dark_edition,s:0.8}?{C:inactive,s:0.8} will stack)",
            },
         },
         poke_unown_question = {
            name = "Unown Symbol - ?",
            text = {
               "Gives {C:chips}+100{} Chips",
               "if last played card",
               "{C:inactive,s:0.8}(Multiple {C:dark_edition,s:0.8}!{C:inactive,s:0.8} or {C:dark_edition,s:0.8}?{C:inactive,s:0.8} will stack)",
            },
         },
      },
   },
   misc = {
      dictionary = {
         k_maybe_next_time = "Maybe Next Time?",
      },
      ranks = {
         poke_UA = 'A',
         poke_UB = 'B',
         poke_UC = 'C',
         poke_UD = 'D',
         poke_UE = 'E',
         poke_UF = 'F',
         poke_UG = 'G',
         poke_UH = 'H',
         poke_UI = 'I',
         poke_UJ = 'J',
         poke_UK = 'K',
         poke_UL = 'L',
         poke_UM = 'M',
         poke_UN = 'N',
         poke_UO = 'O',
         poke_UP = 'P',
         poke_UQ = 'Q',
         poke_UR = 'R',
         poke_US = 'S',
         poke_UT = 'T',
         poke_UU = 'U',
         poke_UV = 'V',
         poke_UW = 'W',
         poke_UX = 'X',
         poke_UY = 'Y',
         poke_UZ = 'Z',
         ["poke_UZ!"] = '!',
         ["poke_UZ?"] = '?',
      },
      -- Unown Card Suits
      suits_plural = {
         poke_Unown = "Unown",
      },
      suits_singular = {
         poke_Unown = "Unown",
      },
   }
}
