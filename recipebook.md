# Книга рецептов

## Текущее время

local current_time_s = clock.time()  -- clock.time64()/1000/1000/1000
local current_time_ms = clock.time() * 1000 -- clock.time64()/1000/1000
local current_time_ns = clock.time64() 

## Форматирование времени

local current_time_s = clock.time()
local formatted_time = os.date("%Y-%m-%dT%H:%M", current_time_s) --2018-11-13T20:45

%a	abbreviated weekday name (e.g., Wed)
%A	full weekday name (e.g., Wednesday)
%b	abbreviated month name (e.g., Sep)
%B	full month name (e.g., September)
%c	date and time (e.g., 09/16/98 23:48:10)
%d	day of the month (16) [01-31]
%H	hour, using a 24-hour clock (23) [00-23]
%I	hour, using a 12-hour clock (11) [01-12]
%M	minute (48) [00-59]
%m	month (09) [01-12]
%p	either "am" or "pm" (pm)
%S	second (10) [00-61]
%w	weekday (3) [0-6 = Sunday-Saturday]
%x	date (e.g., 09/16/98)
%X	time (e.g., 23:48:10)
%Y	full year (1998)
%y	two-digit year (98) [00-99]
%%	the character `%´

## Поиск внутри подстроки


local _, _, space_number = string.find(data_string, "(%d+).+")


## Циклы

for i = 10, 1, 1 do -- цикл от 10 до 1 с шагом 1
   MsgBox ("i равно "..i)
end

for key, val in pairs(t) do
   MsgBox ("key == "..key.."; val == "..val)
end
