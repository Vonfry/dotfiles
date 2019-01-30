list1: list2:

let merge = l: i: if ! builtins.elem i l then l ++ [i] else l;
in builtins.foldl' merge list1 list2
