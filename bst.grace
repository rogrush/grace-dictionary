import "node" as _node
import "nullNode" as _nullNode

factory method named(name) {
  //
  // CollectionFactory type
  //
  
  //
  // Enumerable type 
  //
  method iterator() {
    makeIterator("values")
  }
  
  //
  // Dictionary type
  //
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

  method keys() {
    makeIterator("keys")
  }
  
  method values() {
    makeIterator("values")
  }  
  
  method bindings() {
    makeIterator("bindings")
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
  
  method makeIterator(iterateOverWhich) is confidential {
    object {
      
      method next() {
        buildListIfNeeded
        if (internalList.size == 0) then {
          Exhausted.raise "No more elements in iterator: { self }"
        }
        internalList.pop()
      }
      
      method hasNext() {
        buildListIfNeeded
        internalList.size != 0
      }
      
      //
      // Confidential
      //
      var internalList := list.empty
      var isListBuilt := false
      
      method buildList(node) is confidential {
        if (node.asString == "Null node") then { 
          return
        }
        // Iterate over keys, values, or bindings
        if (iterateOverWhich == "keys") then {
          internalList.push(node.key)
        } elseif (iterateOverWhich == "values") then {
          internalList.push(node.value)
        } else {
          internalList.push(node.key::node.value)
        }
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
