SELECT Item1.Code, ITEM1.ID_Group, ITEM1.Value, ITEM2.ID_Group, ITEM2.Value
  FROM Item1
  JOIN Item2 ON Item1.Code = Item2.Code
       AND (Item1.Value = Item2.Value AND Item1.ID_Group NOT IN (SELECT ID FROM [Group] WHERE ByGroup = 1)
             OR 
            (Item1.ID_Group = Item2.ID_Group AND Item1.ID_Group IN (SELECT ID FROM [Group] WHERE ByGroup = 1))
           )