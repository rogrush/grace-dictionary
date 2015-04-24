import "node" as _node 

factory method named(name) {
  var root := false
  
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
  
  //
  // Helpers
  //
  method sizeOfNode(node) is confidential {
    if (node == false) then { 0 }
    else { node.n }
  }
  
  method on(node) at(key) put(value) is confidential {
    if (node == false) then {
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
    if (node == false) then {
      NoSuchObject.raise "key not found: {key}"
    }
    var cmp := key.compare(node.key)
    if (key < node.key) then {
      return on(node.left) at(key)
    } elseif (key > node.key) then {
      return on(node.right) at(key)
    } else {
      return node.value
    }
  }
}
