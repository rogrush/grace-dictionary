import "node" as _node
import "nullNode" as _nullNode

factory method named(name) {
  
  method size() {
    sizeOfNode(root)
  }
  
  method isEmpty() {
    size == 0 
  }
  
  method at(key) put(value) {
    root := on(root) at(key) put(value)
  }
  
  method at(key) {
    on(root) at(key)
  }
  
  method values() {
    iterator
  }
  
  //
  // Confidential
  //
  def nullNode = _nullNode.named("Null node")
  
  var root := nullNode
  
  method sizeOfNode(node) is confidential {
    if (node.asString == "Null node") then { 0 }
    else { node.n }
  }
  
  method on(node) at(key) put(value) is confidential {
    if (node.asString == "Null node") then {
      return _node.named("anotherNode") withKey(key) andValue(value) containingInSubtree(1)
    }
    if (key < node.key) then {
      node.left := on(node.left) at(key) put(value)
    } elseif (key > node.key) then {
      node.right := on(node.right) at(key) put(value)
    } else {
      node.value := value      
    }
    node.n := 1 + sizeOfNode(node.left) + sizeOfNode(node.right)
    return node
  }

  method on(node) at(key) is confidential {
    if (node.asString == "Null node") then {
      NoSuchObject.raise "key not found: {key}"
    }
    if (key < node.key) then {
      return on(node.left) at(key)
    } elseif (key > node.key) then {
      return on(node.right) at(key)
    } else {
      return node.value
    }
  }
  
  method iterator() is confidential {
    object {
      
      method next() {
        buildListIfNeeded
        if (valueList.size == 0) then {
          Exhausted.raise "No more elements in iterator: { self }"
        }
        valueList.pop()
      }
      
      method hasNext() {
        buildListIfNeeded
        valueList.size != 0
      }
      
      //
      // Confidential
      //
      var valueList := list.empty
      var isListBuilt := false
      
      method buildList(node) is confidential {
        if (node.asString == "Null node") then { 
          return
        }
        valueList.push(node.value)
        buildList(node.left)
        buildList(node.right)
      }
      
      method buildListIfNeeded() is confidential {
        // Build list on first method call
        if (isListBuilt == false) then {
          buildList(root)
          isListBuilt := true
        }
      }
    }
  }
}
