local _, PER = ...

PER.RACE_TRACKER_BACKGROUNDS = {
  [1] = {
    type = "file",
    width = 256,
    height = 64,
    texture = "race-tracker-background-classic.blp",
    yOffsets = {
      timer = 10,
      info = -10
    }
  },
  [2] = {
    type = "atlas",
    width = 467,
    height = 141,
    texture = "AllianceScenario-TitleBG",
    yOffsets = {
      timer = 5,
      info = -15
    }
  },
  [3] = {
    type = "atlas",
    width = 467,
    height = 141,
    texture = "HordeScenario-TitleBG",
    yOffsets = {
      timer = 5,
      info = -15
    }
  }
}
