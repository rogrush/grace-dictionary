factory method named(name) withKey(key') andValue(value') containingInSubtree(n') {
  var left is public := false
  var right is public := false
  
  var key is public := key'
  var value is public := value'
  var n is public := n'

  method asString() {
    print ("key: {key}\nvalue: {value}\nnodes in subtree: {n}")
  }
}
