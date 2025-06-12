local _, PER = ...

PER.RACE_TRACKER_BACKGROUNDS = {
  [1] = {
    type = "file",
    width = 256,
    height = 64,
    texture = "race-tracker-background-classic.blp",
    offsetY = {
      timer = 10,
      info = -10
    }
  },
  [2] = {
    type = "atlas",
    width = 467,
    height = 141,
    texture = "AllianceScenario-TitleBG",
    offsetY = {
      timer = 5,
      info = -15
    }
  },
  [3] = {
    type = "atlas",
    width = 467,
    height = 141,
    texture = "HordeScenario-TitleBG",
    offsetY = {
      timer = 5,
      info = -15
    }
  }
}
