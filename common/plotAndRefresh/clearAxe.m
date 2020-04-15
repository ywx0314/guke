function clearAxe(whichAxe)
delete(findall(whichAxe,'type','scatter'));
delete(findall(whichAxe,'type','line'));
delete(findall(whichAxe,'type','image'));
end