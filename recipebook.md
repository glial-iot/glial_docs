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


## Форматирование строк

string.format("%s %q", "Hello", "Lua user!")
%s string
%q quoted string
%c number to char
%e, %E exponent: 3.141593e+000, 3.141593E+000
%f, %g float and compact float: 3.141593, 3.14159
%d, %i, %u signed, signed, unsigned integer
%o, %x, %X octal, hexadecimal, hexadecimal

## Поиск внутри подстроки


local _, _, space_number = string.find(data_string, "(%d+).+")

`%a` — латинская буква `[A-Za-z]`  
`%с` — контрольные символы  
`%d` — десятичная цифра `[0-9] [0123456789]`  
`%u` — латинская буква верхнего регистра `[A-Z]`  
`%l` — латинская буква нижнего регистра `[a-z]`  
`%p` — знак пунктуации  
`%s` — символ пробела  
`%w` — латинская буква или арабская цифра `[A-Za-z0-9]`  
`%z` — нулевой символ  

`%A` — не латинская буква `[^A-Za-z]`  
`%C` — не контрольные символы  
`%D` — не десятичная цифра `[^%d] [^0-9]`  
`%U` — не латинская буква верхнего регистра `[^A-Z]`  
`%L` — не латинская буква нижнего регистра `[^a-z]`  
`%P` — не знак пунктуации  
`%S` — не символ пробела  
`%W` — не латинская буква и не арабская цифра `[^A-Za-z0-9]`  
`%Z` — не нулевой символ `[^%z]`

`%b` — сбалансированная строка: `%b()` = "(text)", `%b%{%}` = "{text}"  
`.` — любой символ (точка — `%.`)  

Применение квантификаторов `+`/`-`/`*`/`?`:  
`%s` — 1 символ пробела  
`%s+` — 1 или более символов пробела (жадный)  
`%s-` — 0 или более символов пробела (ленивый)  
`%s*` — 0 или более символов пробела (жадный)  
`%s?` — необязательное наличие символа пробела  

`^` — начало строки, `$` — конец строки, `()` — захват  

Символы, которые должны экранироваться %: `( ) . % + - * ? [ ^ $`

## Циклы

for i = 10, 1, 1 do -- цикл от 10 до 1 с шагом 1
   
end

for key, val in pairs(t) do
   
end
