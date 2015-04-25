import "bst" as bst

var dict := bst.named("dictionary")

// size, isEmpty
if (dict.size == 0) then { print ("Okay") } else { print ("Error!") }
if (dict.isEmpty == true) then { print ("Okay") } else { print ("Error!") }

// at(key) put(value)
dict.at("george") put("washington")

if (dict.size == 1) then { print ("Okay") } else { print ("Error!") }
if (dict.isEmpty == false) then { print ("Okay") } else { print ("Error!") }

dict.at("thomas") put("jefferson")
if (dict.size == 2) then { print ("Okay") } else { print ("Error!") }

// at(key)
if (dict.at("george") == "washington") then { 
  print ("Okay") } else { print ("Error!") }
if (dict.at("thomas") == "jefferson") then { 
  print ("Okay") } else { print ("Error!") }
  
// values()
dict.at("john") put("adams")
dict.at("james") put("madison")
dict.at("abraham") put("lincoln")
dict.at("andrew") put("jackson")

// Try a non-string value
dict.at("one") put(1)

var values := dict.values

print ("\n\nValues:\n\n")
while { values.hasNext } do {
  print (values.next)
}
