list:

let
  uniqueList =
    oList: nList:
      if oList != [] then
        let x = builtins.head oList;
            xs = builtins.tail oList;
            nxs =
              if !builtins.elem x nList
              then (nList ++ [x])
              else nList;
         in uniqueList xs nxs
       else nList;
in uniqueList list []

