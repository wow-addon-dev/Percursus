local _, PER = ...

if GetLocale() ~= "ruRU" then return end

local L = PER.localization

-- Generel

L["addon.version"] = "Версия"

-- Addon specific

L["time"] = "Время: %.1f секунд"
L["gold-time"] = "|T616373:0|t Время на золото: %s сек."
L["silver-time"] = "|T616375:0|t Время на серебро: %s сек."
L["bronze-time"] = "|T616372:0|t Время на бронзу"
L["no-time"] = "нет времени на получение медали"

L["gliding-speed"] = "Текущая скорость гонки: %s%%"

L["seconds-long"] = "Секунды"
L["seconds-short"] = "сек."

L["button.close"] = "Закрыть"
L["button.zone-overview"] = "Обзор зоны"

L["title.zone-overview"] = "Обзор зоны"

L["race-normal"] = "Обычный маршрут"
L["race-advanced"] = "Продвинутый маршрут"
L["race-reverse"] = "Обратный маршрут"
L["race-challenge"] = "Испытание"
L["race-challenge-reverse"] = "Испытание обратным маршрутом"
L["race-storm-gryphon"] = "Грифон бури"

L["personal-best-time"] = "Личное лучшее время: %s сек."
L["personal-best-time-no-race"] = "ни одна гонка пока не завершена"
L["personal-best-time-not-available"] = "личный рекорд недоступен"
L["personal-best-time-failed"] = "новый личный рекорд неудачный"

-- Options

L["info.description"] = "Описание"
L["info.description.text"] = "Percursus - это аддон, который отображает таймер во время гонки и предоставляет подробный обзор времени всех завершенных гонок.\n\nЭто дополнение совместимо со всеми типами гонок, такими как езда на драконе, езда на параплане, езда на ракете и головокружительная гонка (D.R.I.V.E.).\n\nЕсли Вы нашли ошибку или у Вас есть вопросы по аддону, то можете связаться со мной через Github. Вы также можете помочь мне с переводом через Github. Спасибо."

L["info.help"] = "Помощь"
L["info.help.text"] = "В случае возникновения проблем после обновления, Вы можете сбросить настройки здесь."
L["info.help.reset-button.name"] = "Сбросить параметры"
L["info.help.reset-button.desc"] = "Сбрасывает параметры на значения по умолчанию. Это относится ко всем персонажам."
L["info.help.github-button.name"] = "GitHub"
L["info.help.github-button.desc"] = "Открывает всплывающее окно со ссылкой на GitHub."

L["info.about"] = "Об аддоне"
L["info.about.text"] = "|cffF2E699Версия игры:|r %s\n|cffF2E699Версия дополнения:|r %s\n\n|cffF2E699Автор:|r %s"

L["options"] = "Параметры"
L["options.general"] = "Общие параметры"

L["options.race-tracker"] = "Race Tracker"
L["options.race-tracker.name"] = "Включить Race Tracker"
L["options.race-tracker.tooltip"] = "Включает Race Tracker во время гонки."
L["options.race-tracker-mode.name"] = "Режим"
L["options.race-tracker-mode.tooltip"] = "Определяет, как будет отображаться время во время гонки."
L["options.race-tracker-mode.value.0"] = "Таймер"
L["options.race-tracker-mode.value.1"] = "Обратный отсчет - Время медалей"
L["options.race-tracker-mode.value.2"] = "Обратный отсчет - Личный рекорд"
L["options.race-tracker-background-type.name"] = "Фон"
L["options.race-tracker-background-type.tooltip"] = "Определяет, какой фон будет использоваться для Race Tracker."
L["options.race-tracker-background-type.value.0"] = "Ничего"
L["options.race-tracker-background-type.value.1"] = "Percursus (Classic)"
L["options.race-tracker-background-type.value.2"] = "Альянс"
L["options.race-tracker-background-type.value.3"] = "Орда"
L["options.race-tracker-background-type.value.4"] = "Вечнозеленый"
L["options.race-tracker-background-type.value.5"] = "Dragonflight"
L["options.race-tracker-background-type.value.6"] = "The War Within"
L["options.race-tracker-horizontal-shift.name"] = "Горизонтальное смещение"
L["options.race-tracker-horizontal-shift.tooltip"] = "Относительное горизонтальное положение Race Tracker по отношению к центру экрана."
L["options.race-tracker-vertical-shift.name"] = "Вертикальное смещение"
L["options.race-tracker-vertical-shift.tooltip"] = "Относительное вертикальное положение Race Tracker по отношению к центру экрана."
L["options.race-tracker-fadeout-delay.name"] = "Задержка затухания"
L["options.race-tracker-fadeout-delay.tooltip"] = "Определяет время после гонки, по истечении которого трекер гонки будет скрыт."
L["options.race-tracker-speed-display.name"] = "Показать скорость гонки"
L["options.race-tracker-speed-display.tooltip"] = "Определяет, должна ли отображаться скорость гонки во время гонки. Этот дисплей работает только для гонок на Драконах и Скайрайдерах."
L["options.race-tracker-speed-display-horizontal-shift.name"] = "Горизонтальный сдвиг"
L["options.race-tracker-speed-display-horizontal-shift.tooltip"] = "Указывает относительное горизонтальное положение отображения скорости гонки относительно центра экрана."
L["options.race-tracker-speed-display-vertical-shift.name"] = "Вертикальный сдвиг"
L["options.race-tracker-speed-display-vertical-shift.tooltip"] = "Указывает относительное вертикальное положение отображения скорости гонки относительно центра экрана."

L["options.race-time-overview"] = "Обзор времени гонки"
L["options.race-time-overview.name"] = "Включить обзор времени гонки"
L["options.race-time-overview.tooltip"] = "Включает обзор времени гонки рядом с окном квеста."

L["options.other"] = "Другие параметры"
L["options.debug-mode.name"] = "Режим отладки"
L["options.debug-mode.tooltip"] = "Если режим отладки включен, то отображается дополнительная информацию в чате."

-- Chat

L["chat.reset-options.success"] = "Параметры успешно сброшены."

-- Dialog

L["dialog.copy-address.text"] = "Чтобы скопировать ссылку, нажмите CTRL + C."
L["dialog.reset-options.text"] = "Вы действительно хотите сбросить настройки?\n|cffFFD200Внимание:|r Интерфейс игры будет автоматически перезагружен!"
