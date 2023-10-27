/*
ЗАДАЧА:
Вывести: Code, ITEM1.ID_Group, ITEM1.Value и ITEM2.ID_Group, ITEM2.Value, сопоставленные по группам по следующим правилам:
1) элементы между группами сопоставляются по полю Code (т.е. всегда ITEM1.Code = ITEM2.Code)
2) группы элементов в ITEM1 сопоставляются с элементами группы в ITEM2 по следующему правилу:
	если в соответсвующей записи таблицы GROUP (связь с ITEMx по идентификатору ID_Group) флаг ByGroup = 1
		то: ITEM1 и ITEM2 сопоставляются по ID_Group, Code
		иначе: необходимо сопоставить группы и все их элементы из двух таблиц по значению Value в главном элементе
*/
SELECT Item1.Code, ITEM1.ID_Group, ITEM1.Value, ITEM2.ID_Group, ITEM2.Value
  FROM Item1
  JOIN Item2 ON Item1.Code = Item2.Code
       AND (Item1.Value = Item2.Value AND Item1.ID_Group NOT IN (SELECT ID FROM [Group] WHERE ByGroup = 1)
             OR 
            (Item1.ID_Group = Item2.ID_Group AND Item1.ID_Group IN (SELECT ID FROM [Group] WHERE ByGroup = 1))
           )