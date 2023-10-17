module Enums
  extend ActiveSupport::Concern

  included do
    enum ruleset: { DnD5E: 0, DnDOther: 1, CallOfCthulhu: 2, Pathfinder: 3, Pathfinder2E: 4, 
                    WarhammerFantasy: 5, Warhammer40K: 6, WorldOfDarkness: 7, ApocalyseWorldSystem: 8, 
                    StarWars: 9, Other: 10 }
    enum gender: { male: 0, female: 1, other: 2}
    enum platform: { InPersonHome: 0, InPersonPublic: 1, InPersonOther: 2, FoundryVTT: 3, Roll20: 4, 
                     TableTopSimulator: 5, Astral: 6, FantasyGrounds: 7, TaleSpire: 8, Role: 9, 
                     OneMoreMultiverse: 10, OtherVTT: 11}
  end
end